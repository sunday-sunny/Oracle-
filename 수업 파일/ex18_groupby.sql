-- ex18_groupby.sql


/* Group by
- group by 컬럼명
- 레코드들을 특정 컬럼값(1개, n개)에 맞추어 그룹을 나누는 역할
- 각각의 나눠진 그룹을 대상 > 집계 함수를 적용하기 위해(***)
- group by + having + rollup + cube


select 컬럼리스트
from 테이블
where 조건
group by 기준(컬럼명)
order by 기준
*/


-- tblInsa. 부서별로 평균 급여?
-- (***) group by절을 사용하면 select 컬럼 리스트를 주의해서 작성해야 한다.
--          group by절을 사용하면 > 컬럼 리스트 > 집계 함수만 작성할 수 있다.

select buseo, round(avg(basicpay)) -- 각 그룹에서다 select 적용
from tblInsa
group by buseo;


select substr(ssn, 8, 1) as gender, count(*)
from tblInsa
group by substr(ssn, 8, 1);


select gender, count(*)
from tblComedian
group by gender;

-- 지역별 인원수
select city, count(*) as 인원수
from tblInsa
group by city
order by 인원수 desc;


-- 대륙별 평균인원수
select continent, round(avg(population))
from tblCountry
group by continent;


select 
    jikwi, 
    count(*) as 직위별인원수,
    sum(basicpay) as 직위별급여총합,
    round(avg(basicpay)) as 직위별평균급여,
    max(ibsadate) as 직위별막내입사일 --ORA-00972: identifier is too long (오라클은 30바이트까지만 가능)
from tblInsa
group by jikwi;

-- 다중 그룹
select buseo, jikwi, city, count(*)
from tblInsa
group by buseo, jikwi, city
order by buseo, jikwi, count(*);


-- 급여별로 그룹 > 인원수? > 이걸 왜 하는..?
select 
    (floor(basicpay / 1000000) + 1 ) * 100 || '미만'  as 단위백, 
    count(*)
from tblInsa
group by floor(basicpay / 1000000);


-- 한 일의 개수? 안 한 일의 개수?
select
    case 
        when completedate is not null then 1
        when completedate is null then 2
    end,
    count(*)
from tblTodo
group by case 
    when completedate is not null then 1
    when completedate is null then 2
    end;


select job, count(*)
from tblAddressBook
group by job;



select 
    decode(gender, 'm', '남자', 'f', '여자') as gender,
    count(*) as cnt,
    avg(weight) as "평균 몸무게",
    avg(height) as "평균 키"
from tblComedian
group by gender;


/* Having */
select buseo, round(avg(basicpay))
from tblInsa
where basicpay >= 1500000
group by buseo
having avg(basicpay) >= 1500000;



-- 01.
select 
    continent, 
    max(population) as "최대 인구수", 
    min(population) as "최소 인구수",
    avg(population) as "평균"
from tblCountry
group by continent;


-- 02.
select job_id, count(*) as cnt
from employees
group by job_id;


-- 03.
select
    substr(address, 1, instr(address, ' ')-1) as "시도",
    count(*) as cnt
from tbladdressbook
group by substr(address, 1, instr(address, ' ')-1);


-- 04.
select 
    buseo,
    sum(basicpay) as "급여총합",
    count(*) as "부서인원수",
    max(basicpay) as "최고급여",
    min(basicpay) as "최저급여",
    round(avg(basicpay)) as "평균급여"
from tblInsa
group by buseo;


-- 05.
select 
    buseo as "[부서명]",
    count(*) as "[총인원]",
    count(case when jikwi = '부장' then 1 end) as "[부장]",
    count(case when jikwi = '과장' then 1 end) as "[과장]",
    count(case when jikwi = '대리' then 1 end) as "[대리]",
    count(case when jikwi = '사원' then 1 end) as "[사원]"
from tblInsa
group by buseo;



/* Rollup() 
- group by의 결과에서 집계 결과를 좀 더 자세하게 반환.
- 그룹별 중간 통계를 내고 싶을 때 사용
*/

select
    buseo,
    count(*) as cnt,
    sum(basicpay) as "합",
    round(avg(basicpay)) as "평균",
    max(basicpay) as "최대값",
    max(ibsadate)
from tblInsa
group by rollup(buseo);


select
    buseo,
    jikwi,
    count(*)
from tblInsa
group by rollup(buseo, jikwi);



/* cube()
- group by의 결과에서 집계 결과를 좀 더 자세하게 반환.
- 그룹별 중간 통계를 내고 싶을 때 사용

*/

select
    buseo,
    jikwi,
    count(*)
from tblInsa
group by cube(buseo, jikwi);

-- rollup > 다중 그룹이 수직 관계(상하 존재)
-- cobe > 다중 그룹이 수평 관계(동등)






