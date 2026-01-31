from sqlalchemy import Column, Integer, String, Boolean, ForeignKey
from database import Base


# -------------------- USERS --------------------
class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    email = Column(String, unique=True, index=True, nullable=False)
    password = Column(String, nullable=False)
    is_new_user = Column(Boolean, default=True)


# -------------------- NOVELS --------------------
class Novel(Base):
    __tablename__ = "novels"
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    author = Column(String, nullable=True)
    genre = Column(String, nullable=False)
    tropes = Column(String, nullable=True)
    image_url = Column(String, nullable=True)
    synopsis = Column(String, nullable=True)
    rating = Column(String, nullable=True)
    rated_by = Column(String, nullable=True)


# -------------------- USER PREFERENCES --------------------
class UserPreference(Base):
    __tablename__ = "user_preferences"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    genre = Column(String, nullable=False)


# -------------------- USER–NOVEL INTERACTIONS --------------------
class UserNovelInteraction(Base):
    __tablename__ = "user_novel_interactions"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    novel_id = Column(Integer, ForeignKey("novels.id"))
    status = Column(String, nullable=False)   # wishlist | reading | completed
    liked = Column(Boolean, default=False)
