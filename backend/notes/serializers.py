from rest_framework import serializers
from notes.models import Note
from users.serializers import UserSerializer


class NoteSerializer(serializers.Serializer):
    id = serializers.IntegerField(read_only=False, required=False)
    title = serializers.CharField(max_length=100, required=True)
    body = serializers.CharField()
    user = UserSerializer(read_only=True)
    created_at = serializers.DateTimeField(read_only=False, required=False)
    updated_at = serializers.DateTimeField(read_only=False, required=False)

    def create(self, validated_data):
        user = self.context['request'].user
        note = Note.objects.create(
            title=validated_data.get('title'),
            body=validated_data.get('body'),
            user=user
        )
        note.save()
        return note

    def update(self, note, validated_data):
        validated_data.pop('user', None)
        note.title = validated_data.get('title', note.title)
        note.body = validated_data.get('body', note.body)
        note.save()
        return note
