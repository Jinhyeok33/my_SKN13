# polls/models.py

from django.db import models

# Model class ------- DB Table
## DB 테이블 당 Model Class 를 정의해야한다.
## django.db.models.Model 을 상속
## class 변수로 DB Table의 컬럼과 연결된 변수들(Field)을 선언.
#### - 변수명(컬럼명) = ModelField(typep, 제약조건 등 설정)

# Quenstion (설문의 질문을 저장할 Model(table))
class Question(models.Model):
    # Model Field 를 선언
    # question_text(질문) - varchar(문자열) - max length: 200
    question_text = models.CharField(max_length=200)    # CharField = varchar
    # pub_data (질문 등록 일시) - datetime
    pub_date = models.DateTimeField(auto_now_add=True)  # DataTimeField = datatime
    # auto_now_add - 처음 insert 할 때 시점의 일시를 자동으로 저장
    # auto_now - insert/update 할 때 시점의 일시를 자동으로 저장 

    # default : not null. Field에서 nullable 설정 -> null=True
    def __str__(self):
        # 모델의 instance를 출력 / 문자열로 변환할 때 나올 값을 str로 반환.
        # self.Field 명 -> Field(DB Table 컬럼)의 값
        return f'{self.pk}. {self.question_text}'
    
# Choice(질문의 보기들을 저장할 Model)
class Choice(models.Model):

    choice_text = models.CharField(max_length=200)  # 보기 문장
    votes = models.IntegerField(default=0)     # insert 할 때 값을 넣지 않으면 저장할 기본값을 설정(default)
    question = models.ForeignKey(
        Question,   # 참조 모델 클래스
        on_delete=models.CASCADE    # 부모 테이블에서 참조하는 값이 삭제되면 같이 삭제. (models.SET_NULL - NULL로 업데이트)
    )
    # FK 설정 - ForeignKey(참조 Model 클래스, on_delete 설정)
    # class Meta:
    #   db_table="테이블이름"
    def __str__(self):
        return f'{self.pk}. {self.choice_text}'

# python manage.py makemigrations [app이름]
# python manage.py migrate

