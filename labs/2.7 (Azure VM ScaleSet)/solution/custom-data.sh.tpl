#!/bin/bash

# Setup logging
logfile="/home/${user}/custom-data.log"
exec > $logfile 2>&1

python3 -V
sudo apt update
sudo apt install -y python3-pip python3-flask
python3 -m flask --version

sudo cat << EOF > /home/${user}/hello.py
from flask import Flask
import requests

app = Flask(__name__)

import requests
@app.route('/')
def hello_world():
    return """<!DOCTYPE html>
<html>
 <head>
<title>terraform workshop</title>
</head>
<body>
<img src="https://www.plainconcepts.com/wp-content/uploads/2019/09/plain-concepts-logo@2x.png" alt="User Image">
</body>
</html>"""
EOF

chmod +x /home/${user}/hello.py

sudo -b FLASK_APP=/home/${user}/hello.py flask run --host=0.0.0.0 --port=8000
