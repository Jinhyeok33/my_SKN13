/*목차
SELECT 기본 구문
연산자
WHERE 절
WHERE 절 with and/or
ORDER BY
*/
/* *************************************
SELECT 기본 구문 - 연산자, 컬럼 별칭

  select 컬럼명, 컬럼명 [, .....]  => 조회할 컬럼 지정. *: 모든 컬럼
  from   테이블명                 => 조회할 테이블 지정.

- 컬럼명 [as 별칭] => 컬럼명으로 조회한 것을 별칭으로 보여준다. 
- distinct 컬럼명 => 중복된 결과를 제거한다.

참고: 
- Sql은 대소문자 구분 안함.
- sql문 실행: control+enter
*************************************** */

-- EMP 테이블의 모든 컬럼의 모든 항목을 조회.
select * from emp;

-- EMP 테이블의 직원 ID(emp_id), 직원 이름(emp_name), 업무(job) 컬럼의 값을 조회.
select emp_id, 
	   emp_name, 
	   job # 요소가 길어지면 이렇게도 가능 !
from test_db.emp; # 보기 좋게 절 단위로 끊어 쓰자 !

-- EMP 테이블의 업무(job) 어떤 값들로 구성되었는지 조회. - 동일한 값은 하나씩만 조회되도록 처리.
select distinct job, dept_name # 범주형 컬럼에서 범주값이 어떻게 구성되었는지 확인하기 위해 보통 많이 사용한다.
from emp;					   # 세트로 지정할경우, 세트 전체가 겹치는 값을 제외한다.

-- EMP 테이블에서 emp_id는 직원ID, emp_name은 직원이름, hire_date는 입사일, salary는 급여, dept_name은 소속부서 별칭으로 조회결과를 출력 한다.
select emp_id 		as  노예_id, # as는 쓰든지 말든지~ / underbar는 사용돼
	   emp_name 	as	노예명, 
       hire_date 		"사들인 날짜", # 공백은 안돼....? 된답니다~!@ # 큰 따옴표가 문자열 강제 인식이야
       salary 			가격,
       dept_name 		특기
from emp;

# 값을 다루는 방법에는 연산자와 함수가 존재한다!
/* **************************************
연산자 
- 산술 연산자 
	- +, -, *, /, %, mod(%), div(/) (몫 연산)
- 여러개 값을 합쳐 문자열로 반환
	- concat(값, 값, ...)
- 피연산자가 null인 경우 결과는 null 					# 10 + null = null
- 연산은 그 컬럼의 모든 값들에 일률적으로 적용된다.			# select salary*10 from emp;
- 같은 컬럼을 여러번 조회할 수 있다.						# 정보의 가공이 가능하기 때문에 !
************************************** */


-- EMP 테이블에서 직원의 이름(emp_name), 급여(salary), 급여(salary)을 연봉으로 조회. (곱하기 12)
select emp_name		"직원의 이름",
	   salary		급여,
       salary*12	연봉,
       salary/30	일급,
       salary/30/24	시급
from emp;

-- EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary), 커미션_PCT(comm_pct), 급여에 커미션_PCT를 곱한 값을 조회.
select emp_id			"직원의 ID",
	   emp_name			이름,
       salary			급여,
       comm_pct			커미션_PCT,
       salary*comm_pct	"급여*커미션_PCT"
from emp;

-- 직원 이름(emp_name)과 salary를 조회, salary앞에 '$'를 붙여서 출력
select emp_name					"직원 이름",
	   concat('$ ', salary)		급여			# 앞 칼럼 부분이 결국 출력이야. 출력은 여기를 건드려.
from emp;
# where 20000 salary > 5000; -> 범위는 between !@#!@#!@#



/* *************************************
where 절을 이용한 행 선택 

주의 : mysql은 비교시 대소문자를 가리지 않는다.
      ex) select * from emp where emp_name = 'steven'; Steven 조회된다.
     대소문자 구별해서 비교하게 하려면 컬럼명 앞에 BINARY를 붙인다.
	  ex) where BINARY emp_name = 'Steven' and BINARY job_id='aD_PRES';
      null의 경우 '모르는 값'의 의미를 지니기에 크거나 작은 비교를 할 수 없다.
      ex) select * from emp where emp_name = null (X) -> 등호 하나야
		  select * from emp where emp_name is null (O)
************************************* */

-- EMP 테이블에서 직원_ID(emp_id)가 110인 직원의 이름(emp_name)과 부서명(dept_name)을 조회
select emp_name	 	"직원의 이름",
	   dept_name	'부서명'
