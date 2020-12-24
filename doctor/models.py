import json

from django.db import models
from django.db import connections


# Create your models here.
def get_doctor_info(ssn):
    with connections['patient'].cursor() as cursor:
        query = "select MA_BS,concat(HO,' ',TEN) as TEN,TEN_KHOA,CHUYEN_KHOA,LUONG,CA_LAM_VIEC,EXPYEAR from BACSY join " \
                "NHANVIEN N on N.MA_NV = BACSY.MA_BS join KHOADIEUTRI K on K.MA_KHOA = N.MA_KHOA where MA_BS='" + str(
            ssn) + "'; "
        cursor.execute(query)
        desc = cursor.description
        column_names = [col[0] for col in desc]
        a = cursor.fetchone()
        if a:
            data = dict(zip(column_names, a))
        else:
            data = None
    return data


def danhsachbenhnhan(request):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('DANHSACHBENHNHAN', [request.user.ssn])
            return cursor.fetchall()
        except Exception as e:
            print(e)


def proc_BS3(ssn,ngaykham):

    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('BS3', [ngaykham, ssn])
            return cursor.fetchall()
        except Exception as e:
            print(e)
