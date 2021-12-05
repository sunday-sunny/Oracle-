-- ex14_sequence.sql


/* 시퀀스, sequence
- 데이터베이스 객체 중 하나
- 식별자를 만드는데 주로 사용한다. > PK 컬럼에 값을 넣을 때 잘 사용한다.
- 일련 번호를 생성하는 객체
- Oracle에만 있음. (다른 곳에서는 identity로 부름)

시퀀스 객체 생성하기
- create sequence 시퀀스명;

시퀀스 객체 삭제하기
- drop sequence 시퀀스명;

시퀀스 객체 사용하기(일련 번호 만들기)
- 시퀀스명.nextVal
- 시퀀스명.currVal
*/

create sequence seqNum;


select seqNum.nextVal from dual;        -- 1, 2, 3, 4, 5...
select 'A' || seqNum.nextVal from dual;
select 'A' || trim(to_char(seqNum.nextVal, '000')) from dual;

select 
    'A' || trim(to_char(seqNum.nextVal, '000')) || 'B' || trim(to_char(seqNum2.nextVal, '000'))
from dual;


create sequence seqNum2;

drop table tblMemo;


create sequence seqMemo;

create table tblMemo(
    -- 컬럼 정의
    seq number(3),
    name varchar2(30),
    memo varchar2(1000), 
    regdate date,
    
    -- 제약사항 정의
    constraint tblmemo_sep_pk primary key(seq)
);

insert into tblMemo(seq, name, memo, regdate)
values (seqMemo.nextVal, '아무개', '테스트~', sysdate);

select * from tblMemo;


-- 현재 사용중인 시퀀스 객체(seqMemo)의 마지막 번호?
-- 1. currVal : 가장 마지막에 생성한 숫자를 반환(자바 큐/스택 peek())
--> 현재 계정으로 로그인 후 최소 1번은 nextVal를 호출해야 그 다음부터 currVal를 호출할 수 있다.

select seqMemo.currVal from dual;


-- 2. nextVal
--> 번호 하나를 소비해버린다. > 구멍이 발생..
select seqMemo.nextVal from dual;


-- 3. max() 함수 사용
select max(seq) from tblMemo;


/*
시퀀스 객체 생성하기
- create sequence 시퀀스명;
- create sequence 시퀀스명 
                increment by n 
                start with n 
                maxvalue n 
                min value n 
                cycle
                cache n; 

*/

drop sequence seqTest;

create sequence seqTest
    increment by 1 -- ***
    start with 1 -- 에러나서 다시 seq를 만들어야할 때
    maxvalue 30
    minvalue -5
    cycle -- max값 다음에 순환함
    cache 20;

select seqTest.nextVal from dual;



