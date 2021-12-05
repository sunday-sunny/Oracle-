-- ex15_insert.sql


/* 
insert
- DML
- 테이블에 데이터를 추가하는 명령어(행 추가, 레코드 추가)
- insert into 테이블명(컬럼리스트) values (값리스트);


*/

drop table tblMemo;

create table tblMemo (
    seq number(3) primary key,
    name varchar2(30) default '익명' not null,
    memo varchar2(1000) null,
    regdate date default sysdate null
);

drop sequence seqMemo;
create sequence seqMemo;

select * from tblMemo;


-- 1. 표준 : 원본 테이블에 정의된 컬럼 순서대로 컬럼리스트와 값리스트를 구성하는 방식
insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, '홍길동', '메모내용입니다.', sysdate);


-- 2. 컬럼리스트의 순서는 원본 테이블과 관계없다.
--      컬럼리스트의 순서와 값리스트 순서는 반드시 일치해야 한다.(***)
insert into tblMemo (name, memo, regdate, seq)
    values ('홍길동', '메모내용입니다.', sysdate, seqMemo.nextVal);


-- 3. ORA-00947: not enough values
-- 컬럼리스트의 개수와 값리스트 개수는 동일해야 한다.
insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, '홍길동', sysdate);
    
    
-- 4. ORA-00913: too many values
-- 컬럼리스트의 개수와 값리스트 개수는 동일해야 한다.
insert into tblMemo (seq, name, memo)
    values (seqMemo.nextVal, '홍길동', '메모내용입니다.', sysdate);
    
    
-- 5. null 컬럼 조작
-- a. memo varchar2(1000) null
-- b. regdate date default sysdate null

-- null 컬럼(default x)에 null을 넣는 방법
-- 방법1. null 상수 사용
insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, '홍길동', null, sysdate);

-- 방법2. 생략
insert into tblMemo (seq, name, regdate)
    values (seqMemo.nextVal, '홍길동', sysdate);

-- null 컬럼(default o)에 null을 넣는 방법
-- default가 설정된 컬럼
--      a. null을 명시적으로 넣으면 null이 들어간다. + default 동작 안 함
--      b. 생략을 통해 넣으면 + default 동작 
insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, '홍길동', '메모내용입니다.', null);
    
insert into tblMemo (seq, name, memo)
    values (seqMemo.nextVal, '홍길동', '메모내용입니다.'); 
    

-- 6. default 조작
--      a. name varchar2(30) default '익명' not null,
--      b. regdate date default sysdate null

insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, null, '메모내용입니다.', sysdate);   -- > X

insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, '홍길동', '메모내용입니다.', sysdate);

insert into tblMemo (seq, memo, regdate)
    values (seqMemo.nextVal, '메모내용입니다.', sysdate);

insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, default, '메모내용입니다.', sysdate);

insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, '홍길동', '메모내용입니다.', default);


-- 7. 단축 표현
--      컬럼리스트를 생략할 수 있다.
--      원본 테이블의 컬럼 순서대로 값을 넣어야 한다.
insert into tblMemo values (seqMemo.nextVal, '홍길동', '메모내용입니다.', sysdate);


-- 8.
-- tblMemo 복사 -> 복사 테이블 
create table tblMemoCopy (
    seq number(3) primary key,
    name varchar2(30) default '익명' not null,
    memo varchar2(1000) null,
    regdate date default sysdate null
);


insert into tblMemoCopy select * from tblMemo;


-- 9.
create table tblMemoCopy2 as select * from tblMemo;



select * from tblMemo;
select * from tblMemoCopy;




