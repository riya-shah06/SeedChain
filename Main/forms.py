from flask_wtf import FlaskForm
from flask_wtf.file import FileField, FileAllowed
from wtforms import StringField, PasswordField, SubmitField, BooleanField, IntegerField, TextAreaField, SelectField
from wtforms.validators import DataRequired,  ValidationError, EqualTo

class RegisterForm(FlaskForm):
    lotNumber = StringField('lotNumber', validators=[DataRequired()])
    owner = StringField('Owner')
    crop = StringField("Crop")
    variety = StringField("Variety")
    sourceTagNo = StringField("Source Tag Number")
    sourceClass = StringField("Source class")
    destinationClass = StringField("Destination Class")
    sourceQuantity = StringField("Source Quantity")
    growerName = StringField("Grower Name")
    spaName = StringField("SPA Name")
    sourceStorehouse = StringField("Source Storehouse")
    sgID = StringField("Seed Grower ID")
    finYear = StringField("Financial Year")
    season = StringField("Season")
    landRecordsKhataNo = StringField("Land Records Khata No.")
    landRecordsPlotNo = StringField("Land Records plot no")
    landRecordsArea = StringField("Land Records Area")
    cropRegCode = StringField("Crop Registration Code")
    submit_application_form = SubmitField("Submit")

class LoginForm(FlaskForm):
    myChoices = [('1', 'Farmer'),('2', 'SCA'),('3', 'SPA'),('4', 'STL'),('5', 'SPP'),('6','Others')]
    role = SelectField(u'Action', choices = myChoices, validators = [DataRequired()])
    username = StringField("Username", validators = [DataRequired()])
    submit_login = SubmitField("Submit")

class ProfileForm(FlaskForm):
    myChoices = [('1', 'Farmer'), ('2', 'Seed Grower'), ('3', 'SPA'), ('4', 'SPP'), ('5','STL'), ('6', 'SCA')]
    role = SelectField(u'Role', choices = myChoices, validators = [DataRequired()])
    fname = StringField("First Name", validators = [DataRequired()])
    lname = StringField("Last Name", validators = [DataRequired()])
    email = StringField("Email", validators = [DataRequired()])
    phoneNumber = StringField("Phone Number", validators = [DataRequired()])
    submit_profile = SubmitField("Submit")

class FetchDetailsForm(FlaskForm):
    appln_id = StringField("Application Id")
    lotNumber = StringField("Lot Number")
    submit_fetch_form = SubmitField("Fetch Details")

class BuyerForm(FlaskForm):
    appln_id = StringField("Application Id", validators=[DataRequired()])
    quantity = StringField("Quantity", validators = [DataRequired()])
    fname = StringField("First Name", validators = [DataRequired()])
    lname = StringField("Last Name", validators = [DataRequired()])
    phoneNumber = StringField("Phone Number", validators = [DataRequired()])
    submit_buyer = SubmitField("Submit")