from django.contrib.auth.models import BaseUserManager, AbstractBaseUser,PermissionsMixin
from django.db import models


# Create your models here.
class MyAccountManager(BaseUserManager):
    def create_user(self, username, ssn, password=None):
        if not ssn:
            raise ValueError('User must have SSN!')
        if not username:
            raise ValueError('User must have username!')
        user = self.model(
            username=username,
            ssn=ssn
        )
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, username, ssn, password):
        user = self.create_user(username, ssn, password)
        user.isPatient = True
        user.isDoctor = True
        user.isManager = True
        user.is_admin = True
        user.is_superuser = True
        user.save(using=self._db)
        return user


class Account(AbstractBaseUser):
    username = models.CharField(max_length=50, unique=True)
    ssn = models.CharField(max_length=30)
    isPatient = models.BooleanField(default=False)
    isDoctor = models.BooleanField(default=False)
    isManager = models.BooleanField(default=False)
    is_admin = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=True)
    is_active = models.BooleanField(default=True)
    is_superuser = models.BooleanField(default=False)
    object = MyAccountManager()
    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['ssn']

    def __str__(self):
        return self.username

    def has_perm(self, perm, obj=None):
        return self.is_admin

    def has_module_perms(self, app_label):
        return True