from emp
where emp_id = 110;
 
-- EMP 테이블에서 'Sales' 부서에 속하지 않은 직원들의 ID(emp_id), 이름(emp_name),  부서명(dept_name)을 조회.
select emp_id		"직원 ID",
	   emp_name		이름,
       dept_name	부서명
from emp
where dept_name != 'sales'; # 대소문자 안가려 ### 얘도 문자열 가려 ㅠㅠㅠㅠㅠㅠㅠ ㅈㄴ헷갈리넹 / 당연히 문자열인 곳만 그런듯

-- EMP 테이블에서 급여(salary)가 $10,000를 초과인 직원의 ID(emp_id), 이름(emp_name)과 급여(salary)를 조회
select emp_id			"직원의 ID",
	   emp_name 		이름,
	   salary			급여
from emp
where salary > 10000;

-- EMP 테이블에서 커미션비율(comm_pct)이 0.2~0.3 사이인 직원의 ID(emp_id), 이름(emp_name), 커미션비율(comm_pct)을 조회.
select emp_id		ID,
	   emp_name		이름,
       comm_pct		커미션비율
from emp
where comm_pct between 0.2 and 0.3; # 역순은 실제로는 작동하지 않아

-- EMP 테이블에서 업무(job)가 'IT_PROG' 거나 'ST_MAN' 인 직원의  ID(emp_id), 이름(emp_name), 업무(job)을 조회.
select emp_id		ID,
	   emp_name		이름,
       job			업무
from emp
where job in ('IT_PROG', 'ST_MAN'); # 여러 개 중에 고르는 건 논리연산자보다 in 연산자가 나을듯?
# where job = 'IT_PROG' or job = 'ST_MAN'; # 여기도 함수에서 논리연산자는 Bool 값들을 기준으로 봐

-- EMP 테이블에서 직원 이름(emp_name)이 S로 시작하는 직원의  ID(emp_id), 이름(emp_name)을 조회.
select  emp_id		ID,
		emp_name	이름
from emp
where emp_name like 'S%';
# % : 0 글자 이상의 모든 글자들. ex) 'S%'
# _ : 임의의 1 글자 ex) 'S___' = Sara

-- EMP 테이블에서 직원 이름(emp_name)의 세 번째 문자가 “e”인 모든 사원의 이름을 조회
select emp_name
from emp
where binary emp_name like '__e%';

-- EMP 테이블에서 직원의 이름에 '%' 가 들어가는 직원의 ID(emp_id), 직원이름(emp_name) 조회
--    %나 _ 를 검색하는 값으로 사용할 경우. 
select  emp_id,
		emp_name
from emp
where emp_name like '%q%%' escape 'q';

-- EMP 테이블에서 부서명(dept_name)이 null인 직원의 ID(emp_id), 이름(emp_name), 부서명(dept_name)을 조회.
select  emp_id,
		emp_name,
        dept_name
from emp
where dept_name is null; # null은 비교연산자랑 사용하지 못해.. 0 이 아니라 모르는 정보라는 뜻이야

-- EMP 테이블에서 커미션이 있는(comm_pct가 null이 아닌)  직원들을 모든 컬럼값들을 조회
select * from emp
where comm_pct is not null;

-- EMP 테이블에서 업무(job)가 'IT_PROG'인 직원들의 모든 컬럼값들을 조회. 
select * from emp
where job = 'IT_PROG';

-- EMP 테이블에서 2004년에 입사한 직원들의 ID(emp_id), 이름(emp_name), 입사일(hire_date)을 조회.
-- 참고: date/datatime에서 년도만 추출: year(컬럼명)
-- 2004-01-01 ~ 2004-12-31
select emp_id,
	   emp_name,
	   hire_date
from emp
where hire_date between '2004-01-01' and '2004-12-31';
#where year(hire_date) = 2004; # 이건 숫자라 문자열 표기 하든 말든 괜찮아. # 칼럼영역에도 사용가능함


-- EMP 테이블에서 연봉(salary * 12) 이 200,000 이상인 직원들의 모든 정보를 조회.
select *
from emp
where salary*12 > 200000;

/* ******************************************
 WHERE 조건이 여러개인 경우 AND 나 OR 로 조건들을 묶어준다.
 
 AND: 두 조건이 모두 True인 행만 조회
 OR: 두 조건 중 하나이상이 True인 행을 조회
 
 연산 우선순위: AND > OR
 	where 조건1 and 조건2 or 조건3
	  1. 조건 1 and 조건2
	  2. 1결과 or 조건3
 
 or를 먼저 하려면 where 조건1 and (조건2 or 조건3)
 *******************************************/
 
