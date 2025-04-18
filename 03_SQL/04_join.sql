/*목차
JOIN
INNER JOIN
SELF JOIN
OUTER JOIN
*/
/* ********************************************************************************
조인(JOIN) 이란
- Foreign Key에 관련된 나머지 정보는 저기 테이블에서 가져와~
- select절에서 가장 먼저 실행되는 from절에 적어준다.
- 이렇게 참조된 모든 값들을 하나의 Row로 가져와 나머지 절들을 실행하는 것이다.
- 자식 테이블의 FK와 부모 테이블의 PK를 비교해.

- 2개 이상의 테이블에 있는 컬럼들을 합쳐서 가상의 테이블을 만들어 조회하는 방식을 말한다.
 	- 소스테이블 : 내가 먼저 읽어야 한다고 생각하는 테이블
	- 타겟테이블 : 소스를 읽은 후 소스에 조인할 대상이 되는 테이블(참조될 테이블)
 
- 각 테이블을 어떻게 합칠지를 표현하는 것을 조인 연산이라고 한다.
    - 조인 연산에 따른 조인종류
        - Equi join , non-equi join
	- 거의 Equi join이야. non-equi는 업무적 비교대상 등
	
- 조인의 종류
    - Inner Join 
        - 양쪽 테이블에서 조인 조건을 만족하는 행들만 합친다. （해당하는　애들만）
    - Outer Join
        - 한쪽 테이블의 행들을 모두 사용하고 다른 쪽 테이블은 조인 조건을 만족하는 행만 합친다. 조인조건을 만족하는 행이 없는 경우 NULL을 합친다.
        - 종류 : Left Outer Join,  Right Outer Join, Full Outer Join
		- 참조되지 않은 값들도 null과 묶어서 반환
    - Cross Join
        - 두 테이블의 곱집합을 반환한다. 
        - 특정 행 X 그냥 다 합쳐 ! -> 모든 경우의 수
******************************************************************************** */        



/* ****************************************
-- INNER JOIN
FROM  테이블a INNER JOIN 테이블b ON 조인조건 

- inner는 생략 할 수 있다.
**************************************** */
use hr_join;
select *
from dept;
-- 직원의 ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서이름(dept.dept_name)을 조회
select e.emp_id, e.emp_name, e.hire_date, d.dept_name
from emp e inner join dept d on e.dept_id = d.dept_id; # 테이블 별칭 정해주기

-- 커미션을(emp.comm_pct) 받는 직원들의 직원_ID(emp.emp_id), 이름(emp.emp_name),
-- 급여(emp.salary), 커미션비율(emp.comm_pct), 소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회. 직원_ID의 내림차순으로 정렬.
select e.emp_id,
	   e.emp_name,
       e.salary,
       e.comm_pct,
       d.dept_name,
       d.loc
from emp e join dept d on e.dept_id = d.dept_id # 'inner' 생략 가능
where e.comm_pct is not null
order by 1 desc;
show tables;

-- 직원의 ID(emp.emp_id)가 100인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서이름(dept.dept_name)을 조회.
select e.emp_id, e.emp_name, e.hire_date, d.dept_name
from emp e join dept d on e.dept_id = d.dept_id
where e.emp_id = 100;

-- 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 담당업무명(job.job_title), 
-- 소속부서이름(dept.dept_name)을 조회
select e.emp_id, e.emp_name, e.salary, j.job_title, d.dept_name
from emp e join job j on e.job_id = j.job_id
		   join dept d on e.dept_id = d.dept_id;

--  직원 ID 가 200 인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 
-- 담당업무명(job.job_title), 소속부서이름(dept.dept_name)을 조회              
select e.emp_id, e.emp_name, e.salary, j.job_title, d.dept_name
from emp e join job j on e.job_id = j.job_id
		   join dept d on e.dept_id = d.dept_id
where e.emp_id = 200;

-- 부서_ID(dept.dept_id)가 30인 부서의 이름(dept.dept_name), 위치(dept.loc), 
-- 그 부서에 소속된 직원의 이름(emp.emp_name)을 조회.
select e.emp_name, d.dept_id, d.dept_name, d.loc
from dept d join emp e on e.dept_id = d.dept_id # inner join이라 순서 상관 없어.
where d.dept_id = 30;

-- **직원의 ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 급여등급(salary_grade.grade) 를 조회.
select * from salary_grade; 
select e.emp_id, e.emp_name, e.salary, s.grade as '급여등급'
from emp e join salary_grade s on e.salary between s.low_sal and s.high_sal;
# on 뒤에서 어떤 행을 기준으로 어떤 Row 끼리 붙일건지 정해줘야해.

-- 'New York'에 위치한(dept.loc) 부서의 부서_ID(dept.dept_id), 부서이름(dept.dept_name), 위치(dept.loc), 
-- 그 부서에 소속된 직원_ID(emp.emp_id), 직원 이름(emp.emp_name), 업무(emp.job_id)를 조회. 
select d.dept_id, d.dept_name, d.loc, e.emp_id, e.emp_name, e.job_id
from emp e join dept d on e.dept_id = d.dept_id
where d.loc = 'New York';


-- 부서별 급여(salary)의 평균을 조회. 부서이름(dept.dept_name)과 급여평균을 출력. 급여 평균이 높은 순서로 정렬. 
select d.dept_name, avg(e.salary) as '부서별 평균 급여'
from emp e join dept d on e.dept_id = d.dept_id
group by d.dept_name # 만약 같은 이름의 부서가 2개라면? dept_id 로 묶으면 되지만 dept_name을 보고싶어. 그때는 둘 다 써.
order by 2 desc;


