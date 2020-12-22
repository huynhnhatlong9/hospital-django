import json

from django.db import models
from django.db import connections
from django.contrib import messages


# Create your models here.
def get_patient_info(ssn):
    with connections['patient'].cursor() as cursor:
        cursor.execute(
            "select MA_BN,concat(HO,' ',TEN) as TEN,TUOI,DAN_TOC,NGHE_NGHIEP from BENHNHAN where MA_BN='" + str(
                ssn) + "'")
        desc = cursor.description
        column_names = [col[0] for col in desc]
        a = cursor.fetchone()
        if a:
            thongtin = dict(zip(column_names, a))
        else:
            thongtin = None
        cursor.execute(
            "select MA_THE,THOI_HAN,NOI_DANG_KY from BHYT join BENHNHAN B on B.MA_BN = BHYT.BN where BN='" + str(
                ssn) + "'")
        a = cursor.fetchone()
        if a:
            baohiem = dict(zip(column_names, a))
        else:
            baohiem = None
    return thongtin, baohiem


def proc_BN1(request):
    info = json.loads(request.POST['info'])
    with connections['patient'].cursor() as cursor:
        try:
            cursor.callproc('BN1',
                            [request.user.ssn, info['ho'], info['ten'], info['tuoi'], info['dantoc'],
                             info['nghenghiep'],
                             info['mathe'], info['tgdk'], info['noidangki']])
        except Exception as e:
            raise e


def proc_BN2(request):
    with connections['patient'].cursor() as cursor:
        try:
            cursor.callproc('BN2', [request.user.ssn])
            return cursor.fetchone()
        except Exception as e:
            print(e)


def proc_BN3(request):
    with connections['patient'].cursor() as cursor:
        try:
            cursor.callproc('BN3', [request.user.ssn])
            print(cursor.fetchone())
            return cursor.fetchone()
        except Exception as e:
            print(e)


def proc_BN4(request):
    with connections['patient'].cursor() as cursor:
        try:
            cursor.callproc('BN4', [request.user.ssn])
            print(cursor.fetchone())
            return cursor.fetchone()
        except Exception as e:
            print(e)


def proc_BN5(request):
    with connections['patient'].cursor() as cursor:
        try:
            cursor.callproc('BN5', [request.user.ssn])
            print(cursor.fetchone())
            return cursor.fetchone()
        except Exception as e:
            print(e)


def proc_BN6(request):
    with connections['patient'].cursor() as cursor:
        try:
            cursor.callproc('BN6', [request.user.ssn])
            print(cursor.fetchone())
            return cursor.fetchone()
        except Exception as e:
            print(e)


def proc_BN7(request):
    with connections['patient'].cursor() as cursor:
        try:
            cursor.callproc('BN7', [request.user.ssn])
            print(cursor.fetchone())
            return cursor.fetchone()
        except Exception as e:
            print(e)


def proc_BN8(request):
    with connections['patient'].cursor() as cursor:
        try:
            cursor.callproc('BN8', [request.user.ssn])
            print(cursor.fetchone())
            return cursor.fetchone()
        except Exception as e:
            print(e)


def proc_BN9(request):
    with connections['patient'].cursor() as cursor:
        try:
            cursor.callproc('BN9', [request.user.ssn])
            print(cursor.fetchone())
            return cursor.fetchone()
        except Exception as e:
            print(e)


def proc_BN10(request):
    with connections['patient'].cursor() as cursor:
        try:
            cursor.callproc('BN10', [request.user.ssn])
            print(cursor.fetchone())
            return cursor.fetchone()
        except Exception as e:
            print(e)
