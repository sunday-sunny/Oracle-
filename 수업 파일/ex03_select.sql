-- ex03_select.sql

-- tblCountry
-- 테이블 (스키마)구조 > 테이블명;
desc tblCountry;


/*

SELECT 문
- DML, DQL
- 관계대수 연산 중 셀렉션 작업을 구현한 명령어
- 대상 테이블로부터 원하는 행(튜플)을 추출하는 작업 > 데이터 주세요.
- 사용빈도 > TOP 1
- p145

[WITH <Sub Query>]
SELECT column_list
FROM table_name
[WHERE search_condition]
[GROUP BY group_by_expression]
[HAVING serach_condition]
[ORDER BY order_expresstion [ASC|DESC]]


-- 컬럼 리스트의 순서는 원본 데이터 순서와 무관
-- 동일한 컬럼을 여러번 가져와도 됨. (보통 가공 처리하여 가져옴)


*/
select *
from tblCountry;

select capital, name from tblCountry;
select name, name as 국가 from tblCountry;
select name, name || '@' as 국가 from tblCountry;



-- 여러가지 시스템 정보를 보고 싶을 때..
-- system으로 접속해서 실행해야함
--1. 사용자 정보
select * from sys.dba_users;

--2. 특정 사용자의 테이블 정보
select * from sys.dba_tables;
select * from sys.dba_tables where owner = 'HR'; -- HR 계정이 가지고 있는 모든 테이블

-- 3. 특정 테이블의 컬럼 정보 > 스키마
-- 계정, 테이블 이름 반드시 대문자로 해야 검색됨
select * from sys.dba_tab_columns 
where owner = 'HR' and table_name = 'TBLCOUNTRY';

-- 오라클은 객체 식별자(계정, 테이블 이름, 컬럼명 등)는 대문자로 저장한다.
-- 사용자가 SQL에서 객체 식별자를 사용할 때는 대소문자를 구분하지 않음.



