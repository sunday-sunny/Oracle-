-- ex26_hierarchical.sql

/* 
계층형 쿼리, Hierarchical Query
    - 레코드간의 관계가 서로 상하 수직 구조일 경우 사용 > 그 구조를 결과셋 반영
    - 자기 참조하는 테이블에서 사용한다.(ex. 셀프조인)
    - 오라클 전용
    - 카테고리, 답변형 게시판, 조직도, BOM
*/

-- ex
select * from tblSelf; -- seq(직원), super(상사)
select * from employees; --employee_id(직원), manager_id(매니저)



create table tblComputer (
    seq number primary key,                                                         -- 식별자(PK)
    name varchar2(50) not null,                                                   --부품명
    qty number not null,
    pseq number null references tblComputer(seq)            -- 부모부품(FK)
);


insert into tblComputer values (1, '컴퓨터', 1, null);

insert into tblComputer values (2, '본체', 1, 1);
insert into tblComputer values (3, '메인보드', 1, 2);
insert into tblComputer values (4, '그래픽카드', 1, 2);
insert into tblComputer values (5, '랜카드', 1, 2);
insert into tblComputer values (6, 'CPU', 1, 2);
insert into tblComputer values (7, '메모리', 2, 2);

insert into tblComputer values (8, '모니터', 1, 1);
insert into tblComputer values (9, '보호필름', 1, 8);
insert into tblComputer values (10, '모니터암', 1, 8);

insert into tblComputer values (11, '프린터', 1, 1);
insert into tblComputer values (12, 'A4용지', 100, 11);
insert into tblComputer values (13, '잉크카트리지', 3, 11);

select * from tblComputer;


select 
    c1.name as 부품명,
    c2.name as 부모부품명
from tblComputer c1
    inner join tblComputer c2 on c1.pseq = c2.seq
order by c1.seq;


select 
    c1.name as 부품명,
    c2.name as 부모부품명
from tblComputer c1
    left outer join tblComputer c2 on c1.pseq = c2.seq
order by c1.seq;



-- 계층형 쿼리
-- start with절 + connect by 절
-- 계층형 쿼리에서만 제공하는 의사 컬럼 사용
--      a.  prior : 부모 레코드
--      b. level : depth


select
    seq as "번호",
    lpad(' ', (level-1) * 5)|| name as "부품명",
    prior name as "부모부품명",           -- 부모 레코드의 name을 가져와주십쇼..
    level
from tblComputer c 
--    start with seq = 1  -- 루트 요소 지정
--    start with seq = 8 -- 내가 지정한 루트 레코드부터 가져오게 됨 -> 모니터라인만 나옴, 상수는 안 좋으니 다른 방법으로 넣어보자
--    start with seq = (select seq from tblComputer where name = '컴퓨터')
    start with  pseq is null
    connect by prior seq  = pseq;       -- 부모와 자식을 연결짓는 조건



select
    lpad(' ', (level-1) * 3) || name as "직원명",
    prior name as "상사명"
from tblSelf
    start with super is null
    connect by super = prior seq;


select
    lpad(' ', (level-1) * 3) || first_name,
    prior first_name as manager
from employees
    start with manager_id is null
    connect by manager_id = prior employee_id;


select
    seq as "번호",
    lpad(' ', (level-1) * 5)|| name as "부품명",
    prior name as "부모부품명",           -- 부모 레코드의 name을 가져와주십쇼..
    level
from tblComputer c 
    start with  pseq is null
    connect by prior seq  = pseq       -- 부모와 자식을 연결짓는 조건
order siblings by name asc

















