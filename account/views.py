from django.contrib.auth.decorators import login_required
from django.shortcuts import render
from patient import models as patient_model
from doctor import models as doctor_model
from manager import models as manager_model


# Create your views here.
@login_required
def profile(request):
    if request.user.isPatient:
        info, baohiem = patient_model.get_patient_info(request.user.ssn)
        return render(request, 'homepage/PatientProfile.html', {'info': info,'baohiem':baohiem})
    elif request.user.isDoctor:
        info = doctor_model.get_doctor_info(request.user.ssn)
        return render(request, 'homepage/DoctorProfile.html', {'info': info})
    elif request.user.isManager:
        info = manager_model.get_manager_info(request.user.ssn)
        return render(request, 'homepage/ManagerProfile.html', {'info': info})
