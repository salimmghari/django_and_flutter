from django.core.exceptions import ValidationError
from django.contrib.auth.password_validation import validate_password
from django.contrib.auth.hashers import make_password
from rest_framework import serializers
from users.models import User


class UserSerializer(serializers.Serializer):
    id = serializers.IntegerField(read_only=True)
    username = serializers.CharField(max_length=100, required=True)
    password = serializers.CharField(max_length=250, write_only=True, required=True)
    created_at = serializers.DateTimeField(read_only=True)
    updated_at = serializers.DateTimeField(read_only=True)

    def validate(self, data):         
        try:
            validate_password(data.get('password'))  
        except ValidationError as error:
            raise serializers.ValidationError(error.messages)
        return super(UserSerializer, self).validate(data)

    def create(self, validated_data):
        password = make_password(validated_data.get('password'))
        user = User.objects.create(
            username=validated_data.get('username'),
            password=password
        )
        return user

    def update(self, user, validated_data):
        password = validated_data.get('password')
        password = make_password(password) if password is not None else user.password
        user.username = validated_data.get('username', user.username)
        user.password = password
        user.save()
        return user
