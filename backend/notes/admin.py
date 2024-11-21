from django.contrib import admin
from notes.models import Note


@admin.register(Note)
class NoteAdmin(admin.ModelAdmin):
    list_display = ['id', 'title', 'body', 'user', 'created_at', 'updated_at']
    search_fields = ['title']
