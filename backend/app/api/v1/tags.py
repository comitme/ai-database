from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.core.dependencies import get_db, get_current_user
from app import models, schemas
from app.models import User

router = APIRouter()

@router.post("/", response_model=schemas.TagOut)
def create_tag(
    tag: schemas.TagCreate,
    db: Session = Depends(get_db),
    _: User = Depends(get_current_user)
):
    db_tag = models.Tag(name=tag.name)
    db.add(db_tag); db.commit(); db.refresh(db_tag)
    return db_tag

@router.get("/", response_model=list[schemas.TagOut])
def list_tags(
    db: Session = Depends(get_db),
    _: User = Depends(get_current_user)
):
    return db.query(models.Tag).all()
