from django.db import models
from users.models import User


class Note(models.Model):
    title = models.CharField(max_length=100, unique=True, null=False, blank=False)
    body = models.TextField(default='', null=True, blank=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
      return self.title  
