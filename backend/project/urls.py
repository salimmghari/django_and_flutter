from django.contrib import admin
from django.urls import path, re_path, include
from django.views.static import serve
from django.conf import settings 


admin.site.site_header = 'App Administration'

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/users/', include('users.urls')),
    path('api/notes/', include('notes.urls')),
    re_path(r'^media/(?P<path>.*)$', serve, {'document_root': settings.MEDIA_ROOT}),
    path('<path:resource>', lambda request, resource: serve(request, resource, settings.UI_ROOT)),
    re_path(r'.*', lambda request: serve(request, 'index.html', settings.UI_ROOT))
]
