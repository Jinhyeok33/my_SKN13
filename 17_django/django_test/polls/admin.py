from django.contrib import admin

# Admin 페이지에 모델, 데이터 테이블 추가하기
from .models import Question, Choice
# Model 의 Field 특성에 맞게 admin 이 짜줄거야 
admin.site.register([Question, Choice])