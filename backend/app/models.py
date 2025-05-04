from sqlalchemy import Column, String, DateTime, ForeignKey, func, Integer
from sqlalchemy.dialects.sqlite import BLOB
from sqlalchemy.orm import declarative_base, relationship
import uuid

Base = declarative_base()

class User(Base):
    __tablename__ = "users"
    id        = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()))
    email     = Column(String, unique=True, index=True, nullable=False)
    hashed_pw = Column(String, nullable=False)
    created   = Column(DateTime, server_default=func.now())
    images    = relationship("Image", back_populates="owner")

class Image(Base):
    __tablename__ = "images"
    id        = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()))
    owner_id  = Column(String, ForeignKey("users.id", ondelete="CASCADE"))
    filename  = Column(String, nullable=False)
    created   = Column(DateTime, server_default=func.now())
    owner     = relationship("User", back_populates="images")
    tags      = relationship("Tag", back_populates="image", cascade="all,delete")

class Tag(Base):
    __tablename__ = "tags"
    id       = Column(Integer, primary_key=True, autoincrement=True)
    image_id = Column(String, ForeignKey("images.id", ondelete="CASCADE"))
    name     = Column(String, index=True)
    image    = relationship("Image", back_populates="tags")
