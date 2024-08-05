#!/bin/sh
source .venv/bin/activate
uvicorn app:app --reload