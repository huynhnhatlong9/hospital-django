from django.db import models
from django.db import connections


# Create your models here.
def get_manager_info(ssn):
    with connections['manager'].cursor() as cursor:
        try:
            cursor.callproc('QL_INFO', [ssn])
            return cursor.fetchall()
        except Exception as e:
            raise e


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


def xetnghiem_ngaykhoa(request, data):
    with connections['manager'].cursor() as cursor:
        try:
            cursor.callproc('CAU11',
                            [data['ngay'], data['khoa']])
            return cursor.fetchall()
        except Exception as e:
            raise e


def xetnghiem_ngay(request, data):
    with connections['manager'].cursor() as cursor:
        try:
            cursor.callproc('CAU12',
                            [data['ngay']])
            return cursor.fetchall()
        except Exception as e:
            raise e
# Create your models here.
