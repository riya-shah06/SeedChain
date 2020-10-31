from flask import render_template, url_for, flash, redirect, request
from Main.forms import RegisterForm
from Main import app
from datetime import date


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

@app.route("/application_form", methods=['GET', 'POST'])
def application_form():
    form = RegisterForm()
    if form.validate_on_submit():
        lotNumber = form.lotNumber.data
        owner = form.owner.data
        crop = form.crop.data
        variety = form.variety.data
        sourceTagNo = form.sourceTagNo.data
        sourceClass = form.sourceClass.data
        destinationClass = form.destinationClass.data
        sourceQuantity = form.sourceQuantity.data
        growerName = form.growerName.data
        spaName = form.spaName.data
        sourceStorehouse = form.sourceStorehouse.data
        sgID = form.sgID.data
        finYear = form.finYear.data
        season = form.season.data
        landRecordsKhataNo = form.landRecordsKhataNo.data
        landRecordsPlotNo = form.landRecordsPlotNo.data
        landRecordsArea = form.landRecordsArea.data
        cropRegCode = form.cropRegCode.data
        dateOfIssue = date.today()

        ## will be saved on BC
        print("Saving details to blockchain..")
        print("Lot No: ", lotNumber)
        print("Crop Reg Code: ", cropRegCode)
        print("Date: ", dateOfIssue)
        return redirect(url_for('home'))
    return redirect(url_for('application_form'))


