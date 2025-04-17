from re import U
import streamlit as st
      
"""
# Streamlit 개요
- Streamlit은 데이터 분석 결과, 머신러닝 모델 결과등을 빠르게 웹 애플리케이션으로 만들 수 있게 하는 파이썬 라이브러리 이다.

## Streamlit의 주요 특징:

- Python 스크립트만으로 웹 앱을 만들 수 있습니다
    - Streamlit으로 작성된 코드가 실행 시에는 FastAPI(파이썬 웹 프레임워크), React(Javascript Frontend Framework)로 변환되어 실행된다.
- 데이터 시각화 지원: matplotlib, plotly, altair 등 시각화 라이브러리로 작성한 그래프를 화면에 쉽게 출력할 수있다.
- Streamlit homepage: https://streamlit.io/
- Streamlit documentation: https://docs.streamlit.io/

## streamlit app 구현
- 설치
    - `pip install streamlit`
- 파이썬 script로 작성한다.
    - 보통 시작 문서를 구현한 코드는 `app.py` 로 저장한다. 
    - 실행 `streamlit run 실행코드`
"""





# 타이틀 입력
st.title('이것은 타이틀 입니다')

# 이모티콘 입력
## streamlit 지원 이모지: https://streamlit-emoji-shortcodes-streamlit-app-gwckff.streamlit.app/
## OS 지원 이모지: `window키 + .` (맥: `FN키`)(❁´◡`❁)
st.title('즐겁게 합시다. :laughing:')

# Header 입력
st.header('헤더를 입력할 수 있어요! :star2:')

# Subheader 입력
st.subheader('이것은 subheader 입니다 :100:')

# 일반 텍스트 입력
st.text('일반 텍스트입니다. 👌👌')
st.text(10)

# 캡션  입력
st.caption('이것은 캡션입니다.:rainbow:')


####################################
# 다양한 출력함수.
####################################
st.divider() # 줄 긋기
st.header("다양한 출력")

###### 코드 출력
sample_code = '''
def function():
    print('hello, world~!')
'''
st.code(sample_code, language="python") # 언어에 맞는 색상 선택


###### 마크다운 출력
st.markdown('*Streamlit*은 **마크다운 문법을 지원**합니다.')

# 컬러코드: blue, green, orange, red, violet
## :컬러코드[출력할 내용] ex) :blue[안녕하세요.]
st.markdown("컬러코드를 이용해서 텍스트 색을 지정합니다. :green[초록색], **:blue[파란색]**, *:red[빨강색입니다.]*")
st.markdown("Latax를 이용해 출력할 수식은 \$ \$ 로 감싸줍니다. $\cfrac{1}{2}$, :green[$\sqrt{x^2+y^2}=1$]")

###### LaTex 수식 출력 함수. $ $ 로 감쌀 필요없다.
st.latex('\sqrt{x^2+y^2}=1')

# HTML 출력
st.html("<b>볼드체로 출력합니다.</b>")
st.html("<a href='https://www.naver.com'>네이버</a>")

####################################
# st.write() 함수 -> 통합 출력 함수 !
# 위의 출력함수들을 하나로 합친 함수.
####################################
st.divider()  # 선
st.title("st.write() 함수 - Magic 출력함수")

## 가변인자로 출력할 내용들을 나열해서 전달하면 출력된다.
st.write("나이:", str(20), "이름:", "이순신")
st.write(1, 2, 3, 4, 5)  
st.write(3.22, 5e-2)
st.write(True, False)

## 마크다운 출력
st.write("# 제목")
st.write("## 중제목")
st.write("### 소제목")
st.write("""
```python -> 이거 무슨 언어인지 지정해줌줌
def function():
    print("Hello World")
```         
""")
st.write('[구글](https://www.google.com), [네이버](https://www.naver.com)') # 마크다운 링크 쓰는법

## list 출력 - interactive viewer: 확장/접기 형식으로 출력한다.
## html 출력
st.write([1,2,3,4,5])
st.write({'이름':'이순신','나이':20})
st.write("<b>안녕</b>", unsafe_allow_html=True) # html출력

##############################################################
# 상태/결과 출력
## 함수에 따라 다른 배경색을 사용해서 출력한다.
##############################################################
st.success("성공") # 초록색
st.info("정보출력") # 파란색
st.warning(":warning: 경고 :warning:") # 노란색
st.error("에러") # 빨간색
st.exception(KeyError("없는 키입니다."))

#############################################################
# 그래프 출력
# streamlit은 자체 그래프 출력함수를 제공하는 것 외에도 
#  matplotlib, plotly 등 파이썬의 시각화 라이브러리를 지원한다.
#############################################################
import matplotlib.pyplot as plt
import numpy as np

arr = np.random.normal(1, 1, size=100)

## 함수 형식
fig = plt.figure()
plt.hist(arr, bins=30)
fig
# st.pyplot() 이용해 출력. (위에는 magic write)
st.pyplot(fig)