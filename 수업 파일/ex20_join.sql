-- ex20_join.sql


/*

관계형 데이터베이스 시스템이 지양하는 것들
    1. 테이블에 기본키가 없는 상태  >   데이터 조작 곤란..
    2. null이 많은 상태  >   공간 낭비..
    3. 데이터가 중복되는 상태 >   공간 낭비 + 관리 곤란..
    4. 하나의 속성값(셀)이 원자값이 아닌 상태   >   더 이상 쪼개지지 않는 값을 가져야 한다




테이블 관계

상황 ] 직원(번호(pk), 직원명, 급여, 거주지

*/

create table tblStaff(
    seq number primary key,
    name varchar2(30) not null,
    salary number not null,
    address VARCHAR2(300) not null,
    project VARCHAR2(300) null
);

insert into tblStaff(seq, name, salary, address, project)
    values (1, '홍길동',  300, '서울시', '홍콩 수출');
    
insert into tblStaff(seq, name, salary, address, project)
    values (2, '아무개',  250, '인천시', 'TV광고');
    
insert into tblStaff(seq, name, salary, address, project)
    values (3, '하하하',  350, '의정부시', '매출 분석');
    
-- '홍길동'에게 담당프로젝트 1건 추가 > '고객 관리'
insert into tblStaff(seq, name, salary, address, project)
    values (4, '홍길동',  300, '서울시', '고객 관리');

-- '호호호' 직원 추가 + '게시판 관리, 회원 응대'
insert into tblStaff(seq, name, salary, address, project)
    values (5, '호호호',  250, '서울시', '게시판 관리, 회원 응대');
    
select * from tblStaff;

select *
from tblStaff
where project ='회원 응대';

-- 서브 쿼리를 사용하여 업데이트
update tblStaff
set project = 'SNS 광고'
where seq = (select seq from tblStaff where project = 'TV광고');


-- ORA-02449: unique/primary keys in table referenced by foreign keys
drop table tblStaff;
drop table tblProject;


-- <새로운 테이블을 만들어보자..!>
-- 생성 순서 : 부모 테이블 생성 > 자식 테이블 생성
-- 삭제 순서 : 자식 테이블 삭제 > 부모 테이블 삭제

-- 부모 테이블
create table tblStaff(
    seq number primary key,
    name varchar2(30) not null,
    salary number not null,
    address VARCHAR2(300) not null
);

-- 자식 테이블 
create table tblProject (
    seq number primary key,
    projectname varchar2(300) not null,
--    staff_seq number not null
    staff_seq number not null references tblStaff(seq)
);


delete from tblStaff;

insert into tblStaff(seq, name, salary, address) values (1, '홍길동', 300, '서울시');
insert into tblStaff(seq, name, salary, address) values (2, '아무개', 250, '인천시');
insert into tblStaff(seq, name, salary, address) values (3, '하하하', 350, '의정부시');

-- ORA-02291: integrity constraint (HR.SYS_C007133) violated - parent key not found
insert into tblProject(seq, projectname, staff_seq) values (1, '홍콩 수출', 1);
insert into tblProject(seq, projectname, staff_seq) values (2, 'TV 광고', 2);
insert into tblProject(seq, projectname, staff_seq) values (3, '매출 분석', 3);
insert into tblProject(seq, projectname, staff_seq) values (4, '노조 협상', 1);
insert into tblProject(seq, projectname, staff_seq) values (5, '대리점 분양', 3);

-- A. 신입 사원 입사 > 신규 프로젝트 담당
-- A. 1 신입 사원 추가
insert into tblStaff(seq, name, salary, address) values (4, '호호호', 200, '성남시');

-- A.2 신규 프로젝트 추가
insert into tblProject(seq, projectname, staff_seq) values (6, '자재 매입', 4);

-- A.3 신규 프로젝트 추가(X) -> 문제 발생!!
-- ORA-02291: integrity constraint (HR.SYS_C007133) violated - parent key not found
-- 무결성 제약 위반
insert into tblProject(seq, projectname, staff_seq) values (7, '고객 유치', 5);


