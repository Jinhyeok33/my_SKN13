##################################################################
# streamlit/05_streamlit_chat_exam_session_state_llm_streaming_memory.py
##################################################################
import streamlit as st
from dotenv import load_dotenv
from langchain_openai import ChatOpenAI
from langchain.prompts import ChatPromptTemplate, MessagesPlaceholder
from langchain_core.output_parsers import StrOutputParser
# 기존 대화이력을 고려하는 법 1) 매 순간 지난 대화까지 같이 보내줘 2) 메모리 사용

# 프롬프트 -> LLM 요청 -> 응답 -> chat_message container에 출력

# LLM 모델 생성
@st.cache_resource
def get_llm_model():
    load_dotenv()
    model = ChatOpenAI(model_name='gpt-4o-mini')
    prompt_template = ChatPromptTemplate(
        messages = [
            MessagesPlaceholder(variable_name='history', optional=True),    # 대화 이력
            ('user', '{query}')     # 사용자가 입력한 내용
        ]
    )
    return prompt_template | model | StrOutputParser()
"""
MessagesPlaceholder 대신 아래 꼴의 PromptTemplate으로 전달해도 괜찮아.

# Instruction
{query}
답변에 대해서 응답해주세요.

# ConText
{history}

# Input Data
{query}

"""

model = get_llm_model()     # Chain이 반환 

st.title("Chatbot+session state 튜토리얼")

# Session State를 생성
## session_state: dictionary 구현체. 시작 ~ 종료할 때 까지 사용자 별로 유지되야 하는 값들을 저장하는 곳.

# 0. 대화 내역을 session_state의 "messages":list 로 저장.
# 1. session state에 "messages" key가 있는지 조회(없으면 생성)
if "messages" not in st.session_state:
    st.session_state["messages"] = [] # 대화내용들을 저장할 리스트를 "messages" 키로 저장.

######################################
#  기존 대화 이력을 출력
######################################
message_list = st.session_state['messages']
# 딕셔너리를 튜플 꼴로 바꿔주기 -> MessagesPlaceholder 의 입력꼴에 맞춰주기 위해서 | 인줄~ 알았는데 형식 안바꿔도 되네 
# history_message_list = [(msg_dict['role'], msg_dict['content']) for msg_dict in message_list]  
for message in message_list:
    with st.chat_message(message['role']):
        st.write(message['content'])

# 사용자의 프롬프트(질문)을 입력받는 위젯
prompt = st.chat_input("User Prompt") # 사용자가 입력한 문자열을 반환.

## 대화작업
if prompt is not None:
    # session_state에 messages에 대화내역을 저장.
    st.session_state["messages"].append({"role":"user", "content":prompt})  # 저장해놓고
    with st.chat_message("user"):   # 뿌려줘 
        st.write(prompt)
    
    with st.chat_message("ai"):
        message_placeholder = st.empty() # update가 가능한 container 만들어놔 
        full_message = "" # LLM이 응답하는 토큰들을 저장할 문자열변수.
        for token in model.stream({'query':prompt, 'history':history_message_list}):
            full_message += token # .content -> OutputParser를 사용하면 str으로 반환돼 
            message_placeholder.write(full_message) # 기존 내용을 full_message로 갱신.
            # print(full_message)
            # print("---------------------------------------")
        
        st.session_state["messages"].append({"role":"ai", "content":full_message})   # 다 끝나고 얘도 저장해 
