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


from django.db import models

# Create your models here.
