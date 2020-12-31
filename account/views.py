import json

from django.contrib.auth.decorators import login_required
from django.http import JsonResponse
from django.shortcuts import render
from patient import models as patient_model
from doctor import models as doctor_model
from manager import models as manager_model


# Create your views here.
@login_required
def profile(request):
    if request.user.isPatient:
        if request.POST:
            if request.POST['type'] == 'capnhatnhankhau':
                try:
                    patient_model.capnhatnhankhau(request, json.loads(request.POST['data']))
                    respne = JsonResponse({})
                    respne.status_code = 200
                    return respne
                except Exception as e:
                    respne = JsonResponse({"success": False, "error": str(e)})
                    respne.status_code = 403
                    return respne
            # Yeu cau 2
            if request.POST['type'] == 'capnhatbaohiem':
                try:
                    patient_model.capnhatbaohiem(request, json.loads(request.POST['data']))
                    respne = JsonResponse({})
                    respne.status_code = 200
                    return respne
                except Exception as e:
                    respne = JsonResponse({"success": False, "error": str(e)})
                    respne.status_code = 403
                    return respne

        info, baohiem, loaibenhnhan = patient_model.get_patient_info(request.user.ssn)
        return render(request, 'homepage/PatientProfile.html',
                      {'info': info, 'baohiem': baohiem, 'loaibenhnhan': loaibenhnhan})

    elif request.user.isDoctor:
        info = doctor_model.get_doctor_info(request.user.ssn)
        return render(request, 'homepage/DoctorProfile.html', {'info': info})
    elif request.user.isManager:
        info = manager_model.get_manager_info(request.user.ssn)
        return render(request, 'homepage/ManagerProfile.html', {'info': info})
