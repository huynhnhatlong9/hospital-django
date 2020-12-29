from django.db import models
from django.db import connections


# Create your models here.
def get_manager_info(ssn):
    with connections['manager'].cursor() as cursor:
        query = "select BS_QUANLY.MA_QL, concat(HO, ' ', TEN) as TEN, NAM_QUAN_LY, LUONG,TEN_KHOA, CA_LAM_VIEC from " \
                "BS_QUANLY join NHANVIEN N on BS_QUANLY.MA_QL = N.MA_NV join KHOADIEUTRI K on K.MA_KHOA = N.MA_KHOA " \
                "where BS_QUANLY.MA_QL = '" + str(ssn) + "' "
        cursor.execute(query)
        desc = cursor.description
        column_names = [col[0] for col in desc]
        a = cursor.fetchone()
        if a:
            data = dict(zip(column_names, a))
        else:
            data = None
    return data


def bacsi_cangaykhoa(request, data):
    with connections['manager'].cursor() as cursor:
        try:
            cursor.callproc('CAU1',
                            [data['ca'], data['ngay'], data['khoa']])
            return cursor.fetchall()
        except Exception as e:
            raise e


def bacsi_ngaykhoa(request, data):
    with connections['manager'].cursor() as cursor:
        try:
            cursor.callproc('CAU2',
                            [data['ngay'], data['khoa']])
            return cursor.fetchall()
        except Exception as e:
            raise e


def bacsi_cangay(request, data):
    with connections['manager'].cursor() as cursor:
        try:
            cursor.callproc('CAU3',
                            [data['ca'], data['ngay']])
            return cursor.fetchall()
        except Exception as e:
            raise e


def bacsi_ngay(request, data):
    with connections['manager'].cursor() as cursor:
        try:
            cursor.callproc('CAU4',
                            [data['ngay']])
            return cursor.fetchall()
        except Exception as e:
            raise e


def benhnhanall_cangaykhoa(request, data):
    with connections['manager'].cursor() as cursor:
        try:
            cursor.callproc('CAU5',
                            [data['ca'], data['ngay'], data['khoa']])
            return cursor.fetchall()
        except Exception as e:
            raise e


def benhnhannoitru_cangaykhoa(request, data):
    with connections['manager'].cursor() as cursor:
        try:
            cursor.callproc('CAU6',
                            [data['ca'], data['ngay'], data['khoa']])
            return cursor.fetchall()
        except Exception as e:
            raise e


def benhnhanngoaitru_cangaykhoa(request, data):
    with connections['manager'].cursor() as cursor:
        try:
            cursor.callproc('CAU7',
                            [data['ca'], data['ngay'], data['khoa']])
            return cursor.fetchall()
        except Exception as e:
            raise e


def benhnhannoitru_cangay(request, data):
    with connections['manager'].cursor() as cursor:
        try:
            cursor.callproc('CAU9',
                            [data['ca'], data['ngay']])
            return cursor.fetchall()
        except Exception as e:
            raise e


def benhnhanngoaitru_cangay(request, data):
    with connections['manager'].cursor() as cursor:
        try:
            cursor.callproc('CAU10',
                            [data['ca'], data['ngay']])
            return cursor.fetchall()
        except Exception as e:
            raise e


def xetnghiem_ngaykhoa(request,data):
    with connections['manager'].cursor() as cursor:
        try:
            cursor.callproc('CAU11',
                            [data['ngay'], data['khoa']])
            return cursor.fetchall()
        except Exception as e:
            raise e

def xetnghiem_ngay(request,data):
    with connections['manager'].cursor() as cursor:
        try:
            cursor.callproc('CAU12',
                            [data['ngay']])
            return cursor.fetchall()
        except Exception as e:
            raise e
# Create your models here.
