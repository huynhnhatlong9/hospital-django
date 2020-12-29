import json

from django.db import models
from django.db import connections
from django.contrib import messages


# Create your models here.
def get_patient_info(ssn):
    with connections['patient'].cursor() as cursor:
        try:
            cursor.callproc('BN_NHANKHAU_INFO', [ssn])
            thongtin = cursor.fetchall()
        except Exception as e:
            raise e
    with connections['patient'].cursor() as cursor:
        try:
            cursor.callproc('BN_BAOHIEM_INFO', [ssn])
            baohiem = cursor.fetchall()
        except Exception as e:
            raise e
    with connections['patient'].cursor() as cursor:
        try:
            cursor.callproc('CHECK_NOITRU', [ssn])
            if cursor.fetchone():
                loaibenhnhan = 'Nội Trú'
            else:
                loaibenhnhan = 'Ngoại Trú'
        except Exception as e:
            raise e
    return thongtin, baohiem, loaibenhnhan


def capnhatnhankhau(request, data):
    with connections['patient'].cursor() as cursor:
        try:
            cursor.callproc('BN1_NHANKHAU',
                            [request.user.ssn, data['ho'], data['ten'], data['tuoi'], data['dantoc'],
                             data['nghenghiep']])
            return True
        except Exception as e:
            raise e


def capnhatbaohiem(request, data):
    with connections['patient'].cursor() as cursor:
        try:
            cursor.callproc('BN1_BAOHIEM',
                            [request.user.ssn, data['mathe'], data['thoihan'], data['noidangki']])
            return True
        except Exception as e:
            raise e


def proc_BN3(request, data):
    with connections['patient'].cursor() as cursor:
        try:
            cursor.callproc('BN3', [request.user.ssn])
            return cursor.fetchall()
        except Exception as e:
            raise e


def proc_BN5(request, data):
    with connections['patient'].cursor() as cursor:
        try:
            cursor.callproc('BN5', [request.user.ssn])
            return cursor.fetchall()
        except Exception as e:
            raise e


def proc_BN8(request, data):
    with connections['patient'].cursor() as cursor:
        try:
            cursor.callproc('BN8', [request.user.ssn])
            return cursor.fetchall()
        except Exception as e:
            raise e


def proc_BN10(request, data):
    with connections['patient'].cursor() as cursor:
        try:
            cursor.callproc('BN10', [request.user.ssn])
            print(cursor.description)
            return cursor.fetchall()
        except Exception as e:
            raise e
