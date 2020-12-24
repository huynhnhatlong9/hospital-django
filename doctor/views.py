import json

from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse

from doctor import models


# Create your views here.
@csrf_exempt
def patient_view(request, id=None):
    if id:
        pass
    if request.POST:
        if request.POST['type'] == 'date_filter':
            data1 = json.loads(request.POST['data'])
            try:
                data = models.proc_BS3(request.user.ssn, data1['date'])
                res = JsonResponse({'data': data})
                res.status_code = 200
                return res
            except Exception as e:
                print(e)
                res = JsonResponse({'error': 'Không Query được !'})
                res.status_code = 403
                return res
    data = models.danhsachbenhnhan(request)
    return render(request, 'homepage/PatientInfo.html', {'data': data})
