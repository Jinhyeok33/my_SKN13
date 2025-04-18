/*목차
계정 관리
DB 관리
Table 관리
데이터 관리
*/

create user jin@'localhost' identified by '1111'; # ID만의 경우 자동으로 문자열로 인식해줘
create user 'jin'@'%' identified by '1111';
create user jin2@'localhost' identified by '1111';
drop user 'jin2'@'localhost';

-- 생성된 계정을 확인
select user, host from mysql.user;

-- SQL문 작성 : 한 명령문이 끝나면 ; 으로 종료.
-- 실행 : ctrl + enter
-- 한 줄 주석
# 한 줄 주석
/* block 주석 */

-- 계정에 권한을 부여
-- grant 부여할 권한 on 대상 테이블 to 권한 부여할 계정
grant all privileges on *.* to jin@localhost;
grant all privileges on *.* to jin@'%';
-- revoke all privileges on *.* to jin@'%';
-- *: DB , ., *:table

#################################################
-- DB 생성 / 삭제
#################################################
create database test_db; # 얘도 자동 문자열 인식이야....
create database hr;

-- DB 조회
show databases;
-- DB 에 대한 권한 부여
grant all privileges on test_db to 'jin2'@'%';
-- DB 제거
drop database hr;

-- DB 기본으로 설정
use test_db; # test_db.table_name 에서 계속 사용하겠다.
-- sys.sys_config -> 다른 database의 테이블 호출 / db이름.테이블이름

#################################################
-- TABLE 생성 / 삭제
#################################################
-- SQL의 명령 실행 기준은 세미콜론부터 세미콜론까지를 하나의 명령문으로 인식해서 작동한다. 그래서 습관상 매 줄 마다 적어주는 것.
-- Table을 생성할 때는 사용할 column들과 그 이름 및 특징, 세부 제약 조건등에 대해 정해주어야 한다.

-- create table test_db.member(
use test_db;
create table member(
	id			varchar(10)		PRIMARY KEY, -- 최대 10 글자
    password 	varchar(10) 	not null, -- 필수 입력
    name 		varchar(50) 	not null,
    point 		int 			Default 1000, -- 값을 넣지 않으면 기본으로 1000점을 포인트로 준다.
    email 		varchar(100)	UNIQUE, 
    -- notnull + unique : 필수 값에 중복을 허용하지 않음 (PK와 동일하지만 PK는 대표 기능이기에)
    age 		int 			check(age > 1),
    join_date 	timestamp 		not null default current_timestamp -- 해당 시점 날짜, 시간 넣어줌(timestamp)
);

-- 테이블들 조회
show tables;
-- 테이블의 칼럼정보 조희
desc member;
-- 테이블 삭제
drop table member;
drop table if exists member;

#################################################

-- 데이터 삽입 / 제거
#################################################

-- 데이터 삽입
insert into member (id, password, name, age) values ('wlsgur2658', 'wlsgur2844', '전진혁', 26);
	# point, email, join_date는 default로 들어가
insert into member (id, password, name, email, age, point) 
	values ('wlsgur', 'wlsgur', '진혁', 'jinhyeok2844@naver.com', 20, 0);
	# column의 순서는 상관 없어 !
insert into member (id, password, name, point, email)
	values ('wls', 'wls', '진', null, 'wls@naver.com');
	# null도 값이야. null을 넣으면 default가 적용되지 않아.
-- 데이터 확인
select * from member; # *로 모든 칼럼 선택
select id, password, name, age 
from member 
where age > 19;
