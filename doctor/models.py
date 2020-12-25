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


def taomoibenhnhan(request, data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('BENHNHAN_DANGKY',
                            [data['mabenhnhan'], data['ho'], data['ten'], data['tuoi'], data['dantoc'],
                             data['nghenghiep'], data['mathe'], data['thoihan'],
                             data['noidangki']])
            return cursor.fetchall()
        except Exception as e:
            raise e


def thembenhnhan(request, data):
    print(data)
    with connections['doctor'].cursor() as cursor:
        try:
            if data['loaibenhnhan'] == 'noitru':
                cursor.callproc('THEM_BENHNHAN_NOITRU',
                                [data['makham'], data['thoigiankham'], data['cakham'], data['mabenhnhan'],
                                 request.user.ssn])
            elif data['loaibenhnhan'] == 'ngoaitru':
                cursor.callproc('THEM_BENHNHAN_NGOAITRU',
                                [data['makham'], data['thoigiankham'], data['cakham'], data['mabenhnhan'],
                                 request.user.ssn])
            return cursor.fetchall()
        except Exception as e:
            raise e


# Thêm Bệnh Án
def thembenhan(request, data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('CHINHSUA_BANT_NV',
                            [data['thoigiannhapvien'], data['makhoa'], request.user.ssn, data['mabenhnhan'],
                             data['sogiuong'],
                             data['sobuong']])
            return cursor.fetchall()
        except Exception as e:
            raise e
#Thêm xét nghiệm
def themxetnghiem(request,data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('CHINHSUA_XN',
                            [data['maxetnghiem'], data['makham'], data['thoigianxetnghiem'],
                             data['tenxetnghiem'],
                             data['nhanxet']])
            return cursor.fetchall()
        except Exception as e:
            raise e

def themphim(request,data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('CHINHSUA_PHIM',
                            [data['maphim'], data['thoigianchup'],request.user.ssn, data['makham'],
                             data['loaiphim'],
                             data['nhanxet']])
            return cursor.fetchall()
        except Exception as e:
            raise e

def proc_BS3(ssn, ngaykham):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('BS3', [ngaykham, ssn])
            return cursor.fetchall()
        except Exception as e:
            print(e)
