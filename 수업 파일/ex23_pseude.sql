-- ex23_pseude.sql

/* 의사 컬럼, Pseudo Column
- 실제 컬럼이 아닌데 컬럼처럼 행동하는 객체

rownum
- 행의 번호
- 결과셋의 부분 집합 추출 가능(레코드의 순서를 사용해서)
- from절이 실행될 때 할당 된다. (***)
- where절의 영향을 받아 reindexing된다. (유동적)
- 서브쿼리를 사용해서 rownum을 정적으로 고정시킨다. (***)


*/

select name, buseo, rownum
from tblInsa
where rownum <= 5;


-- rownum을 조건에 걸려면 적어도 1이 포함 되어야함.
select name, buseo, rownum from tblInsa where rownum = 2; -- X

-- rownum은 from이 실행될 때 계산
-- 인라인 서브쿼리 rownum 따로, 이 서브쿼리가 실행될 때의 rownum 따로
select name, buseo, rownum, rnum
from (select name, buseo, rownum as rnum from tblInsa);

-- 원하는 정렬을 한 후 행번호를 사용하고 싶을 땐 > 서브쿼리로 정렬을 먼저 한 후 > 메인쿼리에서 rownum 사용
select name, buseo, rownum 
from (select name, buseo, rownum from tblInsa order by basicpay desc);


-- rownum : 계산되는 컬럼 (동적) > where절의 영향 받음 
-- rnum : 계산이 완료된 컬럼 (정적) > where절의 영향 안 받음
select name, buseo, rownum, rnum
from (
    select name, buseo, rownum as rnum 
    from (select name, buseo, rownum from tblInsa order by basicpay desc)
)
where rnum between 3 and 5;


-- 1. 첫번째 서브쿼리 > 원하는 정렬
-- 2. 두번째 서브쿼리 > rownum(rnum) 생성
-- 3. 세번째 메인쿼리 > rnum 조건 + select


-- 끊어보기

-- * 와일드 카드와 다른 컬러을 같이 쓰려면 와일드카드 앞에 테이블명을 꼭 적어줘야함.
-- (테이블이름).*
select a.*, rownum from tbladdressbook a;

-- 1~20
select a.*, rownum 
from tbladdressbook a
where rownum <= 20;


-- 이름순 정렬 + 1~20
select *
from (
    select a.*, rownum as rnum
    from (select * from tbladdressbook order by name) a
)
where rnum between 21 and 40;



-- tblInsa.
-- 급여를 많이 받는 1-10등 + 이름, 부서, 급여
select *
from 
(
    select a.*, rownum as rnum
    from (select name, buseo, basicpay from tblInsa order by basicpay desc) a
)
where rnum <= 10;


-- tblCountry
-- 인구수가 3번째로 많은 나라의 이름과 인구수
select name, population from tblcountry where population is not null order by population desc;

select *
from 
(
    select a.*, rownum as rnum
    from (select name, population from tblcountry order by population desc nulls last) a
)
where rnum = 3;


-- tblComedian.
-- 체중 1-3등

select *
from (
    select a.*, rownum as rnum
    from ( select * from tblcomedian order by weight desc) a
)
where rnum <= 3;





















