/*목차
INSERT 문
UPDATE 문
DELETE 문
*/
/* *********************************************************************
INSERT 문 - 행 추가
구문
 - 한행추가 :
   - INSERT INTO 테이블명 (컬럼 [, 컬럼]) VALUES (값 [, 값[])
   - 모든 컬럼에 값을 넣을 경우 컬럼 지정구문은 생략 할 수 있다.

************************************************************************ */



/* *********************************************************************
UPDATE : 테이블의 컬럼의 값을 수정
UPDATE 테이블명
SET    변경할 컬럼 = 변경할 값  [, 변경할 컬럼 = 변경할 값]
[WHERE 제약조건]

 - UPDATE: 변경할 테이블 지정
 - SET: 변경할 컬럼과 값을 지정
 - WHERE: 변경할 행을 선택. 
************************************************************************ */
use hr_join;
-- 직원 ID가 200인 직원의 급여를 5000으로 변경
select * from emp where emp_id = 200;
update emp set salary = 5000 where emp_id = 200;

-- 직원 ID가 200인 직원의 급여를 10% 인상한 값으로 변경.
select * from emp where emp_id = 200;
update emp set salary = salary*1.1 where emp_id = 200;

-- 부서 ID가 100인 직원의 커미션 비율을 null 로 변경.
select * from emp where dept_id = 100;
update emp set comm_pct = null where dept_id = 100;

--  부서 ID가 100인 직원들의 급여를 100% 인상
select * from emp where dept_id = 100;
update emp
set salary = salary*2
where dept_id = 100;



-- 부서 ID가 100인 직원의 커미션 비율을 0.2로 salary는 3000을 더한 값으로, 상사_id는 100 변경.
update emp
set comm_pct = 0.2, salary = salary + 3000, mgr_id = 101 # and 연결은 Boolean에서
where dept_id = 100;

--  IT 부서의 직원들의 급여를 3배 인상
select * from emp;
select * from emp where job_id like "IT%";
update emp
set salary = salary*3
where dept_id = (select dept_id from dept where dept_name = 'IT');

-- EMP 테이블의 모든 데이터를 MGR_ID는 NULL로 HIRE_DATE 는 현재일시로 COMM_PCT는 0.5로 수정.
update emp
set mgr_id = null,
	hire_date = curdate(),
    comm_pct = 0.5;
select * from emp;

/* *********************************************************************
DELETE : 테이블의 행을 삭제 / 이 친구만이 칼럼을 다루지 않는다.
구문 
 - DELETE FROM 테이블명 [WHERE 제약조건]
   - WHERE: 삭제할 행을 선택
************************************************************************ */

-- 전체 행 삭제
delete from emp;

-- 부서테이블에서 부서_ID가 200인 부서 삭제
delete from dept where dept_id = 200;
select * from dept;

-- 부서테이블에서 부서_ID가 10인 부서 삭제
delete from dept where dept_id = 10;

-- 부서 ID가 없는 직원들을 삭제
delete from emp where dept_id is null;

-- 담당 업무(emp.job_id)가 'SA_MAN'이고 급여(emp.salary) 가 12000 미만인 직원들을 삭제.
delete from emp where job_id = 'sa_man' and salary < 12000;

-- comm_pct 가 null이고 job_id 가 IT_PROG인 직원들을 삭제
delete from emp where comm_pct is null and job_id = 'it_prog';
select * from emp;

