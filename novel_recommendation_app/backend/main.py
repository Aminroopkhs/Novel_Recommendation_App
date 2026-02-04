from fastapi import FastAPI, Depends, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session

from database import engine, SessionLocal
import models
from schemas import (
    SignupRequest,
    LoginRequest,
    AuthResponse,
    GenrePreferenceRequest,
)
from auth import create_user, authenticate_user

from recommender.bert_recommender import (
    generate_novel_embeddings,
    generate_user_embedding,
    recommend_novels,
)

# ───────────────── APP SETUP ─────────────────
app = FastAPI(title="Novel Recommendation Backend")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # DEV only
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Create tables
models.Base.metadata.create_all(bind=engine)

# ───────────────── DB DEPENDENCY ─────────────────
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# ───────────────── ROOT ─────────────────
@app.get("/")
def root():
    return {"message": "Backend is running"}

# ───────────────── SIGNUP ─────────────────
@app.post("/signup", response_model=AuthResponse)
def signup(request: SignupRequest, db: Session = Depends(get_db)):
    # Check if email already exists
    existing_user = db.query(models.User).filter(
        models.User.email == request.email
    ).first()

    if existing_user:
        raise HTTPException(
            status_code=400,
            detail="Email already registered"
        )

    # Create user
    user = create_user(
        db=db,
        name=request.name,
        email=request.email,
        password=request.password,
    )

    return {
        "user_id": user.id,
        "is_new_user": user.is_new_user,
    }

# ───────────────── LOGIN ─────────────────
@app.post("/login", response_model=AuthResponse)
def login(request: LoginRequest, db: Session = Depends(get_db)):
    user = authenticate_user(
        db=db,
        email=request.email,
        password=request.password,
    )

    if not user:
        raise HTTPException(
            status_code=401,
            detail="Invalid email or password"
        )

    return {
        "user_id": user.id,
        "is_new_user": user.is_new_user,
    }

# ───────────────── GENRES (STATIC FOR NOW) ─────────────────
@app.get("/genres")
def get_available_genres():
    return {
        "genres": [
            "Comedy",
            "Horror",
            "Sci-Fi",
            "Romance",
        ]
    }
@app.get("/user/preferences")
def get_user_preferences(
    user_id: int,
    db: Session = Depends(get_db),
):
    prefs = (
        db.query(models.UserPreference.genre)
        .filter(models.UserPreference.user_id == user_id)
        .all()
    )

    return {
        "genres": [p[0] for p in prefs]
    }


# ───────────────── SAVE USER GENRE PREFERENCES ─────────────────
@app.post("/user/preferences")
def save_user_preferences(
    request: GenrePreferenceRequest,
    db: Session = Depends(get_db),
):
    # Validate user exists
    user = db.query(models.User).filter(
        models.User.id == request.user_id
    ).first()

    if not user:
        raise HTTPException(
            status_code=404,
            detail="User not found"
        )

    # Clear old preferences
    db.query(models.UserPreference).filter(
        models.UserPreference.user_id == request.user_id
    ).delete()

    # Save new preferences
    for genre in request.genres:
        pref = models.UserPreference(
            user_id=request.user_id,
            genre=genre,
        )
        db.add(pref)

    # Mark user as existing (not new anymore)
    user.is_new_user = False

    db.commit()

    return {"message": "Preferences saved successfully"}

# ───────────────── GET ALL NOVELS ─────────────────
@app.get("/novels")
def get_all_novels(db: Session = Depends(get_db)):
    novels = db.query(models.Novel).all()
    return novels

# ───────────────── GET NOVELS BY GENRE ─────────────────
@app.get("/novels/genre/{genre}")
def get_novels_by_genre(genre: str, db: Session = Depends(get_db)):
    novels = db.query(models.Novel).filter(
        models.Novel.genre.ilike(f"%{genre}%")
    ).all()

    if not novels:
        raise HTTPException(
            status_code=404,
            detail="No novels found for this genre"
        )

    return novels

@app.post("/library/add")
def add_to_library(user_id: int, novel_id: int, db: Session = Depends(get_db)):
    exists = db.query(models.UserLibrary).filter_by(
        user_id=user_id, novel_id=novel_id
    ).first()

    if exists:
        return {"message": "Already in library"}

    db.add(models.UserLibrary(user_id=user_id, novel_id=novel_id))
    db.commit()
    return {"message": "Added to library"}


@app.post("/wishlist/add")
def add_to_wishlist(user_id: int, novel_id: int, db: Session = Depends(get_db)):
    exists = db.query(models.UserWishlist).filter_by(
        user_id=user_id, novel_id=novel_id
    ).first()

    if exists:
        return {"message": "Already in wishlist"}

    db.add(models.UserWishlist(user_id=user_id, novel_id=novel_id))
    db.commit()
    return {"message": "Added to wishlist"}

@app.post("/wishlist/remove")
def remove_from_wishlist(user_id: int, novel_id: int, db: Session = Depends(get_db)):
    db.query(models.UserWishlist).filter_by(
        user_id=user_id, novel_id=novel_id
    ).delete()
    db.commit()
    return {"message": "Removed from wishlist"}

@app.post("/library/remove")
def remove_from_library(user_id: int, novel_id: int, db: Session = Depends(get_db)):
    db.query(models.UserLibrary).filter_by(
        user_id=user_id, novel_id=novel_id
    ).delete()
    db.commit()
    return {"message": "Removed from library"}

@app.get("/wishlist/{user_id}")
def get_wishlist(user_id: int, db: Session = Depends(get_db)):
    return (
        db.query(models.Novel)
        .join(models.UserWishlist, models.UserWishlist.novel_id == models.Novel.id)
        .filter(models.UserWishlist.user_id == user_id)
        .all()
    )

@app.get("/library/{user_id}")
def get_library(user_id: int, db: Session = Depends(get_db)):
    return (
        db.query(models.Novel)
        .join(models.UserLibrary, models.UserLibrary.novel_id == models.Novel.id)
        .filter(models.UserLibrary.user_id == user_id)
        .all()
    )

# Recommender
@app.get("/recommend/{user_id}")
def recommend_for_user(user_id: int, db: Session = Depends(get_db)):
    # 1. Get user genres
    prefs = (
        db.query(models.UserPreference.genre)
        .filter(models.UserPreference.user_id == user_id)
        .all()
    )

    user_genres = [p[0] for p in prefs]

    if not user_genres:
        raise HTTPException(status_code=400, detail="User has no preferences")

    # 2. Get all novels
    novels = db.query(models.Novel).all()
    if not novels:
        raise HTTPException(status_code=404, detail="No novels available")

    # 3. Generate embeddings
    novel_embeddings = generate_novel_embeddings(novels)
    user_embedding = generate_user_embedding(user_genres)

    # 4. Recommend
    recommendations = recommend_novels(
        novels,
        novel_embeddings,
        user_embedding,
        top_k=5,
    )

    return {
        "user_id": user_id,
        "recommended": recommendations,
    }
