-- 2021-11-10

-- Q01.
select *
from tblCountry;


-- Q02.
select name, capital 
from tblCountry;


-- Q03.
select name as "[국가명]", capital as "[수도명]", population as "[인구수]", area as "[면적]", continent as "[대륙]" 
from tblCountry;


-- Q04.
select '국가명:' || name || ' ,수도명:' || capital || ' ,인구수:' || population  as "[국가정보]"
from tblCountry;


-- Q05.
select first_name || ' ' || last_name as 이름 , email || '@GMAIL.COM' as 이메일, phone_number as 연락처, '$' || salary as 급여
from employees;


-- Q06.
select name, area
from tblCountry
where area <= 100;


-- Q07.
select *
from tblCountry
where continent in ('AS', 'EU');


-- Q08.
select first_name || ' ' || last_name as name, phone_number
from employees
where job_id = 'IT_PROG';


-- Q09.
select first_name || ' ' || last_name as name, phone_number, hire_date
from employees
where last_name like '%Grant';


-- Q10.
select first_name || ' ' || last_name as name, salary, phone_number
from employees
where manager_id = 120;


-- Q11.
select first_name || ' ' || last_name as name, phone_number, email, department_id
from employees
where department_id in (60, 80, 100);


-- Q12.
select *
from tblInsa
where buseo = '기획부';


-- Q13.
select name, jikwi, tel
from tblInsa
where city = '서울' and jikwi = '부장';


-- Q14.
select *
from tblInsa
where (basicpay + sudang) >= 1500000 and city = '서울';


-- Q15.
select *
from tblInsa
where sudang <= 150000 and jikwi in ('사원', '대리');


