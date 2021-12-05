-- 2021-11-11

-- Q16.
select *
from tblInsa
where basicpay * 12 > 20000000 and city = '서울' and jikwi in('과장','부장');


-- Q17.

-- 조건
select *
from tblCountry
where name like '_국';

-- 추가조건
select *
from tblCountry
where name like '%국';


-- Q18.
select *
from employees
where phone_number like '515%';


-- Q19.
select *
from employees
where job_id like 'SA%';


-- Q20.
select *
from employees
where first_name like '%de%' 
            or first_name like '%DE%' 
            or first_name like '%De%' 
            or first_name like '%dE%';


-- Q21.
select *
from tblInsa
where ssn like '%-1%';


-- Q22.
select *
from tblInsa
where ssn like '%-2%';



-- Q23.
select *
from tblInsa
where ssn like '___7%' or ssn like '___8%' or ssn like '___9%';


-- Q24.
select *
from tblInsa
where city in ('서울', '인천') and name like '김%';


-- Q25.
select *
from tblInsa
where buseo in ('영업부', '총무부', '개발부') and jikwi in ('사원', '대리') and tel like '010%';


-- Q26.
select *
from tblInsa
where city  in ('서울', ' 인천' , '경기') and ibsadate between '2008-01-01' and '2010-12-31';


-- Q27.
select *
from employees
where department_id is null;


-- Q28.
select distinct job_id
from employees;


-- Q29.
select distinct department_id
from employees
where hire_date between '2002-01-01' and '2004-12-31';


-- Q30.
select manager_id
from employees
where salary > 5000;


-- Q31.
select distinct jikwi
from tblInsa
where ssn like '8%-1%';


-- Q32.
select distinct city
from tblInsa
where sudang > 200000;


-- Q33.
select buseo
from tblInsa
where tel is null;


