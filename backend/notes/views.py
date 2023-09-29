from django.http import Http404
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from notes.models import Note
from notes.serializers import NoteSerializer


class NotesView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]	

    def get(self, request):	
        queryset = Note.objects.filter(user=request.user)
        serializer = NoteSerializer(queryset, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    def post(self, request):
        serializer = NoteSerializer(data=request.data, context={'request': request})
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class NoteView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]	

    def get(self, request, pk):
        try:
            note = Note.objects.filter(
                id=pk,
                user=request.user
            ).first()
        except Note.DoesNotExist:
            raise Http404
        serializer = NoteSerializer(note)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    def put(self, request, pk):
        try:
            note = Note.objects.filter(
                id=pk,
                user=request.user
            ).first()
        except Note.DoesNotExist:
            raise Http404
        serializer = NoteSerializer(note, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, pk):
        try:
            note = Note.objects.filter(
                id=pk,
                user=request.user
            ).first()
        except Note.DoesNotExist:
            raise Http404
        note.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
