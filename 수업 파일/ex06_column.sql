-- ex06_column.sql

/*
컬럼 리스트에서 할 수 있는 행동들..

distinct
- 컬럼 리스트에서 사용
- distinct 컬럼명
- 중복값을 제거한다.

*/

select distinct continent 
from tblCountry;

select distinct buseo
from tblInsa;

-- ***
-- 대륙은 중복값을 제거하고, 국가명은 그대로 가져오시오 > 관계형 DB에서는 불가능한 질문
-- 중복값이 존재하는 컬럼과, 중복값이 존재하지 않은 컬럼이 같이 있으면 distinct는 의미없다.
select distinct continent, name -- distinct (continent, name)의 의미임.
from tblCountry;

select distinct continent, name
from tblCountry;

select distinct buseo, jikwi
from tblInsa;

-- 중복 제거를 할 마음이 없다는 뜻.. > 테이블은 반드시 기본키 존재 > 행과 행에 다른 데이터 존재
select distinct * from tblInsa;


/*
case -- 모르고 파일을 날려먹음.. 선생님 파일로 복구해놓기... 



*/


-- 입사일(근무년차)
-- 3년 미만 :


select name, ibsadate,
    case
        when ibsadate > '2016-11-11' then '주니어'
        when ibsadate <= '2016-11-11' and ibsadate > '2011-11-11' then '시니어'
        when ibsadate <= '2011-11-11' then '익스퍼트'
    end 
from tblInsa;


select * from tblTodo where completedate is null; -- 해야할 일
select * from tblTodo where completedate is not null; -- 완료된 일

SELECT
    title,
    case
        when completedate is not null then '완료된일'
        when completedate is null then '해야할일'
    end as 체크리스트
FROM tbltodo;


SELECT
    name,
    case
        when couple is null then '솔로'
        when couple is not null then '커플'
    end as state
FROM tblMen;


select 
    name, jikwi, sudang,
    case
--        when jikwi = '부장' then sudang*2
--        when jikwi = '과장' then sudang*1.7
--        when jikwi = '대리' then sudang*1.5
--        when jikwi = '사원' then sudang*1.3
        when jikwi in ('부장', '과장') then sudang * 2
        when jikwi in ('대리', '사원') then sudang * 1.5
    end as bonus
from tblInsa;







