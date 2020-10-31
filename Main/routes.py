from flask import render_template, url_for, flash, redirect, request
from Main.forms import RegisterForm, LoginForm, ProfileForm, FetchDetailsForm, BuyerForm
from Main import app
from datetime import date


@app.route("/")
@app.route("/home", methods=["POST", "GET"])
def home():
    login_form = LoginForm()
    profile_form = ProfileForm()
    fetch_form = FetchDetailsForm()

    if login_form.submit_login.data and login_form.validate_on_submit():
        username = login_form.username.data
        choice = login_form.role.data
        if choice =='1':
            return redirect(url_for(''))
        elif choice=='2':
            return redirect(url_for('sca_home'))
        elif choice=='3':
            return redirect(url_for('spa_home'))
        elif choice=='4':
            return redirect(url_for('stl_form'))
        elif choice=='5':
            return redirect((url_for('buyer_form')))
        elif choice=='6':
            return redirect((url_for('home')))
    if profile_form.submit_profile.data and profile_form.validate_on_submit():
        print("Profile Created")
        return redirect(url_for('home'))

    if fetch_form.submit_fetch_form and fetch_form.validate_on_submit():
        lotNumber = fetch_form.lotNumber.data
        applnId = fetch_form.appln_id.data
        return redirect(url_for('fetch_details', applnId=applnId, lotNumber=lotNumber,  **request.args))

    return render_template('home.html', login_form=login_form, profile_form=profile_form, fetch_form=fetch_form)

@app.route("/stl_form")
def stl_form():
    return render_template('stl_form.html')

@app.route("/inspection_form")
def inspection_form():
    return render_template('inspection_form.html')

@app.route("/fetch_details")
def fetch_details():
        return render_template('fetch_details.html', applnId=request.args.get('applnId'), lotNumber=request.args.get('lotNumber'))

@app.route("/sca_home")
def sca_home():
    return render_template('sca_home.html')

@app.route("/spa_home")
def spa_home():
    return render_template('spa_home.html')

@app.route("/farmer_home")
def farmer_home():
    return render_template('farmer_home.html')

@app.route("/marketplace")
def marketplace():
    return render_template('marketplace.html')

@app.route("/buyer_form",  methods=["POST", "GET"])
def buyer_form():
    buyer_form = BuyerForm()
    if buyer_form.validate_on_submit:
        print("Buyer details added")
    return render_template('buyer_form.html', buyer_form=buyer_form)

@app.route("/application_form", methods=['GET', 'POST'])
def application_form():
    form = RegisterForm()
    if form.validate_on_submit():
        print("here 2 ")
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
    return render_template('application_form.html', form=form)


