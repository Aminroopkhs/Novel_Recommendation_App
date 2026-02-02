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
