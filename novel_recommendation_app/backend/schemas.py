from pydantic import BaseModel, EmailStr
from typing import List

class SignupRequest(BaseModel):
    name: str
    email: EmailStr
    password: str


class LoginRequest(BaseModel):
    email: EmailStr
    password: str


class AuthResponse(BaseModel):
    user_id: int
    is_new_user: bool

class GenrePreferenceRequest(BaseModel):
    user_id: int
    genres: List[str]
