from datetime import datetime
from uuid import UUID
from pydantic import BaseModel, EmailStr

class Token(BaseModel):
    access_token: str
    token_type: str

# ---------- User ----------
class UserBase(BaseModel):
    email: EmailStr

class UserCreate(UserBase):
    password: str

class UserOut(UserBase):
    id: UUID
    class Config: orm_mode = True

# ---------- Image ----------
class ImageOut(BaseModel):
    id: UUID
    owner_id: UUID
    filename: str
    created: datetime
    class Config: orm_mode = True

# ---------- Tag ----------
class TagBase(BaseModel):
    name: str

class TagCreate(TagBase): pass

class TagOut(TagBase):
    id: int
    class Config: orm_mode = True
