from flask_wtf import FlaskForm
from flask_wtf.file import FileField, FileAllowed
from wtforms import StringField, PasswordField, SubmitField, BooleanField, IntegerField, TextAreaField
from wtforms.validators import DataRequired,  ValidationError, EqualTo

class RegisterForm(FlaskForm):
    lotNumber = StringField('Lot Number', validators=[DataRequired()])
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
