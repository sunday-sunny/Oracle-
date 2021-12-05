--23. tblStaff, tblProject. 현재 재직중인 모든 직원의 이름, 주소, 월급, 담당프로젝트명을 가져오시오.
select
    s.name, s.address, s.salary, p.projectname
from tblStaff s
        inner join tblProject p on s.seq = p.staff_seq;



--24. tblVideo, tblRent, tblMember. '뽀뽀할까요' 라는 비디오를 빌려간 회원의 이름은?
select 
    m.name
from tblMember m
        inner join tblRent r on m.seq = r.member
        inner join tblVideo v on r.video = v.seq
where v.name = '뽀뽀할까요';



--25. tblStaff, tblProejct. 'TV 광고'을 담당한 직원의 월급은 얼마인가?
select 
    s.salary
from tblStaff s
        inner join tblProject p on s.seq = p.staff_seq
where p.projectname = 'TV 광고';



--26. tblVideo, tblRent, tblMember. '털미네이터' 비디오를 한번이라도 빌려갔던 회원들의 이름은?
select 
    m.name
from tblMember m
        inner join tblRent r on m.seq = r.member
        inner join tblVideo v on r.video = v.seq
where v.name = '털미네이터';



--27. tblStaff, tblProject. 서울시에 사는 직원을 제외한 나머지 직원들의 이름, 월급, 담당프로젝트명을 가져오시오.
select
    s.name, s.salary, p.projectname
from tblStaff s
        inner join tblProject p on s.seq = p.staff_seq
where s.address not like '서울시';



--28. tblCustomer, tblSales. 상품을 2개(단일상품) 이상 구매한 회원의 연락처, 이름, 구매상품명, 수량을 가져오시오.
select
    c.tel, c.name, s.item, s.qty
from tblSales s
        inner join tblCustomer c on s.cseq = c.seq
where s.qty >= 2;



--29. tblVideo, tblGenre. 모든 비디오 제목, 보유수량, 대여가격을 가져오시오.
select 
    v.name,
    v.qty,
    g.price
from tblGenre g
        inner join tblvideo v on g.seq = v.genre;



--30. tblVideo, tblRent, tblMember, tblGenre. 2007년 2월에 대여된 구매내역을 가져오시오. 회원명, 비디오명, 언제, 대여가격
select 
    m.name as mname,
    v.name as vname,
    r.rentdate,
    g.price
from tblMember m
        inner join tblRent r on m.seq = r.member
        inner join tblVideo v on r.video = v.seq
        inner join tblGenre g on v.genre = g.seq
where r.rentdate between '2007-02-01' and '2007-02-28';



--31. tblVideo, tblRent, tblMember. 현재 반납을 안한 회원명과 비디오명, 대여날짜를 가져오시오.
select 
    m.name as mname,
    v.name as vname,
    r.rentdate
from tblMember m
        inner join tblRent r on m.seq = r.member
        inner join tblVideo v on r.video = v.seq
where r.retdate is null;



--33. employees, departments. 사원들의 이름, 부서번호, 부서명을 가져오시오.
select
    e.first_name || ' ' || e.last_name as name,
    d.department_id,
    d.department_name
from employees e
        inner join departments d on e.department_id = d.department_id;



--34. employees, jobs. 사원들의 정보와 직업명을 가져오시오.
select * from employees;
select * from departments;
select * from jobs;

select
    e.employee_id,
    e.first_name || ' ' || e.last_name as name,
    j.job_title
from employees e
        inner join jobs j on e.job_id = j.job_id;


-- 다시 풀기
-- 35번은 직원들 중에서 가장 높은 급여를 찾는게 아니라, jobs 테이블에 있는 최고급여(max_salary)를 받는 직원을 찾는겁니다
-- 그러니 직원들 중 직업별 최고급여를 실제로 한명도 받지 못할 가능성도 있습니다.
--35. employees, jobs. 직무(job_id)별 최고급여(max_salary) 받는 사원 정보를 가져오시오.
select
    j.job_id,
    max(e.salary),
    e.first_name || ' ' || e.last_name as name
from employees e
        inner join jobs j on e.job_id = j.job_id
group by j.job_id;



--36. departments, locations. 모든 부서와 각 부서가 위치하고 있는 도시의 이름을 가져오시오.
select
    d.department_id,
    d.department_name,
    d.manager_id,
    d.location_id,
    l.city
from departments d
        inner join locations l on d.location_id = l.location_id;



--37. locations, countries. location_id 가 2900인 도시가 속한 국가 이름을 가져오시오.
select
    c.country_name
from locations l
        inner join countries c on l.country_id = c.country_id
