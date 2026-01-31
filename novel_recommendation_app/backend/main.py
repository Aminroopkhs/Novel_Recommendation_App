from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session

from database import engine, SessionLocal
import models
from schemas import SignupRequest, LoginRequest, AuthResponse
from auth import create_user, authenticate_user
from schemas import GenrePreferenceRequest


app = FastAPI(title="Novel Recommendation Backend")

# Create tables
models.Base.metadata.create_all(bind=engine)


# Dependency to get DB session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@app.get("/")
def root():
    return {"message": "Backend is running"}


# ---------------- SIGNUP ----------------
@app.post("/signup", response_model=AuthResponse)
def signup(request: SignupRequest, db: Session = Depends(get_db)):
    existing_user = db.query(models.User).filter(
        models.User.email == request.email
    ).first()

    if existing_user:
        raise HTTPException(status_code=400, detail="Email already registered")

    user = create_user(
        db=db,
        name=request.name,
        email=request.email,
        password=request.password
    )

    return {
        "user_id": user.id,
        "is_new_user": user.is_new_user
    }


# ---------------- LOGIN ----------------
@app.post("/login", response_model=AuthResponse)
def login(request: LoginRequest, db: Session = Depends(get_db)):
    user = authenticate_user(
        db=db,
        email=request.email,
        password=request.password
    )

    if not user:
        raise HTTPException(status_code=401, detail="Invalid credentials")

    return {
        "user_id": user.id,
        "is_new_user": user.is_new_user
    }

# hardcoded
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


from schemas import GenrePreferenceRequest

@app.post("/user/preferences")
def save_user_preferences(
    request: GenrePreferenceRequest,
    db: Session = Depends(get_db)
):
    # Remove old preferences if any
    db.query(models.UserPreference).filter(
        models.UserPreference.user_id == request.user_id
    ).delete()

    # Save new preferences
    for genre in request.genres:
        pref = models.UserPreference(
            user_id=request.user_id,
            genre=genre
        )
        db.add(pref)

    # Mark user as not new
    user = db.query(models.User).filter(
        models.User.id == request.user_id
    ).first()
    if user:
        user.is_new_user = False

    db.commit()

    return {"message": "Preferences saved successfully"}

@app.get("/novels")
def get_all_novels(db: Session = Depends(get_db)):
    novels = db.query(models.Novel).all()
    return novels


@app.get("/novels/genre/{genre}")
def get_novels_by_genre(genre: str, db: Session = Depends(get_db)):
    novels = db.query(models.Novel).filter(
        models.Novel.genre.ilike(f"%{genre}%")
    ).all()
    return novels