-- B. '홍길동' 퇴사
-- B.1 '홍길동' 삭제 > 문제 발생!! 
-- ORA-02292: integrity constraint (HR.SYS_C007133) violated - child record found
-- 무결성 제약 위반
delete from tblstaff where seq = 1;

select * from tblStaff
where seq = (select staff_seq from tblProject where projectname = '고객 유치');

select * from tblstaff;
select * from tblproject;



-- <새로운 테이블>

-- 고객 테이블
create table tblCustomer (
    seq number primary key,                 --고객번호(PK)
    name varchar2(30) not null,             --고객명
    tel varchar2(15) not null,              --연락처
    address varchar2(100) not null          --주소
    --sseq number null reference tblSales(seq)     --참조키(판매번호)
);

-- 판매내역 테이블
create table tblSales (
    seq number primary key,                         --판매번호(PK)
    item varchar2(50) not null,                     --제품명
    qty number not null,                            --수량
    regdate date default sysdate not null,          --판매날짜
    cseq number not null references tblCustomer(seq)       --고객번호(FK)
);

-- 장르 테이블
create table tblGenre (
    seq number primary key,                         --장르번호(PK)
    name varchar2(30) not null,                     --장르명
    price number not null,                          --대여가격
    period number not null                          --대여기간(일)
);

-- 비디오 테이블
create table tblVideo (
    seq number primary key,                         --비디오번호(PK)
    name varchar2(100) not null,                    --제목
    qty number not null,                            --보유 수량
    company varchar2(50) null,                      --제작사
    director varchar2(50) null,                     --감독
    major varchar2(50) null,                        --주연배우
    genre number not null references tblGenre(seq)  --장르(FK)
);

-- 고객 테이블
create table tblMember (
    seq number primary key,                         --회원번호(PK)
    name varchar2(30) not null,                     --회원명
    grade number(1) not null,                       --회원등급(1,2,3)
    byear number(4) not null,                       --생년
    tel varchar2(15) not null,                      --연락처
    address varchar2(300) null,                 --주소
    money number not null                           --예치금
);

-- 대여 테이블
create table tblRent (
    seq number primary key,                                 --대여번호(PK)
    member number not null references tblMember(seq),       --회원번호(FK)
    video number not null references tblVideo(seq),         --비디오번호(FK)
    rentdate date default sysdate not null,                 --대여시각
    retdate date null,                                      --반납시각
    remark varchar2(500) null                               --비고
);



select * from tblgenre;
select * from tblvideo;
select * from tblmember;
select * from tblRent;


/* 
조인, JOIN
- (서로 관계를 맺은) 2개(1개) 이상의 테이블의 내용을 가져와서 1개의 결과셋을 만드는 작업

조인의 종류
    1. 단순 조인, Cross join, 카티션곱(데카르트곱)
    2. 내부 조인, Inner join ***
    3. 외부 조인, Outer join ***
    4. 셀프 조인, Self join
    5. 전체 외부 조인, Full outer join 


*/


--  1. 단순 조인, Cross join, 카티션곱(데카르트곱)
--      결과셋 행 개수 > 3*9 = 27개
--      결과셋 컬럼 개수 > 4 + 5 = 9개
select * from tblcustomer;
select * from tblsales;

select * from tblCustomer cross join tblSales; --ANSI-SQL 방식(추천)
select * from tblCustomer, tblSales -- Oracle 스타일


/* 별칭(Alias)
-- 별명이 아니라, 개명

1. 컬럼 별칭
    컬럼명 as 별칭

2. 테이블 별칭
    테이블명 별칭
*/

select name, buseo, jikwi from tblInsa;
select name, buseo, jikwi from hr.tblInsa;
select hr.tblInsa.name, hr.tblInsa.buseo, hr.tblInsa.jikwi from hr.tblInsa;



select a.name, a.buseo, a.jikwi 
from tblinsa a;

