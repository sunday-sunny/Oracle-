-- ex24_union.sql

/*
관계 대수 연산
1. 셀렉션
2. 프로젝션
3. 조인
4. 합집합, 차집합, 교집합





UNION, 유니온
- 테이블 합치는 기술
- UNION, UNION ALL, INTERSECT, MINUS


*/

select * from tblMen;
select * from tblwomen;


select m.name, w.name 
from tblmen m
        full outer join tblwomen w on m.couple = w.name;



-- 행 10개 + 행 10개
-- 컬럼 5개
select * from tblmen
union
select * from tblwomen;


-- union 주의점
-- 1. 컬럼의 개수가 일치해야 한다.
-- 2. 컬럼의 타입이 일치해야 한다.
-- 3. 컬럼의 도메인이 일치해야 한다. (성질)
select name, age from tblmen
union
select name, age from tblwomen;


/*
게시판 테이블 > tblBoard
- 10년..
- 1천만개..

- 테이블을 분할한다. > 쪼갠다. > 각각의 테이블의 데이터수를 줄이기 위해서 > 검색 속도 향상을 위해
- tblBoard2019, tblBoard2020, tblBoard2021..

select * from tblBoard2019
union
select * from tblBoard2020


<팀프로젝트시 회의하여 결정하기>
회사 부서별 게시판

1. 테이블 1개
    게시판(번호, 제목, 내용, 날짜, 부서) > 카테고리
    
    insert into 테이블 values .. (1,... , 1); -- 영업부 게시판
    insert into 테이블 values .. (2,... , 2); -- 총무부 게시판

    select * from 테이블 where 부서 = 1; -- 영업부 게시판


2. 테이블 부서별
    영업부테이블 (번호, 제목, 내용, 날짜)
    총무부테이블 (번호, 제목, 내용, 날짜)

    insert into 영업부테이블 values .. (1,... ); -- 영업부 게시판
    insert into 총무부테이블 values .. (2,... ); -- 총무부 게시판

    select * from 영업부테이블; -- 영업부 게시판

    select * from 
    (select * from 영업부테이블
    union
    select * from 총무부테이블)
    where 통합조건;


-- 규모가 작으면 : 1번
-- 규모가 크면 : 2번


*/


create table tblUnionA (
    name varchar2(30) not null
);

create table tblUnionB (
    name varchar2(30) not null
);


insert into tblUnionA values ('강아지');
insert into tblUnionA values ('고양이'); -- **
insert into tblUnionA values ('사자');
insert into tblUnionA values ('호랑이'); -- **
insert into tblUnionA values ('닭');

insert into tblUnionB values ('타조');
insert into tblUnionB values ('코알라');
insert into tblUnionB values ('고양이'); -- **
insert into tblUnionB values ('치타');
insert into tblUnionB values ('호랑이'); -- **

select * from tbluniona;
select * from tblunionb;



-- union > 두 테이블을 합쳤을 때 중복되는 행이 자동으로 제거
-- union > 두 테이블을 합쳤을 때 중복되는 행이 그대로 보관
select * from tblUnionA
union all
select * from tblUnionB;

-- intersect > 교집합 
select * from tblUnionA
intersect 
select * from tblUnionB;

-- minus > 차집합
select * from tblUnionA
minus
select * from tblUnionB;


