-- ex21_view.sql


/* 데이터 확보 해야함

1. 컬럼이 많아져야 할 것.

create table tblmember (
    id,
    pw,
    name,
    생일, 취미, 학력, a,b,c ...
);
--> 써먹든 안 써먹든 투머치 같아도 최대한 많이 확보하는게 좋음


* 데이터 확보 *
1. 랜덤 생성
--> 이클립스, 데이터생성 클래스 참고


2. 복붙 (엑셀기반)
    -- 길이, null값 유무를 쉽게 파악할 수 있다.
    -- RDBMS들이 엑셀 데이터를 쉽게 import 할 수 있음
    -- 테이블 생성 > 목록에서 테이블 오른쪽 버튼 임포트 > 엑셀 파일 선택 > 시작 행 선택 > 매칭 > 
    -- 정리해놓기...


    2.1 테이블 생성
        -- 한글 3바이트 신경쓰기
        -- null 여부 모르면 그냥 허용
    2.2 데이터 가져오기


*/


create table tblMovie (
    seq number primary key, -- 엑셀의 첫번째 칸에 열 삽입으로 넣어줌(속성타이틀 필수)
    title VARCHAR2(200) not null, 
    title_en VARCHAR2(100) null,
    year VARCHAR2(4) null,
    country VARCHAR2(100) not null,
    type VARCHAR2(20) not null,
    genre VARCHAR2(100) null,
    status VARCHAR2(20) not null,
    director VARCHAR2(300) null,
    company VARCHAR2(500) null
);


select * from tblMovie where title like '%어벤져스%';




/*
View, 뷰
- DB Object 중 하나(테이블, 시퀀스, 제약사항, 뷰) > create, drop
- 가상 테이블, 테이블의 복사본, 뷰 테이블 등..
- 취급 : 테이블처럼 사용하면 된다(***)
- 정의 : select문을 저장한 객체입니다.


뷰 목적(효과)
1. 자주 반복되는 쿼리나, 긴 문장의 쿼리를 식별자를 붙여 저장한 뒤 간편하게 사용하기 위해서..
2. 보안 > 접근 권한 통제.. 

create view 뷰이름
as 
select 문


-- 생성 및 수정
create [or replace] view 뷰이름
as 
select 문

*/

create view vwInsa
as 
select * from tblInsa;

select * from vwInsa;

--
drop view vwInsa2;

create or replace view vwInsa2 -- 생성 및 수정
as 
select *
from tblInsa
where buseo = '홍보부';

select * from vwInsa2; -- 쿼리가 짧아졌당..!!!



--
create or replace view vwVideo
as
select
    r.seq as rseq,
    m.name as mname,
    v.name as vname,
    to_char(r.rentdate, 'yyyy-mm-dd') as rentdate
from tblRent r 
        inner join tblVideo v on v.seq = r.video
        inner join tblMember m on m.seq = r.member;


select * from vwVideo;

create or replace view vwSeoul
as
select * from tblInsa where city = '서울';

select * from vwSeoul;
-- ==
select * from (select * from tblInsa where city = '서울'); -- 인라인 뷰




-- 뷰를 생성할 당시 코메디언 10명
create or replace view vwComedian
as 
select * from tblComedian;

select * from vwComedian;



-- 뷰를 생성한 후에 원본 테이블에 행 1개 추가

-- 뷰 사용 시
-- 1. select    > 실행O > 뷰는 읽기 전용으로 사용한다. 읽기 전용 테이블
-- 2. insert    > 실행O > 절대 사용 금지
-- 3. update > 실행O > 절대 사용 금지
-- 4. delete   > 실행O > 절대 사용 금지


insert into tblComedian values('나미', '오', 'f', 165, 60, '오나미');
update vwcomedian set first ='나비' where first = '나미';



select * from tblComedian;



create or replace view vwSales
as
select name, item from tblCustomer c 
        inner join tblSales s on c.seq = s.cseq;

select * from vwSales;














