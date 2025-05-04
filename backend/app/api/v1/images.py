from typing import Annotated
from uuid import uuid4
from fastapi import APIRouter, Depends, UploadFile, Form, HTTPException, status
from sqlalchemy.orm import Session
import os

from app.core.dependencies import get_db, get_current_user
from app import models, schemas
from app.models import User

router = APIRouter()

UPLOAD_DIR = "media"
os.makedirs(UPLOAD_DIR, exist_ok=True)

@router.post("/", response_model=schemas.ImageOut)
async def upload(
    meta: Annotated[str, Form(...)],           # JSON metadane z Fluttera
    file: UploadFile,
    current: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    filename = f"{uuid4()}.jpg"
    dst = os.path.join(UPLOAD_DIR, filename)

    with open(dst, "wb") as out:
        out.write(await file.read())

    img = models.Image(owner_id=current.id, filename=filename)
    db.add(img)
    db.commit(); db.refresh(img)
    return img
