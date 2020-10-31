from flask import render_template, url_for, flash, redirect, request
from Main.forms import RegisterForm, LoginForm, ProfileForm, CheckApplicationForm, BuyerForm
from Main import app


import Main.blockchain as blockchain

@app.route("/")
@app.route("/home", methods=["POST", "GET"])
def home():
    login_form = LoginForm()
    profile_form = ProfileForm()
    check_application_form = CheckApplicationForm()

    if login_form.submit_login.data and login_form.validate_on_submit():
        username = login_form.action.data
        choice = login_form.action.data
        if choice=='2':
            return redirect(url_for('application_form'))
        elif choice=='3':
            return redirect(url_for('inspection_form'))
        elif choice=='4':
            return redirect(url_for('stl_form'))
        elif choice=='5':
            return redirect((url_for('buyer_form')))
        elif choice=='6':
            return redirect((url_for('home')))
    if profile_form.submit_profile.data and profile_form.validate_on_submit():
        fname =  profile_form.fname.data
        lname = profile_form.lname.data
        role = profile_form.role.data
        phone_number = profile_form.phoneNumber.data
        email = profile_form.email.data # not used
        blockchain.bc_create_profile(role, fname, lname, phone_number)
        print(f"Profile Created for {role}: {fname} {lname}")

    if check_application_form.submit_appln_id and check_application_form.validate_on_submit():
        applnId = check_application_form.appln_id.data
        return redirect(url_for('fetch_details', applicationId=applnId, **request.args))

    return render_template('home.html', login_form=login_form, profile_form=profile_form, check_application_form=check_application_form)

@app.route("/stl_form")
def stl_form():
    ## sample secret key
    return render_template('stl_form.html')

@app.route("/inspection_form")
def inspection_form():
    return render_template('inspection_form.html')

@app.route("/fetch_details/<applicationId>")
def fetch_details(applicationId):
    return render_template('fetch_details.html', appln_id = applicationId)

@app.route("/buyer_form",  methods=["POST", "GET"])
def buyer_form():
    buyer_form = BuyerForm()
    if buyer_form.validate_on_submit:
        appln_id = int(buyer_form.appln_id.data)
        quantity = int(buyer_form.quantity.data)
        fname = buyer_form.fname.data
        lname = buyer_form.lname.data
        phone_no = buyer_form.phoneNumber.data
        blockchain.buy_seeds(appln_id, quantity, fname, lname, phone_no)
        print("Buyer details added")
    return render_template('buyer_form.html', buyer_form=buyer_form)

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

        args_list = {
            'lotNumber': lotNumber,
            'owner':owner,
            'crop':crop,
            'variety':variety,
            'sourceTagNo':sourceTagNo,
            'sourceClass':sourceClass,
            'destinationClass':destinationClass,
            'sourceQuantity':sourceQuantity,
            'growerName':growerName,
            'spaName':spaName,
            'sourceStorehouse':sourceStorehouse,
            'sgID': sgID,
            'finYear':finYear,
            'season':season,
            'landRecordsKhataNo':landRecordsKhataNo,
            'landRecordsPlotNo':landRecordsPlotNo,
            'landRecordsArea':landRecordsArea,
            'cropRegCode':cropRegCode
        }
        ## will be saved on BC
        print("Registering on blockchain")
        blockchain.generate_application(args_list)
        return redirect(url_for('home'))
    return render_template('application_form.html', form=form)


