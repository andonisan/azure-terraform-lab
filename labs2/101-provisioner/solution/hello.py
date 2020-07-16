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