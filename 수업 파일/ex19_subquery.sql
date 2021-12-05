-- ex19_subquery.sql

/* 
Main Query, 일반 쿼리
- 하나의 select(insert, update, delete)로만 되어있는 쿼리

Sub Query, 서브 쿼리, 부속 질의
- 하나의 쿼리 안에 또 다른 쿼리가 들어있는 쿼리
- 하나의 select(insert, update, delete)안에 또 다른 쿼리(select)가 들어있는 쿼리
- 삽입 위치 > select절, from절, where절, group by절, having절, order by절 등.. 

서브쿼리 용도
1. 조건절에 비교값으로 사용
    a. 반환값이 1행 1열   > 스칼라 쿼리 > 단일값 반환(원자값) > 상수 취급
    b. 반환값이 n행 1열   > 열거형 비교 > in 연산자
    c. 반환값이 1행  n열  > 그룹 + 연산자
    d. 반환값이 n행 n열   > b + c 혼합

*/

-- a. 반환값이 1행 1열   > 스칼라 쿼리
select name
from tblCountry
where population = (select max(population) from tblCountry);

select last || first
from tblcomedian
where weight = (select max(weight) from tblComedian);

select buseo
from tblInsa
where basicpay = (select max(basicpay) from tblInsa);

select name
from tblInsa
where basicpay > (select avg(basicpay) from tblInsa where city = '서울');

select *
from tblInsa
where buseo = (select buseo from tblInsa where name = '홍길동');


select *
from tblInsa
where name = (select name from tblInsa where buseo = '기획부');

-- b. 반환값이 n행 1열   > 열거형 비교
-- ORA-01427: single-row subquery returns more than one row
select *
from tblInsa
where buseo in (select buseo from tblInsa where basicpay >= 2500000);


-- c. 반환값이 1행  n열  > 그룹 + 연산자
select *
from tblInsa
where (city, buseo) = (select city, buseo from tblInsa where name = '홍길동');


-- d. 반환값이 n행 열    > 반환값이 n행 n열 > b + c 혼합
select *
from tblInsa
where (buseo, city) in (select buseo, city from tblInsa where basicpay >= 2600000);

-- 'Munich' 도시에 위치한 부서에 소속된 직원들 명단?
select * 
from employees
where department_id = ( select department_id from departments 
    where location_id = ( select location_id from locations where city = 'Munich')
);


select * from tblStudy;

/*
서브쿼리 용도
  1. 조건절에 비교값으로 사용
        a. 반환값이 1행 1열   > 스칼라 쿼리 > 단일값 반환(원자값) > 상수 취급
        b. 반환값이 n행 1열   > 열거형 비교 > in 연산자
        c. 반환값이 1행  n열  > 그룹 + 연산자
        d. 반환값이 n행 n열   > b + c 혼합

 2. 컬럼리스트에서 사용
        - 반드시 결과값이 1행 1열이어야 한다.(***)
        a. 정적 쿼리 > 모든 행에 동일한 값을 적용 > 사용 빈도 적음 
        b. 상관 서브 쿼리 > 서브 쿼리의 값과 바깥쪽 쿼리의 값을 서로 연결  > 사용 빈도 많음

3. From절에서 사용
    - 서브쿼리의 결과셋을 또 하나의 테이블이라고 생각하고 사용
    - 인라인 뷰(Inline View)

4. Group by, Having, Order by > (x) 활용도가 낮음

*/



-- 2. 컬럼 리스트에서 사용
select
    name,
    buseo,
    basicpay,
    (select round(avg(basicpay)) from tblInsa)
from tblInsa;


select
    name,
    buseo,
    basicpay,
    (select capital from tblCountry where name = '미국')
from tblInsa;


select
    name,
    height,
    couple,
    (select height from tblWomen where name = tblmen.couple) as height
from tblMen;


select
    name,
    buseo,
    (select round(avg(basicpay)) from tblInsa) as "전체 평균 급여",
    (select round(avg(basicpay)) from tblInsa where buseo = a.buseo) as "부서 평균 급여"
from tblInsa a ;

-- 직원 명단 가져오기
-- (employee_id, last_name || first_name, department_id)
select 
    employee_id,
    last_name || ' ' || first_name as full_name,
    (select department_name from departments where department_id = employees.department_id) as department_name
from employees;



-- 3. from절에서 사용

select *
from (select name, buseo, jikwi from tblInsa);


-- 4.
-- ORA-00960: ambiguous column naming in select list
-- 본 테이블과 서브테이블의 컬럼을 같은 이름으로 써서 Order by 했을 경우
select
    name,
    height,
    couple,
    (select height from tblWomen where name = tblmen.couple) as womenHeight
from tblMen
order by womenHeight desc;






