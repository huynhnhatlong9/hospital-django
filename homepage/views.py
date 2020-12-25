import json

from django.contrib.auth import authenticate, login as alogin
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm
from django.http import JsonResponse
from django.shortcuts import render, redirect
from account.forms import RegistrationForm, LoginForm
from django.db import connections
from django.contrib import messages
from patient import models as patient_model
from doctor import models as doctor_model


# Create your views here.
def check_ssn(ssn, user_type):
    if user_type == 0:
        with connections['patient'].cursor() as cursor:
            cursor.execute("Select MA_BN from BENHNHAN")
            a = cursor.fetchall()
            if ssn not in [x[0] for x in a]:
                return False
        return True
    if user_type == 1:
        with connections['doctor'].cursor() as cursor:
            cursor.execute("Select MA_BS from BACSY")
            a = cursor.fetchall()
            if ssn not in [x[0] for x in a]:
                return False
        return True
    if user_type == 2:
        with connections['manager'].cursor() as cursor:
            cursor.execute("Select MA_QL from BS_QUANLY")
            a = cursor.fetchall()
            if ssn not in [x[0] for x in a]:
                return False
        return True
    return False


def homeView(request):
    if str(request.user) == 'AnonymousUser':
        return render(request, template_name='homepage/HomePage.html')
    if request.user.isPatient:
        if request.POST:
            # Yeu cau 1
            if request.POST['type'] == 'BN1':
                try:
                    patient_model.proc_BN1(request)
                except Exception as e:
                    respne = JsonResponse({"success": False, "error": "Không thể cập nhật"})
                    respne.status_code = 403
                    return respne
            # Yeu cau 2
            if request.POST['type'] == 'BN2':
                data = patient_model.proc_BN2(request)
                res = JsonResponse(data)
                return res
        return render(request, template_name='homepage/PatientHomePage.html')
    if request.user.isDoctor:
        if request.POST:
            if request.POST['type'] == 'themmoibenhnhan':
                try:
                    doctor_model.taomoibenhnhan(request, json.loads(request.POST['data']))
                    res = JsonResponse({"success": True})
                    res.status_code = 200
                    return res
                except Exception as e:
                    res = JsonResponse({'error': str(e)})
                    res.status_code = 403
                    return res
            if request.POST['type'] == 'thembenhnhan':
                try:
                    doctor_model.thembenhnhan(request, json.loads(request.POST['data']))
                    res = JsonResponse({"success": True})
                    res.status_code = 200
                    return res
                except Exception as e:
                    res = JsonResponse({'error': str(e)})
                    res.status_code = 403
                    return res
            if request.POST['type'] == 'thembenhan':
                try:
                    doctor_model.thembenhan(request, json.loads(request.POST['data']))
                    res = JsonResponse({"success": True})
                    res.status_code = 200
                    return res
                except Exception as e:
                    print("loi")
                    res = JsonResponse({'error': str(e)})
                    res.status_code = 403
                    return res
            if request.POST['type']=='themxetnghiem':
                try:
                    doctor_model.themxetnghiem(request, json.loads(request.POST['data']))
                    res = JsonResponse({"success": True})
                    res.status_code = 200
                    return res
                except Exception as e:
                    res = JsonResponse({'error': str(e)})
                    res.status_code = 403
                    return res
            if request.POST['type']=='themphim':
                try:
                    doctor_model.themphim(request, json.loads(request.POST['data']))
                    res = JsonResponse({"success": True})
                    res.status_code = 200
                    return res
                except Exception as e:
                    res = JsonResponse({'error': str(e)})
                    res.status_code = 403
                    return res

            if request.POST['type'] == 'BS3':
                try:
                    data = doctor_model.proc_BS3(request)
                    res = JsonResponse({"success": True, "data": data})
                    res.status_code = 200
                    return res
                except:
                    respne = JsonResponse({"success": False, "error": "Không thể Query"})
                    respne.status_code = 403
                    return respne
        return render(request, template_name='homepage/DoctorHomePage.html')
    if request.user.isManager:
        return render(request, template_name='homepage/ManagerHomePage.html')


def login(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(request, username=username, password=password)

        if user is not None:
            alogin(request, user)
            messages.success(request, 'Đăng nhập thành công!')
            return redirect('homepage')
        else:
            form = LoginForm()
            return render(request, 'homepage/Login.html', {'form': form})
    else:
        form = LoginForm()
        context = {'form': form}
        return render(request, 'homepage/Login.html', context)


def register(request):
    if request.method == 'POST':
        form = RegistrationForm(request.POST)
        if form.is_valid():
            if form.cleaned_data['isPatient']:
                user_type = 0
            elif form.cleaned_data['isDoctor']:
                user_type = 1
            else:
                user_type = 2
            if check_ssn(form.cleaned_data['ssn'], user_type):
                form.save()
                messages.success(request, 'Đăng kí thành công!')
                return redirect('login')
            else:
                messages.error(request, 'SSN không khớp!')
                context = {'form': form}
                return render(request, 'homepage/Register.html', context)
    else:
        form = RegistrationForm()
    context = {'form': form}
    return render(request, 'homepage/Register.html', context)
