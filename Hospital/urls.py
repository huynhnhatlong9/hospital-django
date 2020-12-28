"""Hospital URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf.urls.static import static
from django.contrib import admin
from django.contrib.auth.views import LogoutView
from django.urls import path

from Hospital import settings
from homepage import views as homepage_view
from account import views as account_view
from doctor import views as doctor_view
from patient import views as patient_view

urlpatterns = [
                  path('', homepage_view.homeView, name='homepage'),
                  path('admin/', admin.site.urls),
                  path('login/', homepage_view.login, name='login'),
                  path('register', homepage_view.register, name='register'),
                  path('logout', LogoutView.as_view(template_name='homepage/HomePage.html'), name='logout'),
                  path('profile', account_view.profile, name='profile'),
                  path('patient/<str:id>/<str:makham>', doctor_view.patient_view, name='patient_info_with_id'),
                  path('patient', doctor_view.patient_view, name='patient_info'),
                  path('moreinfo', doctor_view.more_info, name='more_info'),
                  path('chedothuoc', patient_view.chedothuoc, name='chedothuoc'),
                  path('chedodinhduong', patient_view.chedodinhduong, name='chedodinhduong'),
                  path('danhsachbacsi', patient_view.danhsachbacsi, name='danhsachbacsi'),
                  path('danhsachxetnghiem', patient_view.danhsachxetnghiem, name='danhsachxetnghiem'),
                  path('xetnghiem', doctor_view.xetnghiem, name='xetnghiem'),
                  path('chupphim', doctor_view.chupphim, name='chupphim')
              ] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
