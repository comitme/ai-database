from fastapi import FastAPI
from app.api.router import api_router

app = FastAPI()

@app.get("/")
def root():
    return {"status": "ok"}

app.include_router(api_router, prefix="/api/v1")