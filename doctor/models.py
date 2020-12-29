import json

from django.db import models
from django.db import connections


# Create your models here.
def get_doctor_info(ssn):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('BACSI_INFO', [ssn])
            return cursor.fetchall()
        except Exception as e:
            raise e


def danhsachbenhnhan(request):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('DANHSACHBENHNHAN', [request.user.ssn])
            return cursor.fetchall()
        except Exception as e:
            raise e


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


# Thêm xét nghiệm
def themxetnghiem(request, data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('CHINHSUA_XN',
                            [data['maxetnghiem'], data['makham'], data['thoigianxetnghiem'],
                             data['tenxetnghiem'],
                             data['nhanxet']])
            return cursor.fetchall()
        except Exception as e:
            raise e


def themphim(request, data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('CHINHSUA_PHIM',
                            [data['maphim'], data['thoigianchup'], request.user.ssn, data['makham'],
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
            raise e


# (ii.5). Xem các thuốc đã được dùng qua các ngày của mộ`t bệnh nhân nội trú mà mình đã phụ trách.

def danhsachthuoc(request, data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('BS5', [data['mabenhnhan'], request.user.ssn, data['makham']])
            print(cursor.description)
            return cursor.fetchall()
        except Exception as e:
            raise e


# -- (ii.4) XEM CAC CHAN DOAN BENH CUA MOT BENH NHAN MA MINH DA PHU TRACH

def chandoanbenh(request, data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('BS4', [data['mabenhnhan'], request.user.ssn, data['makham']])
            return cursor.fetchall()
        except Exception as e:
            raise e


# -- (ii.6) XEM CAC CHI DINH XET NGHIEM DA LAM QUA CAC NGAY CUA MOT BENH NHAN NOI TRU MA MINH DA PHU TRACH

def danhsachxetnghiem(request, data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('BS6', [data['mabenhnhan'], request.user.ssn, data['makham']])
            return cursor.fetchall()
        except Exception as e:
            raise e


# (ii.7). Xem các chỉ định chụp phim đã làm qua các ngày của một bệnh nhân nội trú mà mình đã phụ trách.

def danhsachchupphim(request, data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('BS7', [data['mabenhnhan'], request.user.ssn, data['makham']])
            return cursor.fetchall()
        except Exception as e:
            raise e


# Thêm Chẩn ĐOán
def themchandoan(request, data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('CHINHSUA_KQCHANDOAN',
                            [data['machandoan'], data['mabenh'], data['makham'], data['noidung'],
                             data['ghichu']])
            return True
        except Exception as e:
            raise e


# Thêm Chế độ Thuốc
def themthuoc(request, data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('THEM_CHEDOTHUOC',
                            [False, data['machandoan'], data['mabenh'], data['makham'], data['mathuoc'],
                             data['lieudung'], data['thoihandung']])
            return True
        except Exception as e:
            raise e


def listbenh(request, data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('LIST_BENH', [])
            return cursor.fetchall()
        except Exception as e:
            raise e


def listthuoc(request, data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('LIST_THUOC', [])
            print(cursor.description)
            return cursor.fetchall()
        except Exception as e:
            raise e


def themthuocmoi(request, data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('THEM_THUOC', [data['mathuoc'], data['tenthuoc'], data['loaithuoc']])
            return True
        except Exception as e:
            raise e


def thembenhmoi(request, data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('THEM_BENH', [data['mabenh'], data['tenbenh'], data['mota']])
            return True
        except Exception as e:
            raise e


def ketquaxetnghiem(request, data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('XEM_XN_MAKHAM_MAXN',
                            [data['makham'], data['maxetnghiem']])
            print(cursor.description)
            return cursor.fetchall()
        except Exception as e:
            raise e


def themketquaxetnghiem(request, data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('CHINHSUA_CHISO',
                            [data['machiso'], data['maxetnghiem'], data['makham'], data['giatri'], data['machisoxn']])
            return True
        except Exception as e:
            raise e


def listbenhnhanofbenh(request, data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('BS8',
                            [data['mabenh'], data['mabacsi']])
            return cursor.fetchall()
        except Exception as e:
            raise e


def listbenhnhanofbenhbatthuong(request, data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('BS9',
                            [data['mabenh'], data['mabacsi']])
            return cursor.fetchall()
        except Exception as e:
            raise e


def xuatvien(request, data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('CHINHSUA_BANT_XV',
                            [data['makhoa'], data['mabacsinhapvien'], data['mabenhnhan'], request.user.ssn,
                             data['thoigianxuatvien'],
                             data['tinhtrang'], data['ghichu']])
            return True
        except Exception as e:
            raise e


def danhsachxuatvien(request, data):
    with connections['doctor'].cursor() as cursor:
        try:
            cursor.callproc('BS10',
                            [request.user.ssn])
            return cursor.fetchall()
        except Exception as e:
            raise e
