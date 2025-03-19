#!/bin/sh
python -m venv .venv 
source .venv/bin/activate 
pip install -r requirements.txt
functions-framework --target my_cloud_function --debug