-- 직원의 ID(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title), 급여(emp.salary), 
-- 급여등급(salary_grade.grade), 소속부서명(dept.dept_name)을 조회.
select e.emp_id, e.emp_name, j.job_title, e.salary, s.grade, d.dept_name
from emp e join job j on e.job_id = j.job_id
		   join dept d on e.dept_id = d.dept_id
           join salary_grade s on e.salary between s.low_sal and s.high_sal;


/* ****************************************************
Self 조인
- 물리적으로 하나의 테이블을 두개의 테이블처럼 조인하는 것.
- self 참조 시 사용된다.
**************************************************** */

-- 직원 ID가 101인 직원의 직원의 ID(emp.emp_id), 이름(emp.emp_name), 상사이름(emp.emp_name)을 조회
# 상사의 id 는 mgr_id
select e.emp_id, e.emp_name, e2.emp_name as '상사 이름'
from emp e join emp e2 on e.mgr_id = e2.emp_id # 이 해당조건에 없는 행들은 지워진다.
where e.emp_id = 101;


/* ****************************************************************************
외부 조인 (Outer Join)
- 불충분 조인
    - 조인 연산 조건을 만족하지 않는 행도 포함해서 합친다
    - 이는 기준이 되는 소스 테이블의 데이터가 참조되는 값이 없어도 보기 위함으로 이걸 left join이라고 한다.
	- 만약, 타겟 테이블의 데이터를 전부 표기하고 싶다면 right join을 사용할 수 있다.
    
- 종류
 left  outer join: 구문상 소스 테이블이 왼쪽
 right outer join: 구문상 소스 테이블이 오른쪽
 full outer join:  둘다 소스 테이블 (Mysql은 지원하지 않는다. - union 연산을 이용해서 구현)

- 구문
from 테이블a [LEFT | RIGHT] [OUTER] JOIN 테이블b ON 조인조건
- OUTER는 생략 가능.

**************************************************************************** */


-- 직원의 id(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 부서명(dept.dept_name), 부서위치(dept.loc)를 조회. 
-- 부서가 없는 직원의 정보도 나오도록 조회. dept_name의 내림차순으로 정렬한다.
select e.emp_id, e.emp_name, e.salary, d.dept_name, d.loc
from emp e left join dept d on e.dept_id = d.dept_id
order by dept_name desc;



-- 모든 직원의 id(emp.emp_id), 이름(emp.emp_name), 부서_id(emp.dept_id)를 조회하는데
-- 부서_id가 80 인 직원들은 부서명(dept.dept_name)과 부서위치(dept.loc) 도 같이 출력한다. (부서 ID가 80이 아니면 null이 나오도록)
select e.emp_id, e.emp_name, e.dept_id, d.dept_name, d.loc
from emp e left join dept d on e.dept_id = d.dept_id and d.dept_id = 80
order by 3 desc;
# on 설정, join을 시키는 조건에 두 조건을 넣어줌으로써 d.dept_name = 80인 애만 join되고 나머지는 left join에 의해 null이 join됨



        
--  직원_id(emp.emp_id)가 100, 110, 120, 130, 140인 직원의 ID(emp.emp_id),이름(emp.emp_name), 
-- 업무명(job.job_title) 을 조회. 업무명이 없을 경우 '미배정' 으로 조회
select e.emp_id, e.emp_name, ifnull(j.job_title, '미배정') as '업무명'
from emp e left join job j on e.job_id = j.job_id
where e.emp_id in (100, 110, 120, 130, 140);


-- **부서 ID(dept.dept_id), 부서이름(dept.dept_name)과 그 부서에 속한 직원들의 수를 조회. 
-- 직원이 없는 부서는 0이 나오도록 조회하고 직원수가 많은 부서 순서로 조회.
select d.dept_id,
	   d.dept_name,
       count(e.emp_id) as '직원수' # 집계함수이면서 PK기에 null 값이 없는 애를 기준으로 수를 세
from dept d left join emp e on d.dept_id = e.dept_id
group by d.dept_id, d.dept_name
order by 3;
# count(*) 는 데이터 수라기보다 행 수를 측정하는거야.

-- EMP 테이블에서 부서_ID(emp.dept_id)가 90 인 모든 직원들의 id(emp.emp_id), 
-- 이름(emp.emp_name), 상사이름(emp.emp_name), 입사일(emp.hire_date)을 조회. 
-- 입사일은 yyyy/mm/dd 형식으로 출력
select e.emp_id, e.emp_name, e2.emp_name as '상사이름' , date_format(e.hire_date, '%Y/%m/%d') as '입사일'
from emp e left join emp e2 on e.mgr_id = e2.emp_id # '모든 직원'이라 left join
where e.dept_id = 90;



-- 2003년~2005년 사이에 입사한 모든 직원의 id(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title), 급여(emp.salary), 입사일(emp.hire_date),
-- 상사이름(emp.emp_name), 상사의입사일(emp.hire_date), 소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회.
select e.emp_id, e.emp_name, e.salary, e.hire_date,
	   ifnull(j.job_title, '업무 없음') as '업무명',
       e2.emp_name as '상사이름',
       e2.hire_date as '상사의 입사일',
       ifnull(d.dept_name, '부서 없음') as '소속부서',
       d.loc
from emp e left join emp e2 on e.mgr_id = e2.emp_id # 상사가 없는 애도
		   left join job j on e.job_id = j.job_id # 직업이 없는 애도 / 합쳐진 테이블에 이 값이 null인게 있을 수도 있어.
           left join dept d on e.dept_id = d.dept_id # 부서가 없는 애도
where year(e.hire_date) between 2003 and 2005;
	
/*
select d.* -> 특정 테이블의 모든 요소만 확인할 때
*/







