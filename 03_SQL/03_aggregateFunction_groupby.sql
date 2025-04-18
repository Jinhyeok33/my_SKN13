/*목차
다중행 함수(집계함수)
GROUP BY 절
HAVING 절
*/
/* ******************************************************************************************
# 집계함수, 그룹함수, 다중행 함수
- 얘네도 함수야. 출력부(select 뒤)에 적어줘

- 인수(argument)는 컬럼.
  - sum(): 전체합계
  - avg(): 평균
  - min(): 최소값
  - max(): 최대값
  - stddev(): 표준편차
  - variance(): 분산
  - count(): 개수
        - 인수: 
            - 컬럼명: null을 제외한 값들의 개수.
            -  *: 총 행수 - null과 관계 없이 센다.
  - count(distinct 컬럼명): 고유값의 개수.
  
- count(*) 를 제외한 모든 집계함수들은 null을 제외하고 집계한다. 
	- (avg, stddev, variance는 주의)
	- avg(), variance(), stddev()은 전체 개수가 아니라 null을 제외한 값들의 평균, 분산, 표준편차값이 된다.=>avg(ifnull(컬럼, 0))
- 문자타입/일시타입: max(), min(), count()에만 사용가능
	- 문자열 컬럼의 max(): 사전식 배열에서 가장 마지막 문자열, min()은 첫번째 문자열. 
	- 일시타입 컬럼은 오래된 값일 수록 작은 값이다.

******************************************************************************************* */

-- EMP 테이블에서 급여(salary)의 총합계, 평균, 최소값, 최대값, 표준편차, 분산, 총직원수를 조회 
select sum(salary),
	   avg(salary),
       min(salary),
       max(salary),
       stddev(salary),
       variance(salary),
       count(*) # 이렇게 하면 'null'인 값도 개수로 세 !
from emp;

-- EMP 테이블에서 가장 최근 입사일(hire_date)과 가장 오래된 입사일을 조회
select max(hire_date) as '가장 최근 입사일',
	   min(hire_date) as '가장 오래된 입사일'
from emp;

-- EMP 테이블의 부서(dept_name) 의 개수를 조회
select count(distinct dept_name) as '부서의 개수'
from emp;
select distinct ifnull(dept_name, 'a') # 결측치를 다른 값으로 바꿔서 카운트해 줄 수 있다.
from emp;

--  커미션 비율(comm_pct)이 있는 직원의 수를 조회
select count(comm_pct) 
from emp;
# where comm_pct is not null; # null 값은 어차피 count가 안 먹어서 조건 필요 없어 ㅜ

--  최고 급여액과 최저 급여액 그리고 그 둘의 차액을 출력
select max(salary) - min(salary) from emp; # SQL의 자동 자료형 조정 -> 연산자 막 써도 됨 ㅋ

-- 가장 긴 직원 이름(emp_name)이 몇글자 인지 조회.
select char_length(max(emp_name)) as '가장 긴 직원 이름의 글자수'
from emp;
select max(char_length(emp_name)) # 둘 다 될 것 같았어 ㅋ
from emp;


/* **************
group by 절
- 집계 함수와 같이 써야겠죠?
- 특정 컬럼(들)의 값별로 행들을 나누어 집계할 때 기준컬럼을 지정하는 구문. (~~별 ~~에대한 집계)
	- 예) 업무별 급여평균. 부서-업무별 급여 합계. 성별 나이평균
- 구문
  - group by 컬럼명 [, 컬럼명] # 여러 칼럼이 다 같은 애들끼리 grouping 할 때 여러 개 적어줘
    - 컬럼명
      - 집계를 위해 group으로 묶어줄 기준 컬럼명을 지정한다.
      - select절에 기준컬럼을 지정한 경우 컬럼 순번(1부터 시작)으로 지정할 수있다. # order by 때 처럼
      - 지정한 기준 컬럼(들)이 같은 값을 가지는 행들이 같은 그룹으로 묶인다.
      - 같은 그룹으로 묶인 행들의 값을 기준으로 집계한다.
      - 기준 컬럼은 범주형 컬럼을 사용한다. 부서별 급여 평균 => 부서컬럼, 성별 급여 합계 => 성별컬럼
			# 상식적으로 알아서 group을 지어야 한다는 뜻
	- group by 절은 select의 where 절 다음에 기술한다.
			# 얘네를 고를건데 그중에 이런 애들만 고를건데 그 애들을 이 기준으로 묶어서 봐 ! 이 순서가 아무리봐도 정상이져?
	- select 절의 컬럼은 group by 에서 선언한 기준 컬럼들만 집계함수와 같이 올 수 있다.
	
****************/

