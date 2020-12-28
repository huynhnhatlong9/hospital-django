import json

from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse

from doctor import models
from patient import models as patient_model
from jsonmerge import merge


# Create your views here.
@csrf_exempt
def patient_view(request, id=None, makham=None):
    if id and request.method == 'GET':
        patient_info, baohiem, loaibenhnhan = patient_model.get_patient_info(id)
        danhsachthuoc = models.danhsachthuoc(request, {'mabenhnhan': id, 'makham': makham})
        chandoanbenh = models.chandoanbenh(request, {'mabenhnhan': id, 'makham': makham})
        danhsachxetnghiem = models.danhsachxetnghiem(request, {'mabenhnhan': id, 'makham': makham})
        danhsachchupphim = models.danhsachchupphim(request, {'mabenhnhan': id, 'makham': makham})
        context = {
            'patient_info': patient_info,
            'makham': makham,
            'loaibenhnhan': loaibenhnhan,
            'danhsachthuoc': danhsachthuoc,
            'chandoanbenh': chandoanbenh,
            'danhsachxetnghiem': danhsachxetnghiem,
            'danhsachchupphim': danhsachchupphim
        }
        print(context)
        return render(request, 'patient/PatientDetail.html', context)
    if request.POST:
        if request.POST['type'] == 'date_filter':
            data1 = json.loads(request.POST['data'])
            try:
                data = models.proc_BS3(request.user.ssn, data1['date'])
                res = JsonResponse({'data': data})
                res.status_code = 200
                return res
            except Exception as e:
                res = JsonResponse({'error': str(e)})
                res.status_code = 403
                return res
        if request.POST['type'] == 'themchandoan':
            try:
                data = merge(json.loads(request.POST['data']), {'makham': makham})
                models.themchandoan(request, data)
                res = JsonResponse({'success': True})
                res.status_code = 200
                return res
            except Exception as e:
                res = JsonResponse({'error': str(e)})
                res.status_code = 403
                return res
        if request.POST['type'] == 'themthuoc':
            try:
                data = merge(json.loads(request.POST['data']), {'makham': makham})
                models.themthuoc(request, data)
                res = JsonResponse({'success': True})
                res.status_code = 200
                return res
            except Exception as e:
                res = JsonResponse({'error': str(e)})
                res.status_code = 403
                return res
        if request.POST['type'] == 'xemketquaxetnghiem':
            try:
                data = models.ketquaxetnghiem(request, json.loads(request.POST['data']))
                res = JsonResponse({'success': True, 'data': data})
                res.status_code = 200
                return res
            except Exception as e:
                res = JsonResponse({'error': str(e)})
                res.status_code = 403
                return res
        if request.POST['type'] == 'themketquaxetnghiem':
            try:
                print(request.POST['data'])
                models.themketquaxetnghiem(request, json.loads(request.POST['data']))
                res = JsonResponse({'success': True})
                res.status_code = 200
                return res
            except Exception as e:
                res = JsonResponse({'error': str(e)})
                res.status_code = 403
                return res
    data = models.danhsachbenhnhan(request)
    return render(request, 'homepage/PatientInfo.html', {'data': data})


@csrf_exempt
def more_info(request):
    listbenh = models.listbenh(request, {})
    listthuoc = models.listthuoc(request, {})
    context = {
        'listbenh': listbenh,
        'listthuoc': listthuoc
    }
    if request.POST:
        if request.POST['type'] == 'themthuoc':
            try:
                models.themthuocmoi(request, json.loads(request.POST['data']))
                res = JsonResponse({})
                res.status_code = 200
                return res
            except Exception as e:
                res = JsonResponse({'error': str(e)})
                res.status_code = 403
                return res

        if request.POST['type'] == 'thembenh':
            try:
                models.thembenhmoi(request, json.loads(request.POST['data']))
                res = JsonResponse({})
                res.status_code = 200
                return res
            except Exception as e:
                res = JsonResponse({'error': str(e)})
                res.status_code = 403
                return res

        if request.POST['type'] == 'list-benhnhan-of-benh':
            try:
                data = models.listbenhnhanofbenh(request, json.loads(request.POST['data']))
                res = JsonResponse({'success': True, 'data': data})
                res.status_code = 200
                return res
            except Exception as e:
                res = JsonResponse({'error': str(e)})
                res.status_code = 403
                return res
        if request.POST['type'] == 'list-benhnhan-of-benh-batthuong':
            try:
                data = models.listbenhnhanofbenhbatthuong(request, json.loads(request.POST['data']))
                res = JsonResponse({'success': True, 'data': data})
                res.status_code = 200
                return res
            except Exception as e:
                res = JsonResponse({'error': str(e)})
                res.status_code = 403
                return res
    return render(request, 'homepage/DoctorExtra.html', context)


@csrf_exempt
def xetnghiem(request):
    return render(request, 'doctor/XetNhiem.html')


@csrf_exempt
def chupphim(request):
    return render(request, 'doctor/ChupPhim.html')