-- ORA-00918: column ambiguously defined > 애매모호..
-- ORA-00904: "TBLCUSTOMER"."SEQ": invalid identifier

select a.seq, a.name, b.item, b.cseq
from tblCustomer a cross join tblSales b ;

-- ORA-00904: "NAME": invalid identifier
select name
from (select name as 이름, buseo from tblInsa);

select count(*), sum(basicpay)
from tblInsa;

/*
2. 내부 조인, Inner join ***
    - 단순 조인에서 유효한 레코드만 추출한 조인 > 카티션곱의 결과서 올바른 것만 추출

select 컬럼리스트 
from 테이블A 
    inner join 테이블B  
        on 테이블A.PK = 테이블B.FK;       --ANSI-SQL

select 컬럼리스트 
from 테이블A, 테이블B  
        where 테이블A.PK = 테이블B.FK;       --Oracle.ver
*/

-- seq가 > seq_1으로 나오는 이유는 단지 구분을 위해서
-- 해당 컬럼명으로 select 해보면 에러남
select c.seq, s.seq, name, item, qty
from tblCustomer c inner join tblSales s
on c.seq = s.cseq;


-- ORA-00918: column ambiguously defined
-- 첫번째, 두번째 컬럼명이 동일하기 때문에 에러남
-- 사용하려면 alias를 꼭 붙여주기
select *
from(select c.seq, s.seq, name, item, qty
            from tblCustomer c inner join tblSales s
            on c.seq = s.cseq);



-- 비디오 제목과 그 비디오의 대여가격 가져오기
select * from tblGenre;
select * from tblVideo;

-- join
select v.name, g.price
from tblgenre g inner join tblVideo v
on g.seq = v.genre;

-- 상관서브쿼리
select
    name,
    (select price from tblgenre where seq = tblVideo.genre) as price
from tblVideo;

-- 직원명과 담당 프로젝트명을 가져오시오.
select * from tblstaff;
select * from tblproject;

select s.name, p.projectname
from tblstaff s inner join tblproject p
on s.seq = p.staff_seq;


-- ORA-01427: single-row subquery returns more than one row
-- 서브 쿼리가 경우에 따라 2개 이상 나오기 때문
select
    name,
    (select projectname from tblproject where staff_seq = s.seq)
from tblStaff s;


select 
    projectname,
    (select name from tblstaff where seq = p.staff_seq) as name
from tblProject p;



-- 하면 안되는 조인 > 데이터가 관계가 있지 않으면 하지 말것!!
select *
from tblCustomer c inner join tblGenre g
on c.seq = g.seq;

-- 2개의 테이블 조인
select * 
from tblGenre g inner join tblVideo v
on g.seq = v.genre;

-- 4개 테이블 조인
-- 어떤 회원? 어떤 비디오? 언제 대여? 가격?
select 
    m.name as mname,
    v.name as vname,
    r.rentdate,
    g.price
from tblGenre g
        inner join tblVideo v on g.seq = v.genre
        inner join tblRent r on  v.seq = r.video
        inner join tblMember m on m.seq = r.member;


-- 내부 조인의 결과셋 레코드 수? 자식 테이블 레코드 수가 된다.



select 
    e.first_name || ' ' || e.last_name as name,
    j.job_title,
    d.department_name,
    l.city,
    c.country_name,
    r.region_name
from employees e 
        inner join jobs j on e.job_id = j.job_id
        inner join departments d on e.department_id = d.department_id
        inner join locations l on l.location_id = d.location_id
        inner join countries c on c.country_id = l.country_id
        inner join regions r on r.region_id = c.region_id;


select * from employees;
select * from jobs;
select * from departments;
select * from locations;
select * from countries;
select * from regions;





/*
3. 외부 조인, Outer Join ***
- 내부 조인 + 조인의 결과셋에 포함되지 못한 부모 테이블의 나머지 레코드

SELECT 컬럼리스트 
FROM  테이블A (LEFT | RIGHT) OUTER JOIN 테이블B
ON 테이블A.컬럼 = 테이블B.컬럼
*/

