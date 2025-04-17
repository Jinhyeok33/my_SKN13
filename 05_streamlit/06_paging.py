import streamlit as st

st.title("Page 링크")
st.markdown(
"""
# 기본 방식
- 프로젝트 폴더 아래 pages 디렉토리를 생성하고, 그 아래에 페이지를 저장한다. (예: `pages/page1.py`, `pages/page2.py`)
- sidebar에 페이지 링크가 자동으로 생성된다.
- 시작 파일명의 경우 app.py를 많이 사용한다.
# 명시적으로 페이지가 나오도록 처리
- [st.page_link() 사용](https://docs.streamlit.io/develop/api-reference/widgets/st.page_link)
    - `st.page_link(페이지경로, label="링크 Label")`
"""
)
# st.subheader("링크")
# st.page_link("06_paging.py", label="Home", icon='🏠')
# st.page_link("pages/page1.py", label="Page 1", icon='👍')
# st.page_link("pages/page2.py", label="Page 2")
# st.page_link("pages/page3.py", label="Page 3")
