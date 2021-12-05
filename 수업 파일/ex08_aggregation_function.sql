-- ex08_aggregation_function.sql

/*
자바
- 클래스(객체) : 멤버 변수 + 멤버 메소드
- 클래스가 소유하는 함수를 메소드라고 부른다.

오라클
- 클래스(객체) : 존재x
- 함수(function) 제공 > 계정(hr)에 소속
    a. 내장형 함수(Built-in Function)
    b. 사용자 정의 함수(User Function) : PL/SQL
    
집계 함수, Aggregation Function
- 통계값
1. count()
- 매개변수의 컬럼은 1개만 넣을 수 있다.
- 단, *은 넣을 수 있다.
- null은 제외(***)


2. sum()
3. avg()


4. max()
5. min()
- object max(컬럼명)
- object min(컬럼명)
- 숫자형, 문자형, 날짜형 모두 적용

*/

SELECT count(name) FROM tblcountry;


select 
    count(*) as 할일,
    count(completedate) as 완료,
    count(*) - count(completedate) as 미완료
from tbltodo;


-- tblinsa. 총직원수, 연락처가 있는 직원수, 연락처가 없는 직원수
SELECT
    count(*) as 총직원수,
    count(tel) as 연락처존재,
    count(*) - count(tel) as 연락처부재
FROM tblinsa;

-- 부서가 몇 개 인가
select count(distinct buseo) as 부서수
from tblinsa;

-- 총인원수, 남자수, 여자수
select 
    count(*) as 전체,
    count(
    case
        when gender = 'm' then 1
    end) as 남자,
    count(
    case
        when gender = 'f' then 1
    end) as 여자
from tblcomedian;


-- tblinsa. 80년대생 남자/여자수, 90년대생 남자/여자수.
select
    count(*) as 전체직원수,
    count(case when ssn like '8%-1%' then 1 end ) as "80년대 남자",
    count(case when ssn like '8%-2%' then 1 end ) as "80년대 여자",
    count(case when ssn like '9%-1%' then 1 end ) as "90년대 남자",
    count(case when ssn like '9%-2%' then 1 end ) as "90년대 여자"
from tblinsa;





-- 2021-11-11 세번째 문제?

-- 1. tblCountry. 아시아(AS)와 유럽(EU)에 속한 나라의 개수?? -> 7개
select count(*)
from tblCountry
where continent in ('AS', 'EU');


-- 2. 인구수가 7000 ~ 20000 사이인 나라의 개수?? -> 2개
select count(*)
from tblCountry
where population between 7000 and 20000;


-- 3. hr.employees. job_id > 'IT_PROG' 중에서 급여가 5000불이 넘는 직원이 몇명? -> 2명
select count(*)
from employees
where job_id = 'IT_PROG' and salary >= 5000;


-- 4. tblInsa. tel. 010을 안쓰는 사람은 몇명?(연락처가 없는 사람은 제외) -> 42명
select count(*)
from tblInsa
where tel not like '010%';


-- 5. city. 서울, 경기, 인천 -> 그 외의 지역 인원수? -> 18명
select count(*)
from tblInsa
where city not in ('서울', '경기', '인천');


-- 6. 여름태생(7~9월) + 여자 직원 총 몇명? -> 명
select count(*)
from tblInsa
where ssn like '___7%-2%'
    or ssn like '___8%-2%'
    or ssn like '___9%-2%';
    

-- 7. 개발부 + 직위별 인원수? -> 부장?명, 과장?명, 대리?명, 사원?명
select 
    count(case when buseo = '개발부' then 1 end) as 개발부,
    count(case when buseo = '개발부' and jikwi = '부장' then 1 end) as 부장,
    count(case when buseo = '개발부' and jikwi = '과장' then 1 end) as 과장,
    count(case when buseo = '개발부' and jikwi = '대리' then 1 end) as 대리,
    count(case when buseo = '개발부' and jikwi = '사원' then 1 end) as 사원
from tblInsa;



/*
2. sum()
- 해당 컬럼값의 합을 구한다.
- number sum(컬럼명)
- 숫자형 컬럼에 적용한다.(문자형x, 날짜형x)

*/
select 
    sum(basicpay),
    sum(sudang),
    sum(basicpay) + sum(sudang)
