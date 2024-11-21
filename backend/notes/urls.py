from django.urls import path
from notes.views import (
    NotesView, 
    NoteView
)


app_name = 'notes'

urlpatterns = [
    path('', NotesView.as_view(), name='notes'),
    path('<int:pk>/', NoteView.as_view(), name='note')
]