-- 업무(job)별 급여의 총합계, 평균, 최소값, 최대값, 표준편차, 분산, 직원수를 조회
select job,				 # group by 의 기준이 되는 칼럼을 넣어줘야 출력 화면을 보기가 편해
	   # emp_name,		 # 이런 애들은 grouping 기준에 안 맞아서 같이 출력 못한다는 점.
	   sum(salary),
	   avg(salary),
       min(salary),
       max(salary),
       stddev(salary),
       variance(salary)
from emp
group by job; # job이 같은 아이들 끼리 집계함수 작동

select job, count(*) as '직원수' # 이러면 job이 같은 애들끼리 count(*)를 세는거야
from emp
group by job
order by 2 desc;

-- 입사연도 별 직원들의 급여 평균.
select year(hire_date),
	   round(avg(salary))	as '평균 급여' # round와 as 는 보기편하려면 습관적으로...
from emp
group by year(hire_date);	# 함수가 처리한 최종 결과(year)가 같은 행끼리 group으로 묶는다.


-- 부서명(dept_name) 이 'Sales'이거나 'Purchasing' 인 직원들의 업무별 (job) 직원수를 조회. 직원수가 많은 순서대로 정렬.
select # dept_name, # 이런걸 기준이 안맞아서 못 쓴다 ~
	   job,
	   count(*) as '직원 수'
from emp
where dept_name in ('Sales', 'Purechasing') # 여기 대괄호 쓰는거 아니야.. 그만 실수해..
group by job
order by 2 desc;

-- 부서(dept_name), 업무(job) 별 최대, 평균급여(salary)를 조회.
select dept_name,
	   job,
       max(salary),
       avg(salary)
from emp
group by dept_name, job; # 둘 다 같은 애들

-- **어려움** 급여(salary) 범위별 직원수를 출력. 급여 범위는 10000 미만,  10000이상 두 범주.
# group by 등 범주를 다루는 곳에는 '값'밖에 못 들어가.. salary>10000 등의 표현식이 안돼
# 그럼 어떡해? 저걸로 값을 미리 만들어서 범주에 넣어줘
select if(salary < 10000, '만 미만', '만 이상'), # 위 범위에 따라 두 개의 '값'이 나올 거임
	   count(*) as '직원수'
from emp
group by if(salary < 10000, '만 미만', '만 이상');

-- 부서명(dept_name), 업무(job)별 직원수, 최고급여(salary)를 조회. 부서이름으로 오름차순 정렬.
select dept_name,
	   job,
       count(*),
       max(salary)
from emp
group by dept_name, job
order by 1 asc; # null 값이 다른 모든 값보다 우선 정렬 돼

-- 입사년도와(hire_date) 업무(job)가 같은 직원들의 평균 급여(salary)을 조회
select year(hire_date), # 이거 year 안쓰면 기준 달라져서 못 써
	   job,
       avg(salary)
from emp
group by year(hire_date), job;

-- 부서별(dept_name) 직원수 조회하는데 부서명(dept_name)이 null인 것은 제외하고 조회.
select dept_name,
	   count(*) as '직원수'
from emp
where dept_name is not null
group by 1;			 # ~ by 면 아까 이렇게도 쓸 수 있다 했죠?


