from flask import render_template, url_for, flash, redirect, request
from Main import app

@app.route("/")
@app.route("/home")
def home():
    return render_template('home.html')
