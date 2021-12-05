-- ex07_order.sql


/*
정렬, sort
- order by절

오름차순 : asc (기본값)
내림차순 : desc


*/


select * 
from tblcountry
order by name;

SELECT name, jikwi
FROM tblinsa
where buseo = '기획부'
order by name desc;


-- 다중 정렬
SELECT name, buseo, jikwi, basicpay
FROM tblinsa
order by buseo, jikwi, basicpay desc;

-- 응용 : 가공된 값도 정렬 기준이 될 수 있음
SELECT name, buseo, jikwi, basicpay, sudang
FROM tblinsa
order by basicpay + sudang desc;

-- 직위별로 정렬 부장 > 과장 > 대리 > 사원
-- 자바 >> 멤버 변수 추가 > 숫자 
-- case로 변수처럼 숫자를 주고 해당 컬럼명으로 sorting
SELECT 
    name, jikwi,
    case
        when jikwi = '부장' then 4
        when jikwi = '과장' then 3
        when jikwi = '대리' then 2
        when jikwi = '사원' then 1
    end as seq
FROM tblinsa
order by seq desc;

-- 흠 좀 쩌는군... case-end -> 컬럼 들어가는 곳에 다 사용 가능
SELECT name, jikwi
FROM tblinsa
order by 
    case
        when jikwi = '부장' then 4
        when jikwi = '과장' then 3
        when jikwi = '대리' then 2
        when jikwi = '사원' then 1
    end desc;


-- 기획부 : 남자직원 > 여자직원
select * 
from tblInsa 
where buseo = '기획부'
order by 
    case 
        when ssn like '%-1%' then 1
        else 2
    end;