-- 물건을 한 번이라도 구매한 이력이 있는 고객과 판매 정보를 같이 가져오시오.
select * from tblCustomer c 
        inner join tblSales s on c.seq = s.seq; 

select * from tblCustomer;

insert into tblCustomer values (4, '호호호', '010-1234-5678', '서울시');

-- 구매 이력과 무관하게 모든 고객과 판매 정보를 같이 가져오시오.
select * from tblCustomer c
        right outer join tblSales s on c.seq = s.cseq;



-- tblVideo, tblRent
-- 대여가 한 번이라도 된 비디오와 그 대여 내역을 가져오시오.
select * 
from tblVideo v
        inner join tblRent r on v.seq = r.video;


-- 대여와 상관없이 모든 비디오와 그 대여 내역을 가져오시오.
select * from tblVideo v
        left outer join tblRent r on v.seq = r.video;
        
        
-- 대여를 한 번이라도 한 회원과 그 대여 내역을 가져오시오.
select *
from tblMember m
        inner join tblRent r on m.seq = r.member;


-- 대여와 상관없이 모든 회원과 그 대여 내역을 가져오시오.
select *
from tblMember m
       left outer join tblRent r on m.seq = r.member;



-- 대여를 한 번이라도 한 회원은 몇 명입니까? > 6명(x)
select count(*) 
from tblMember m
        inner join tblRent r on m.seq = r.member;


-- 대여를 한 번이라도 한 회원의 몇 명입니까? > 5명(x)
select count(distinct m.seq )
from tblMember m
        inner join tblRent r on m.seq = r.member;


-- 대여를 한 번이라도 한 회원별로 이름과 대여 횟수를 가져오시오.
select m.name, count(*)
from tblMember m
        inner join tblRent r on m.seq = r.member
group by m.name;


-- 모든 회원의 이름과 대여 횟수를 가져오시오.
select m.name, count(r.seq)
from tblMember m
       left outer join tblRent r on m.seq = r.member
group by m.name;



-- 직원명 + 부서명
select
    first_name || ' ' || last_name as name,
    department_name
from employees e
        inner join departments d on e.department_id = d.department_id;


-- 낭비 되는 컬럼을 막기 위해, e를 서브쿼리로 해서 가져옴
select
    first_name || ' ' || last_name as name,
    department_name
from (select first_name, last_name, department_id from employees) e
        inner join (select department_id, department_name from departments) d
        on e.department_id = d.department_id;




/*
4. 셀프 조인, Self Join
- 1개 테이블을 사용해서 조인
- 테이블이 스스로 관계를 맺는 경우에 사용
- 셀프조인 + 내부조인
- 셀프조인 + 외부조인

*/

create table tblSelf(
    seq number primary key,
    name varchar2(30) not null,
    department varchar2(50) null,
    super number null references tblSelf(seq)
);

insert into tblSelf values (1, '홍사장', null, null);

insert into tblSelf values (2, '김부장', '영업부', 1);
insert into tblSelf values (3, '이과장', '영업부', 2);
insert into tblSelf values (4, '정대리', '영업부', 3);
insert into tblSelf values (5, '최사원', '영업부', 4);

insert into tblSelf values (6, '박부장', '개발부', 1);
insert into tblSelf values (7, '하과장', '개발부', 6);

select * from tblSelf;

-- 직원 명단을 가져오시오.(상사 이름도 같이)
-- 1. join
select 
    s1.name, 
    s1.department, 
    s2.name as "상사"
from tblSelf s1
        inner join tblSelf s2 on s1.super = s2.seq;


select 
    s1.name as "직원명",
    s2.name as "상사명"
from tblSelf s1
        left outer join tblSelf s2 on s1.super = s2.seq;


-- 2. subquery
select
    name,
    (select name from tblSelf where seq = s.super) as 상사명
from tblSelf s;


















