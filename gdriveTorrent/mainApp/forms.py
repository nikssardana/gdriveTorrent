from django import forms
from django.contrib import auth
from django.contrib.auth.models import User
from .models import *

class loginForm(forms.ModelForm):
    username = forms.CharField(widget=forms.TextInput(attrs={ 'placeholder':'Username','class':'form-control'  }))
    password = forms.CharField(widget=forms.PasswordInput(attrs={ 'placeholder':'Password','class':'form-control' }))
    class Meta:
        model = User
        fields = ['username','password', ]

