from django import forms
from account.models import Account
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm


class RegistrationForm(UserCreationForm):
    class Meta:
        model = Account
        fields = ('username', 'ssn', 'password1', 'password2','isDoctor','isManager','isPatient')


class LoginForm(AuthenticationForm):
    class Meta:
        model = Account