from tblinsa;

/*
3. avg()
- number avg(컬럼명)
- 해당 컬럼값의 평균을 구한다.
- 숫자형 컬럼에 적용한다.
- null인 레코드는 몫에서 제외. (***)
*/

select avg(basicpay)
from tblinsa;


-- 주의!!!
select 
    avg(population)
from tblCountry;

-- 회사 성과급 지급
-- : 실적 발생 > 지급
-- 1. 균등 지급 : 총지급액 / 모든 팀원수 = sum() / count(*)
-- 2. 차등 지급 : 총지급액 / 참여 팀원수 =  sum() / count(참여팀원) = avg()

-- max / min 
select max(height), min(height) 
from tblcomedian;

select 
    count(*) as "영업부 직원수",
    sum(basicpay) as "영업부 총급여 합",
    avg(basicpay) as "영업부 평균 급여",
    max(basicpay) as "영업부 최고 급여",
    min(basicpay) as "영업부 최소 급여"
from tblinsa
where buseo = '영업부';


-- 집계 함수 사용 시 주의점!!(*****)
-- 1. ORA-00937: not a single-group group function
-- 컬럼 리스트에 집계 함수와 단일 컬럼은 동시에 사용할 수 없다. > 성질이 다르다.
-- > 집계 함수(집합값), 단일 컬럼(개인값)
select name, count(*) from tblinsa; -- error!

-- 2. ORA-00934: group function is not allowed here
-- where절에는 집계 함수 사용 금지
-- where절은 개개인에 대한 조건을 다루는 영역
select * 
from tblinsa
where basicpay > avg(basicpay); -- error



-- 2021-11-12
--sum()
--1. 유럽과 아프리카에 속한 나라의 인구 수 합? tblCountry > 14,198
select sum(population)
from tblCountry
where continent in ('EU', 'AF');


--2. 매니저(108)이 관리하고 있는 직원들의 급여 총합? hr.employees > 39,600
select sum(salary)
from employees
where manager_id = 108;


--3. 직업(ST_CLERK, SH_CLERK)을 가지는 직원들의 급여 합? hr.employees > 120,000
select sum(salary)
from employees
where job_id in ('ST_CLERK', 'SH_CLERK');


--4. 서울에 있는 직원들의 급여 합(급여 + 수당)? tblInsa > 33,812,400
select sum(basicpay) + sum(sudang)
from tblInsa 
where city = '서울';


--5. 장급(부장+과장)들의 급여 합? tblInsa > 36,289,000
select sum(basicpay)
from tblInsa 
where jikwi in ('부장', '과장');


--avg()
--1. 아시아에 속한 국가의 평균 인구수? tblCountry > 39,165
select avg(population)
from tblCountry
where continent = 'AS';


--2. 이름(first_name)에 'AN'이 포함된 직원들의 평균 급여?(대소문자 구분없이) hr.employees > 6,270.4
select avg(salary)
from employees
where first_name like '%AN%' 
    or first_name like '%an%'    
    or first_name like '%An%' 
    or first_name like '%aN%';


--3. 장급(부장+과장)의 평균 급여? tblInsa > 2,419,266.66
select avg(basicpay)
from tblInsa 
where jikwi in ('부장', '과장');


--4. 사원급(대리+사원)의 평균 급여? tblInsa > 1,268,946.66
select avg(basicpay)
from tblInsa 
where jikwi in ('대리', '사원');


--5. 장급(부장,과장)의 평균 급여와 사원급(대리,사원)의 평균 급여의 차액? tblInsa > 1,150,320
select 
    avg(case when jikwi in ('부장', '과장') then basicpay end) -
    avg(case when jikwi in ('대리', '사원') then basicpay end) as "장급avg - 사원급avg"
from tblInsa;


--max(),min()
--1. 면적이 가장 넓은 나라의 면적은? tblCountry > 959
select max(area)
from tblCountry;


--2. 급여(급여+수당)가 가장 적은 직원은 총 얼마를 받고 있는가? tblInsa > 988,000
select min(basicpay + sudang)
from tblInsa;




