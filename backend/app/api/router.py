from fastapi import APIRouter
from .v1 import auth, images, tags

api_router = APIRouter()
api_router.include_router(auth.router,   prefix="/auth",   tags=["auth"])
api_router.include_router(images.router, prefix="/images", tags=["images"])
api_router.include_router(tags.router,   prefix="/tags",   tags=["tags"])
