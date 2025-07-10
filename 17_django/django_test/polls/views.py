from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader

# views 란 파이썬 함수로 지정된 하나하나의 페이지에 해당한다.
# 이 함수를 통해 HttpResponse 값을 반환받아 페이지에 뿌려주는 것.
# 1) HttpResponse를 반환하거나 2) Http404 같은 Exception 을 발생시켜줘야해

# 전체 질문 목록
from .models import Question
def index(request):
    question_list = Question.objects.order_by(("-pub_date"))
    output = ", ".join([q.question_text for q in question_list])
    return HttpResponse(output)

# 각 질문
def detail(request, question_id):
    return HttpResponse(f"You're looking at question {question_id}.")

# 각 질문 결과
def results(requets, question_id):
    response = f"You're looking at the results of question {question_id}"
    return HttpResponse(response)

# 각 질문 투표 결과
def vote(request, question_id):
    return HttpResponse(f"You're voting on question {question_id}")