-- EMP 테이블에서 'SA_REP' 업무를 담당하는 직원들 중 급여(salary)가 $9,000인 직원의 직원의 ID(emp_id), 이름(emp_name), 업무(job), 급여(salary)를 조회.
select  emp_id, emp_name, job, salary
from emp
where job = 'SA_REP' 
and salary > 9000;

-- EMP 테이블에서 업무(job)가 'FI_ACCOUNT' 거나 급여(salary)가 $8,000 이상인 직원의 ID(emp_id), 이름(emp_name), 업무(job), 급여(salary)를 조회.
select emp_id, emp_name, job, salary
from emp
where job = 'fi_account' 
or salary > 8000;

-- EMP 테이블에서  'Sales' 부서 직원 중 업무(job)가 'SA_MAN' 이고 급여가 $13,000 이하인 모든 정보를 조회
select * from emp
where dept_name = 'sales' 
and job = 'sa_man' 
and salary < 13000;

-- EMP 테이블에서 업무(job)에 'MAN'이 들어가는 직원들 중에서 부서(dept_name)가 'Shipping' 이고 2005년이후 입사한 
--           직원들의 ID(emp_id), 이름(emp_name), 업무(job), 입사일(hire_date),부서(dept_name)를 조회
select emp_id, emp_name, job, hire_date, dept_name
from emp
where job like '%man%' 
and dept_name = 'shipping' 
and hire_date >= '2005-01-1'; # year 사용 가능 # 공백용 0 은 제외 가능
			# hire_date도 비교가 가능하며 이 역시 문자열로 계산해야한다. 그래야 메소드 사용하지.

-- EMP 테이블에서 업무(job)에 'MAN'이 들어가는 직원들 중에서 'Marketing' 이나 'Sales' 부서에 소속된 직원들의 ID(emp_id), 이름(emp_name), 업무(job), 부서(dept_name)를 조회
select emp_id, emp_name, job, dept_name from emp
where job like '%man%' 
and dept_name in ('marketing', 'sales');
# where job like '%man%' 
# and (dept_name = 'marketing' or dept_name = 'sales');


/* *******************************************************************
order by를 이용한 정렬
- 본래 SQL DB는 자기가 생각하기에 해당하는 Query를 가장 빠르게 구할 수 있는 순서로 데이터를 준다. 이를 무시하는게 order by
- order by절은 select문의 마지막 구문으로 온다.
- order by 정렬기준컬럼 정렬방식 [, ...] 			# 값이 같을 경우 두, 세 번째 정렬 기준 설정
    - 정렬기준컬럼 지정 단위: 컬럼이름, 컬럼의순번(select절의 선언 순서)
     `select salary, hire_date from emp ...` 에서 salary 컬럼 기준 정렬을 설정할 경우. 
     `order by salary 또는 order by 1` 로 작성. # select 하는 칼럼 기준 순서를 적어주는거야'
	 
    - 정렬방식
        - ASC : 오름차순, 기본방식(생략가능)
        - DESC : 내림차순
		
문자열 오름차순 : 숫자 -> 대문자 -> 소문자 -> 한글     # 커지는 순서라기보다 적절한 순서라고 생각하는게 편할듯?
Date 오름차순 : 과거 -> 미래
null 오름차순 : null이 먼저 나온다.  GUIDE: 오라클은 반대.

ex)
order by salary asc, emp_id desc
- salary로 전체 정렬을 하고 salary가 같은 행은 emp_id로 정렬.
******************************************************************* */

--  직원들의 전체 정보를 직원 ID(emp_id)가 큰 순서대로 정렬해 조회
select * from emp
order by emp_id DESC;
# order by 1 DESC; # 인덱스 1부터 매김

--  직원들의 id(emp_id), 이름(emp_name), 업무(job), 급여(salary)를 
--  업무(job) 순서대로 (A -> Z) 조회하고 업무(job)가 같은 직원들은 급여(salary)가 높은 순서대로 2차 정렬해서 조회.
select emp_id, emp_name, job, salary from emp
order by job, salary desc;
# order by 3 asc, 4 desc;

-- 부서명을 부서명(dept_name)의 오름차순으로 정렬해 조회하시오.
select distinct dept_name from emp
order by dept_name asc;

-- 급여(salary)가 $5,000을 넘는 직원의 ID(emp_id), 이름(emp_name), 급여(salary)를 급여가 높은 순서부터 조회
select emp_id, emp_name, salary from emp
where salary > 5000
order by salary desc;