/* **************************************************************
having 절
- group by 로 나뉜 그룹을 filtering 하기 위한 조건을 정의하는 구문.
- 이렇게 저렇게 나뉜 그룹들 중에서~ 너네 그룹은 탈락이야~
- where 절은 해당하는 '데이터, 행'을 떨구는거고 얘는 '그룹'을 떨구는거야
- group by 다음 order by 전에 온다.
- 구문
    having 제약조건  
		- 연산자는 where절의 연산자를 사용한다. -> 연산자... 함수... 등?
		- 피연산자는 집계함수(의 결과) -> 당연히 그룹을 떨구는 거니까 그룹별로 같은 이 값을 받아서 써야겠죠?
        - group by 에 의해 나눠진 그룹들에 대해 그룹 구성원들이 같은 값을 가져야 having 절에 사용할 수 있다고 생각하자.
        - 집계함수, 혹은 분류 기준이 되는 칼럼에 대한 연산자나 함수만이 사용 가능하다.
		
-  where절은 행을 filtering한다.
   having절은 group by 로 묶인 그룹들을 filtering한다.		
************************************************************** */

-- 직원수가 10명 이상인 부서의 부서명과 그 부서 직원들의 평균 급여를 조회.
select dept_name,
	   #count(*) as '직원수',
	   round(avg(salary)) as '평균 급여'
from emp
group by 1
having count(*)>10; # 그룹별로 count(*) 값 되잖아? -> having 절에 사용 가능
					# 만약 avg, count, 등등 집계함수를 안쓰면?
#having year(hire_date) > 2005; # 얘는 다른 칼럼이라 안돼
#having avg(year(hire_date) > 2005; # 얘는 집계함수라서 가능
#having dept_name = 'Sales'; # 얘는 집계함수 아니지만 기준 칼럼이라서 가능


-- 20명 이상이 입사한 년도와 (그 해에) 입사한 직원수를 조회.
select year(hire_date) as '입사년도',
	   count(*) as '직원수'
from emp
group by 1
having count(*) >= 20 # 여기는 숫자로 대체 불가능
order by 1;


-- 평균 급여가(salary) $5000 이상인 부서의 이름(dept_name)과 평균 급여(salary), 직원수를 조회
select dept_name as '부서이름',
	   count(*) as '직원 수',
       concat('$ ', round(avg(salary))) as '평균 급여' # 쓸 수 있는거 다 써버려~
from emp
group by 1
having avg(salary) >= 5000;

-- 평균급여가 $5,000 이상이고 총급여가 $50,000 이상인 부서의 부서명(dept_name), 평균급여와 총급여를 조회
select dept_name as '부서명',
	   round(avg(salary)) as '평균급여',
       round(sum(salary)) as '총급여'
from emp
group by 1
having avg(salary) >= 5000 and sum(salary) > 50000;

--  커미션이 있는 직원들의 입사년도별 평균 급여를 조회. 단 평균 급여가 $9,000 이상인 년도분만 조회.
select year(hire_date) as '입사년도',
	   round(avg(salary), 2) as '평균급여'
from emp
where comm_pct is not null
group by 1
having avg(salary) >= 9000
order by 1 asc;



-- ---------------- 실제 시스템 상 진행 순서 ------------------
/*
select dept_name - - - - - - - - - - (5)
from emp - - - - - - - - - - - - - - (1)
where dept_name = 'Sales'- - - - - - (2)
group by count(*) > 20 - - - - - - - (3)
having avg(salary) > 2000- - - - - - (4)
order by 1;- - - - - - - - - - - - - (6)

1. from TABLE 구문을 통해 TABLE에 접근함
2. where 절을 통해 데이터를 filtering 함
3. group by 절을 통해 남은 데이터를 grouping 함
4. 그 group 들의 집계 값을 having 절과 비교해 그룹들을 filtering 함
5. select 에 해당하는 값들을 정리함
6. 그 값들을 order by 절에 따라 정렬해 출력함
*/

# 고생하셨슴둥

