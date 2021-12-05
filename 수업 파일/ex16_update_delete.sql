-- ex16_update_delete.sql


/*
Update
- DML
- 원하는 행의 원하는 컬럼을 수정하는 명령어
- Update 테이블명 set 컬럼명=값 [, 컬럼명=값] X N [where절]
- 주의점!! : where이 필요한 수정 시 where절을 반드시 확인

Delete
- DML
- 원하는 행을 삭제하는 명령어
- Delete [From] 테이블명 [Where절]

*/

commit;

rollback;


select * from tblCountry;

-- 대한민국 : 서울 > 세종
update tblCountry 
set capital = '세종'
where name = '대한민국';

update tblCountry
set population = population * 1.1;

update tblCountry
set capital = '부산', area = area * 1.2, population = population * 1.2
where name = '대한민국';


delete from tblCountry where name = '중국';


-- select, update, delete -> where절 사용 가능
-- 특정 행 검색
--      a. 1개 > 조건절에 PK를 검색
--      b. N개 > 조건절에 일반컬럼을 검색





