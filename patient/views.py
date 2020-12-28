from django.shortcuts import render
from patient import models as patient_models


# Create your views here.
def chedothuoc(request):
    data = patient_models.proc_BN3(request, {})
    context = {
        'chedothuoc': data
    }
    return render(request, 'patient/CheDoThuoc.html', context)


def danhsachxetnghiem(request):
    data = patient_models.proc_BN5(request, {})
    context = {
        'danhsachxetnghiem': data
    }
    return render(request, 'patient/DanhSachXetNghiem.html', context)


def chedodinhduong(request):
    data = patient_models.proc_BN10(request, {})
    print(data)
    context = {
        'chedodinhduong': data
    }
    return render(request, 'patient/CheDoDinhDuong.html', context)


def danhsachbacsi(request):
    data = patient_models.proc_BN8(request, {})
    context = {
        'danhsachbacsi': data
    }
    return render(request, 'patient/DanhSachBacSi.html',context)
