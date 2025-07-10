from django.db import models
from django.utils import timezone

class Question(models.Model):
    # 데이터베이스의 컬럼명을 Field 로 정의하는거야 
    # 하나하나의 스키마가 하나하나의 테이블이 될거야
    # 테이블명은 verbose_name or app이름_클래스명
    question_text = models.CharField("question", max_length=200)
    pub_date = models.DateTimeField("date published")
    
    # __str__ 을 통해 장고 내부 이름 지정 등에 사용될 값을 지정 
    def __str__(self):
        return self.question_text
    def was_published_recently(self):
        return f"{timezone.now()-self.pub_date} 이전에 생성되었습니다."

class Choice(models.Model):
    question = models.ForeignKey(
        to=Question,
        on_delete=models.CASCADE
    )
    choice_text = models.CharField("choice", max_length=200)
    votes = models.IntegerField("votes", default=0)

    def __str__(self):
        return self.choice_text