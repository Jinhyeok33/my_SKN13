from django.urls import path

from . import views

# App 고유 Url 파일을 만들어
# 전체 url에서 "polls/" 에 대해 이 파일로 들어오게 만들어놨기에
# 여기서는 polls/ 이후 부분에 매칭을 시켜주면 돼 
urlpatterns = [
    # ex: /polls/ -> 여기로 들어오면
    # view.index -> 이 view 를 실행해
    path("", views.index, name="index"),
    # ex: /polls/5/
    # int 인지 검사하고(converter) question_id(pattern_name) 로 이 값을 넘긴다는 의미
    path("<int:question_id>/", views.detail, name="detail"),
    path("<int:question_id>/results/", views.results, name="results"),
    path("<int:question_id>/vote/", views.vote, name="vote"),
]