where l.location_id = 2900;



--38. employees. 급여를 12000 이상 받는 사원과 같은 부서에서 근무하는 사원들의 이름, 급여, 부서번호를 가져오시오.
select 
    first_name || ' ' || last_name as name,
    salary,
    department_id
from employees
where department_id in (select department_id from employees where salary > 12000);




--39. employees, departments. locations.  'Seattle'에서(LOC) 근무하는 사원의 이름, job_id, 부서번호, 부서이름을 가져오시오.
select
    e.first_name || ' ' || e.last_name as name,
    e.job_id,
    d.department_id,
    d.department_name
from employees e
        inner join departments d on e.department_id = d.department_id
        inner join locations l on d.location_id = l.location_id
where l.city = 'Seattle';



--40. employees, departments. first_name이 'Jonathon'인 직원과 같은 부서에 근무하는 직원들 정보를 가져오시오.
select *
from employees e
        inner join departments d on e.department_id = d.department_id
where e.department_id = (select department_id from employees where first_name = 'Jonathon');



--41. employees, departments. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을 출력하는데 월급이 3000이상인 사원을 가져오
select 
    e.first_name || ' ' || e.last_name as name,
    d.department_name,
    e.salary
from employees e
        inner join departments d on e.department_id = d.department_id
where e.salary >= 3000;



--42. employees, departments. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름, 월급을 가져오시오.
select
    d.department_id,
    d.department_name,
    e.first_name || ' ' || e.last_name as name,
    e.salary
from employees e
        inner join departments d on e.department_id = d.department_id
where e.department_id = 10;



--44. departments, job_history. 퇴사한 사원의 입사일, 퇴사일, 근무했던 부서 이름을 가져오시오.
select 
    j.start_date,
    j.end_date,
    d.department_name
from job_history j 
        inner join departments d on j.department_id = d.department_id;



--45. employees. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의 사원번호와 사원이름을 출력하되 각각의 컬럼명을 '사원번호', '사원이름', '관리자번호', '관리자이름'으로 하여 가져오시오.
select
    employee_id as "사원번호",
    first_name || ' ' || last_name as "사원이름",
    manager_id as "관리자번호",
    (select first_name || ' ' || last_name from employees where employee_id = e.manager_id) as "관리자이름"
from employees e;



-- 날짜 표현 수정 필요
--46. employees, jobs. 직책(Job Title)이 Sales Manager인 사원들의 입사년도와 입사년도(hire_date)별 평균 급여를 가져오시오. 년도를 기준으로 오름차순 정렬.
select 
    substr(hire_date, 1, 2) as "입사년도",
    avg(salary) as "평균급여"
from employees e
        inner join jobs j on e.job_id = j.job_id
where j.job_title = 'Sales Manager'
group by substr(hire_date, 1, 2)
order by substr(hire_date, 1, 2);



--47. employees, departments. locations. 각 도시(city)에 있는 모든 부서 사원들의 평균급여가 가장 낮은 도시부터 도시명(city)과 평균연봉, 해당 도시의 사원수를 가져오시오. 단, 도시에 근 무하는 사원이 10명 이상인 곳은 제외하고 가져오시오.
select 
    city,
    avg(salary) as "평균급여",
    count(*) as cnt
from employees e
        inner join departments d on e.department_id = d.department_id
        inner join locations l on d.location_id = l.location_id
group by city
having count(*) < 10
order by avg(salary);



--48. employees, jobs, job_history. ‘Public Accountant’의 직책(job_title)으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 가져오시오. 현재 ‘Public Accountant’의 직책(job_title)으로 근무하는 사원은 고려 하지 말것.
select 
    e.employee_id,
    e.first_name || ' ' || e.last_name as name
from job_history jh
        inner join jobs j on jh.job_id = j.job_id
        inner join employees e on jh.employee_id = e.employee_id
where j.job_title = 'Public Accountant';



--49. employees, departments, locations. 커미션을 받는 모든 사람들의 first_name, last_name, 부서명, 지역 id, 도시명을 가져
select 
    e.first_name || ' ' || e.last_name as name,
    d.department_name,
    l.location_id,
    l.city
from employees e
        inner join departments d on e.department_id = d.department_id
        inner join locations l on d.location_id = l.location_id
where e.commission_pct is not null;



--50. employees. 자신의 매니저보다 먼저 고용된 사원들의 first_name, last_name, 고용일을 가져오시오.
select
    e.first_name || ' ' || e.last_name as name,
    e.hire_date
from employees e
        inner join employees m on e.manager_id = m.employee_id
where e.hire_date < m.hire_date;


