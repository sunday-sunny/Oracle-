-- ex29.sql

-- 근태 상황(출석)

create table tblDate (
    seq number primary key,
    state VARCHAR(30) not null,
    regdate date not null
);

select * from tblDate;

insert into tblDate (seq, state, regdate) values (1, '정상', '2019-10-01');
insert into tblDate (seq, state, regdate) values (2, '정상', '2019-10-02');
-- 10-03 : 공휴일
-- 10-04 : 결석
insert into tblDate (seq, state, regdate) values (3, '지각', '2019-10-07');
insert into tblDate (seq, state, regdate) values (4, '정상', '2019-10-08');
-- 10-09 : 공휴일
insert into tblDate (seq, state, regdate) values (5, '정상', '2019-10-10');
insert into tblDate (seq, state, regdate) values (6, '조퇴', '2019-10-11');
-- 10-12 : 토요일
-- 10-13 : 일요일
insert into tblDate (seq, state, regdate) values (7, '정상', '2019-10-14');
insert into tblDate (seq, state, regdate) values (8, '정상', '2019-10-15');
insert into tblDate (seq, state, regdate) values (9, '지각', '2019-10-16');
insert into tblDate (seq, state, regdate) values (10, '정상', '2019-10-17');
insert into tblDate (seq, state, regdate) values (11, '정상', '2019-10-18');
-- 10-19 : 토요일
-- 10-20 : 일요일
insert into tblDate (seq, state, regdate) values (12, '정상', '2019-10-21');
insert into tblDate (seq, state, regdate) values (13, '지각', '2019-10-22');
-- 10-23 : 결석
insert into tblDate (seq, state, regdate) values (14, '조퇴', '2019-10-24');
insert into tblDate (seq, state, regdate) values (15, '정상', '2019-10-25');
-- 10-26 : 토요일
-- 10-27 : 일요일
insert into tblDate (seq, state, regdate) values (16, '정상', '2019-10-28');
insert into tblDate (seq, state, regdate) values (17, '정상', '2019-10-29');
insert into tblDate (seq, state, regdate) values (18, '지각', '2019-10-30');
insert into tblDate (seq, state, regdate) values (19, '정상', '2019-10-31');







-- 근태 조회 > 한달 근태 기록 > 결석일(레코드X) + 휴일(레코드X) > 빠진 날짜 메꾸기
-- 1. ANSI-SQL
-- 2. PL/SQL
-- 3. Java

select * from tblDate;

select
    lpad(' ', level * 3) || name 
from tblComputer
start with pseq is null
connect by pseq = prior seq;


-- 계층형 쿼리를 베이스로 사용
select 
    level
from dual
connect by level <= 5;

    
-- 시각(sysdate) + 숫자(일)
select 
    sysdate + level
from dual
connect by level <= 5;


-- 날짜를 가져올 반복 횟수
select
    to_date('20191031', 'yyyymmdd') - to_date('20191001', 'yyyymmdd')
from dual;



-- *** 기억!! > date 자료형으로 원하는 기간의 레코드들을 얻어오는 방법
create or replace view vwDate
as
select
    to_date('20191001', 'yyyymmdd') + level - 1 as regdate
from dual
    connect by level <= (to_date('20191031', 'yyyymmdd') - to_date('20191001', 'yyyymmdd') + 1);


select * from vwDate;   -- 일련의 날짜
select * from tblDate;  -- 근태 기록


select
    v.regdate as 날짜,
    t.state as 근태
from vwDate v
    left outer join tblDate t on v.regdate = t.regdate
order by v.regdate;



-- 휴일 처리(토,일)
select
    v.regdate as 날짜,
    case 
        when to_char(v.regdate, 'd') in ('1', '7') then '(주말)'
        else t.state
    end as 근태 
from vwDate v
    left outer join tblDate t on v.regdate = t.regdate
order by v.regdate;


-- 공휴일 처리
create table tblHoliday (
    seq number primary key,
    regdate date not null,
    name varchar2(30) not null
);

insert into tblholiday values (1, '2019-10-03', '개천절');
insert into tblholiday values (2, '2019-10-09', '한글날');

select * from tblHoliday;



-- 평일 + 휴일 처리(토,일) + 공휴일 + 결석
select
    v.regdate as 날짜,
    case 
        when to_char(v.regdate, 'd') in ('1', '7') then '(주말)'
        when t.state is null and h.name is null then '결석'
        when t.state is null and h.name is not null then h.name
        else t.state
    end as 근태 
from vwDate v
    left outer join tblDate t on v.regdate = t.regdate
    left outer join tblHoliday h on v.regdate = h.regdate
order by v.regdate;





-- oracle cloud 시간
SELECT 
    to_char(SYSDATE, 'yyyy-mm-dd hh24:mi:ss'), 
    to_char(CURRENT_DATE, 'yyyy-mm-dd hh24:mi:ss'), 
    DBTIMEZONE
    SESSIONTIMEZONE 
FROM DUAL;

select 
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'), 
    to_char(current_date, 'yyyy-mm-dd hh24:mi:ss') 
from dual;
