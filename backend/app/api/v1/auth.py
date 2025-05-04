from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

from app.core.dependencies import get_db
from app.core import security
from app import models, schemas

router = APIRouter()

@router.post("/login", response_model=schemas.Token)
def login(
    form_data: OAuth2PasswordRequestForm = Depends(),
    db: Session = Depends(get_db),
):
    user = db.query(models.User).filter_by(email=form_data.username).first()
    if not user or not security.verify_password(form_data.password, user.hashed_pw):
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST,
                            detail="Invalid credentials")
    token = security.create_access_token({"sub": str(user.id)})
    return {"access_token": token, "token_type": "bearer"}
