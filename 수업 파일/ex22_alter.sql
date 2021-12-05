-- ex22_alter.sql

/*
객체생성 : create
객체삭제 : drop
객체수정 : alter

데이터생성 : insert
데이터삭제 : delete
데이터수정 : update

수정 대상 : 테이블

테이블 수정하기, Alter table
- 테이블 스키마 수정 > 테이블 구조 수정 > 컬럼의 정의를 수정 + 제약사항 정의를 수정
- 되도록 테이블을 수정하는 상황을 발생하면 안된다(*****) > 설계 올바르게!!

1. 테이블 삭제 > 테이블 DDL(create) 수정 > 수정 DDL로 새롭게 테이블 생성
    a. 기존 테이블에 데이터가 없었을 경우 > 아무일 없음
    b. 기존 테이블에 데이터가 있었을 경우 > 미리 데이터 백업 > 테이블 삭제 > 수정 후 생성 > 데이터 복구 
    - 개발(공부) 중에 사용 가능한 방법
    - 서비스 운영 중에는 거의 불가능한 방법
    
2. Alter 명령어 사용 > 기존 테이블의 구조를 변경
    a. 기존 테이블에 데이터가 없었을 경우 > 아무일 없음
    b. 기존 테이블에 데이터가 있었을 경우 > 동반되는 추가 조치 필요!!
    - 개발(공부) 중에 사용 가능한 방법
    - 서비스 운영 중에 사용 가능한 방법
    
*/
drop table tblEdit;

create table tblEdit (
    seq number primary key,
    data VARCHAR2(20) not null
);

insert into tblEdit values (1, '마우스');
insert into tblEdit values (2, '키보드');
insert into tblEdit values (3, '모니터');
---> 이것이 곧 백업... 스크립트를 잘 관리해야함..


select * from tblEdit;


-- 1. 새로운 컬럼 추가하기
-- 새로운 컬럼은 null로 추가됨
alter table tblEdit
    add(price number(5) null); 




-- ORA-01758: table must be empty to add mandatory (NOT NULL) column
-- 테이블의 내용을 전부 지워야지만 not null 컬럼 추가 가능
alter table tblEdit
    add(memo varchar2(100) not null); 

delete from tblEdit;    --not null 컬럼을 추가하려면 기존 데이터를 모두 삭제해야 한다.

insert into tblEdit values (1, '마우스', 300, '로지텍');



-- 데이터를 안 날리고 not null 컬럼을 추가하고 싶음..!
-- default 값을 추가해서 같이 만들어줌
-- default를 not null 앞에 써야 하나봄..
-- 이러고 값을 수정해줘야함.. 
alter table tblEdit
    add(memo varchar2(100) default '임시' not null ); 



-- 2. 컬럼 삭제하기 > 삭제해도 되는 컬럼인지 항상 확인!!
alter table tblEdit
    drop column memo;

-- PK를 지우면 어켕ㅠㅠ... > 절대 금지!! 
alter table tblEdit
    drop column seq;





-- 3. 컬럼 수정하기(자료형, 길이, 이름, 제약 사항)
insert into tbledit values (4, '최신형노트북임');

-- 3.1 컬럼의 길이 수정하기(확장, 수정)
-- 만약 기존 데이터보다 길이를 작게 수정하면 에러남.
alter table tblEdit
    modify (data varchar2(100));


-- 3.2 컬럼의 제약사항 수정하기
alter table tbledit
    modify(data varchar(100) not null);


-- 3.3 컬럼의 자료형 바꾸기
-- 데이터를 삭제하고 바꿔야함.. 하지만 자료형 바꾸는건 지양..
-- ORA-01439: column to be modified must be empty to change datatype
-- 01439. 00000 -  "column to be modified must be empty to change datatype"
alter table tbledit
    modify(seq varchar2(100));


-- 3.4 컬럼명 바꾸기 
-- 이것도 절대 지양.. 짜놨던 모든 쿼리를 수정해야함..
alter table tblEdit
    rename column data to name;

select * from tblEdit;


------------------------------------------------------ 테이블 구조 수정


------------------------------------------------------ 제약사항 수정
-- 제약 사항 수정 > 추가 & 삭제
drop table tblEdit;

create table tblEdit (
    seq number,
    data VARCHAR2(20),
    color varchar2(30)
);

alter table tblEdit
        add constraint tbledit_seq_pk primary key(seq);
--> 이렇게 테이블 만들 수도 있음
--> 가독성이 좋다..! 관리 조직적으로 가능..!

alter table tblEdit
        add constraint tbledit_color_ck check(color in ('red', 'yellow', 'blue'));

insert into tblEdit values (1, '마우스', 'red');
insert into tblEdit values (2, '키보드', 'blue');
insert into tblEdit values (3, '모니터', 'green);

-- 제약사항 삭제
alter table tblEdit
        drop constraint tbledit_color_ck;


-- 이번 프로젝트는 쿼리문까지만 만드는 것... insert into...
-- 자바는 고려하지 않음ㄷㄷ...


/* 인증(로그인, 로그아웃)
: 회원 확인 > 증표 부여 

-- 회원 확인 > 로그인
select count(*) as cnt from tblTeacher where id = 'hong' and pw = '1111';
해당 쿼리를 자바에서 실행하여 결과로 로그인 여부를 결정.. 


< 이번 프로젝트의 목적!>
1. 요구분석에 맞는 쿼리를 잘 도출하는 것
2. 요구사항에 맞는 테이블을 잘 정의하는 것


*/







