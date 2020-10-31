from flask import render_template, url_for, flash, redirect, request
from Main import app


@app.route("/")
@app.route("/home")
def home():
    return render_template('home.html')

@app.route("/fetch_form", methods=["GET", "POST"])
def fetch_form():
    if request.method == "POST":
        lot_number = request.form.get("lot_number")
        if lot_number!= "":
            return render_template('fetch_details.html', message=lot_number)
    return render_template('fetch_form.html')

# @app.route("/fetch_details")
# def fetch_details(msg):
#     return render_template('fetch_details.html', message=msg)

@app.route("/create_profile")
def create_profile():
    return render_template('create_profile.html')

@app.route("/application_form")
def get_application_form():
    return render_template('applicationForm.html')

