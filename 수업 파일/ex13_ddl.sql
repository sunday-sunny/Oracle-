-- ex13_ddl.sql

/*
ex01.sql ~ ex12.sql
- DML 기본

DDL
- 데이터 정의어
- 데이터베이스 담당 관리자가 사용
- 데이터베이스 객체를 생성, 수정, 삭제한다.
- 데이터베이스 객체 > 테이블, 뷰. 인덱스, 트리거, 프로시저, 제약 사항 등..
- create, alter, drop

테이블 생성하기 > 스키마 정의하기 > 속성(컬럼) 정의하기 > 속성(컬럼)의 성격(이름)과 도메인 정의


create table 테이블명 
(
    컬럼 정의,
    컬럼 정의,
    컬럼 정의,
    컬럼명 자료형(길이) null표기 제약사항
);

제약 사항. Constraint
- 해당 컬럼에 들어갈 데이터(값)에 대한 조건(규제) > 설계(=도메인)
    > 조건을 만족하지 못하면 데이터를 해당 컬럼에 넣지 못한다.(에러 발생) > 유효성 검사 도구
- 데이터 무결성을 보장하기 위한 도구(***)


1. NOT NULL
    - 해당 컬럼이 반드시 값을 가져야 한다.
    - 해당 컬럼에 값이 없으면 에러 발생
    - 필수값
    
2. Primary key, PK
    - 유일하다. > 행간의 동일한 값을 가질 수 없다. > Unique
    - 테이블의 행들을 구분하기 위한 유일한 값을 가지는 제약사항
    - 하나 이상의 컬럼에게 할당 > 일반적으로는 1개의 컬럼
    - 기본키의 형태
        a. 단일 기본키 > 기본키 : 1개의 컬럼이 pk 역할
        b. 복합 기본키 > 복합키 : 2개 이상의 컬럼이 모여서 pk 역할 > 복합키 발생 > 가상 키를 따로 생성해서 기본키(대리키) 
    - 모든 테이블은 반드시(100%) Primary key를 가져야 한다.

3. Foreign key, FK


4. Unique
    - 유일하다. > 행간의 동일한 값을 가질 수 없다. > Unique
    - Primary key - not null
    - Unique 제약은 Primary key와 다르게 null을 가질 수 있다.
    - 식별자로 사용하기 애매함. > 식별자로 사용하지 말것!! > 식별자는 PK를 사용한다.
        a. 값을 가지는 경우 > 식별자로 사용 가능하다.
        b. 값을 가지지 않는 경우 > 식별자로 사용 불가능하다.


5. Check
    - 사용자 정의 제약 조건
    - where절과 동일하다고 생각하면 굉장히 쉽다.(비교연산자, like, in, between 등..)


6. Default
    - 기본값 설정
    - 해당 컬럼값을 대입하지 않으면 null 대신 미리 준비한 값을 넣어준다.



*/


-- 메모 테이블
create table tblMemo(
    seq number(3) not null,               -- 메모 번호
    name varchar2(30),                     -- 작성자
    memo varchar2(1000),                -- 메모 내용
    regdate date                                 -- 작성 날짜
);


-- 테이블이 잘 생성되었는지 확인?
desc tblmemo;

-- tabs : 시스템 테이블. 현재 계정(HR)이 소유하고 있는 모든 테이블 목록
select * from tabs;

-- 데이터 추가하기
insert into 테이블명(컬럼리스트) values(값리스트);

insert into tblMemo(seq, name, memo, regdate) values (1, '홍길동', '메모입니다..', sysdate);
insert into tblMemo(seq, name, memo, regdate) values (2, '홍길동', '메모입니다..', sysdate);

select * from tblMemo;

select * 
from tblMemo
where seq = 1;


-- 전체 진도 1/3
-- DB 프로젝트 > 주제 고정 > 팀마다 회의 +a > 쌍용 교육 센터 관리 프로그램
-- 1. 요구 분석
-- 2. 순서도(선택)
-- 3. 데이터 설계(ERD)
-- 4. 데이터 설계 구현(DDL) > Query 작성
-- 5. 더미 데이터, 테스트 데이터 > Query 작성
-- 6. 데이터 조작(DML) > Query 작성
-- 7. PL/SQL 객체 생성


-- 테이블 삭제
drop table tblMemo;

-- 메모 테이블
create table tblMemo(
    seq number(3) primary key, 
    name varchar2(30),
    memo varchar2(1000),
    regdate date,
--    lv number(1) not null check(lv >= 1 and lv <= 5),
    lv number(1) not null check(lv between 1 and 5),
--    color varchar2(30) check(color in ('빨강', '파랑', '노랑'))
    jumin varchar2(13) check (substr(jumin, 7, 1) = '-')
);

-- '' : 빈 문자열도 null로 취급한다.
select * from tblMemo;
insert into tblMemo(seq, name, memo, regdate, lv) values (1, '홍길동', '메모입니다..', sysdate, 1);
insert into tblMemo(seq, name, memo, regdate, lv) values (2, '', '메모입니다..', sysdate, 6);


create table tblMemo(
    seq number(3) primary key,
    name varchar2(30) default '익명',
    memo varchar2(1000), 
    regdate date default sysdate
);


insert into tblMemo(seq, memo) values (1, '테스트~..');

/* 제약 사항을 만드는 방법

1. 컬럼 수준에서 만드는 방법
    - 지금껏 수업한 방법
    - 컬럼 1개를 정의할 때 제약 사항도 같이 정의하는 방법
    ex) seq number(3) primary key
    - 컬럼명 자료형(길이) [constraint 제약조건명] 제약조건

2. 테이블 수준에서 만드는 방법
    - 컬럼 정의와 제약 사항 정의를 분리해서 정의하는 방법

3. 독립으로 만드는 방법
    - alter 명령어

*/

create table tblMemo(
    -- 테이블명_컬럼명_제약종류 (모두 소문자로 써야함) 
    -- not null, default에는 제약을 안 붙임
    
    -- tblmemo_seq_pk
    -- tblmemo_name_uq
    -- tblmemo_color_ck
    
    seq number(3) constraint tblmemo_seq_pk primary key,  
    name varchar2(30),
    memo varchar2(1000), 
    regdate date default sysdate
);

insert into tblMemo(seq, name, memo, regdate) values (1, '홍길동', '메모입니다..', sysdate);



create table tblMemo(
    -- 컬럼 정의
    seq number(3) constraint tblmemo_seq_pk primary key,  
    name varchar2(30),
    memo varchar2(1000), 
    regdate date,
    
    -- 제약사항 정의
    constraint tblmemo_sep_pk primary key(seq),
    constraint tblmemo_name_uq(name),
    constraint tblmemo_regdate_ck check(to_number(to_char(regdate, hh24)) between 9 and 15)
);



