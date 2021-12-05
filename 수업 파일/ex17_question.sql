--1. tblCountry. 모든 행과 모든 컬럼을 가져오시오.
select * from tblCountry;


--2. tblCountry. 국가명과 수도명을 가져오시오.
select name, capital 
from tblCountry;


--3. tblCountry. 아래와 같이 가져오시오.
--    [국가명]       [수도명]       [인구수]       [면적]        [대륙]
--    대한민국        서울          4405           10           AS
--    ..

select name as "[국가명]", capital as "[수도명]", population as "[인구수]", area as "[면적]", continent as "[대륙]" 
from tblCountry;


--4. tblCountry. 아래와 같이 가져오시오.
--    [국가정보]
--    국가명:대한민국, 수도명:서울, 인구수:4405
--    국가명:중국, 수도명:베이징, 인구수: 120660
--    ..

select '국가명 : ' || name || ', 수도명 : ' || capital || ', 인구수 : ' || population as "[국가정보]"
from tblCountry;


--5. employees. 직원명, 이메일, 연락처, 급여를 가져오시오.
--    [이름]            [이메일]                   [연락처]           [급여]
--    Steven King       SKING@GMAIL.COM           515.123.4567     $24000
--    ..

select 
    first_name || ' ' || last_name as "[이름]",
    email || '@GMAIL.COM' as "[이메일]",
    phone_number as "[연락처]",
    salary as "[급여]"
from employees;


--6. tblCountry. 면적(area)이 100이하인 국가의 이름과 면적을 가져오시오.
select name, area
from tblCountry
where area <= 100;


--7. tblCountry. 아시아와 유럽 대륙에 속한 나라를 가져오시오.
select *
from tblCountry
where continent in ('AS', 'EU');


--8. employees. 직업(job_id)이 프로그래머(it_prog)인 직원의 이름(풀네임)과 연락처 가져오시오.
select first_name || ' ' || last_name as full_name, phone_number
from employees
where job_id = 'IT_PROG';


--9. employees.  last_name이 'Grant'인 직원의 이름, 연락처, 고용날짜를 가져오시오.
select first_name || ' ' || last_name as full_name, phone_number, hire_date
from employees
where last_name like 'Grant';


--10. employees. 특정 매니저(120)이 관리하는 직원의 이름, 급여, 연락처를 가져오시오.
select first_name || ' ' || last_name as full_name, salary, phone_number
from employees
where manager_id = 120;


--11. employees. 특정 부서(60, 80, 100)에 속한 직원들의 이름, 연락처, 이메일, 부서ID 가져오시오.
select
    first_name || ' ' || last_name as full_name,
    phone_number,
    email,
    department_id
from employees
where department_id in (60, 80, 100);


--12. tblInsa. 기획부 직원들을 모두 가져오시오.
select *
from tblInsa
where buseo = '기획부';


--13. tblInsa. 서울에 있는 직원들 중 직위가 부장인 사람의 이름, 직위, 전화번호를 가져오시오.
select name, jikwi, tel
from tblInsa
where city = '서울' and jikwi = '부장';


--14. tblInsa. 기본급여 + 수당 합쳐서 150만원 이상인 직원 중 서울에 직원만 가져오시오.
select *
from tblInsa
where basicpay + sudang >= 1500000 and city = '서울';


--15. tblInsa. 수당이 15만원 이하인 직원 중 직위가 사원, 대리만 가져오시오.
select *
from tblInsa
where sudang <= 150000 and jikwi in ('사원', '대리');


--16. tblInsa. 수당을 제외한 기본 연봉이 2천만원 이상, 서울, 직위 과장(부장)만 가져오시오
select *
from tblInsa
where basicpay * 12 >= 20000000 and city = '서울' and jikwi = '과장';


--17. tblCountry. 국가명 'O국'인 나라를 가져오시오.
--    a. 국가명 2글자
--    b. 국가명 글자수 상관없이
select *
from tblCountry
where name like '_국';

select *
from tblCountry
where name like '%국';


--18. employees. 연락처가 '515'로 시작하는 직원들을 가져오시오.
select *
from employees
where phone_number like '515%';


--19. employees. 직업 ID가 'SA'로 시작하는 직원들을 가져오시오.
select *
from employees
where job_id like 'SA%';


--19. employees. first_name에 'de'가 들어간 직원들을 가져오시오.(대소문자 상관없이)
select *
from employees
where upper(first_name) like '%DE%';


--20. tblInsa. 남자 직원만 가져오시오.
select *
from tblInsa
where substr(ssn, 8, 1) = 1;


--21. tblInsa. 여자 직원만 가져오시오.
select *
from tblInsa
where substr(ssn, 8, 1) = 2;


--22. tblInsa. 여름에 태어난 직원들을 가져오시오.(7~9월생)
select *
from tblInsa
where substr(ssn, 4, 1) in (7, 8, 9);


--23. tblInsa. 서울, 인천에 사는 김씨 성을 가진 직원들을 가져오시오.
select *
from tblInsa
where city in ('서울', '인천') and name like '김%';


--24. tblInsa. 영업부/총무부/개발부 직원 중  사원급(사원/대리) 중에 010을 사용하는 직원들을 가져오시오.
select *
from tblInsa
where buseo in ('영업부', '총무부', '개발부') and jikwi in ('사원', '대리') and tel like '010%';


--25. tblInsa. 서울/인천/경기에 살고 입사일이 2010 ~ 2013년 사이인 직원들을 가져오시오.
select *
from tblInsa
where city in ('서울', '인천', '경기') and ibsadate between '2010-01-01' and '2013-12-31';


--26. employees. 아직 부서가 배정 안된 직원들을 가져오시오.
select *
from employees
where department_id is null;


--27. employees. 해당 테이블에는 직업의 종류가 어떤 것들이 있습니까?
select distinct job_id
from employees;


--28. employees. 고용일이 2002~2004년 사이인 직원들은 어느 부서에 근무합니까?
select distinct department_id
from employees
where hire_date between '2002-01-01' and '2004-12-31';


--29. employees. 급여가 5000불 이상인 직원들은 담당 매니저가 누구입니까?
select distinct manager_id
from employees
where salary >= 5000;


--30. tblInsa. 남자이며 80년대생은 직급이 어떤 것들이 있습니까?
select distinct jikwi
from tblInsa
where ssn like '8%-1%';


--31. tblInsa. 수당 20만원 넘는 직원들은 어디 삽니까?
select distinct city
from tblInsa
where sudang >= 200000;


--32. tblInsa. 연락처가 아직 없는 직원은 어느 부서입니까?
select buseo
from tblInsa
where tel is null;


--33. tblCountry. 아시아와 유럽에 속한 국가는 총 몇개입니까?
select count(*)
from tblCountry
where continent in ('AS', 'EU');


--34. tblCountry. 인구가 5000 ~ 20000 사이인 국가 총 몇개입니까? 
select count(*)
from tblCountry
where population between 5000 and 20000;


--35. employees. 직업이 'IT_PROG'인 직원 중에서 급여가 5000불 넘는 직원 몇명입니까?
select count(*)
from employees
where job_id = 'IT_PROG' and salary >= 5000;


--36. tblInsa. 010이 아닌 번호를 사용하는 직원은 몇명입니까?(연락처가 없는 사람 제외)
select count(*)
from tblInsa
where tel not like '010%';


--37. tblInsa. 서울 사람 빼고 나머지는 모두 몇명입니까?
select count(*)
from tblInsa
where city not like '서울';


--38. tblInsa. 남자 직원은 모두 몇명입니까?
select count(*)
from tblInsa
where substr(ssn, 8, 1) = 1;


--39. tblCountry. 유럽과 아프리카에 속한 나라의 모든 인구의 합은?
select sum(population)
from tblCountry
where continent in ('EU', 'AF');


--40. employees. 매니저(108)이 관리하고 있는 직원들의 급여 총 합은?
select sum(salary)
from employees
where manager_id = 108;


--41. employees. 직업이 ST_CLERK, SH_CLERK인 직원들을 급여 총 합은?
select sum(salary)
from employees
where job_id in ('ST_CLERK', 'SH_CLERK');


--42. tblInsa. 서울에 있는 직원들의 급여 합은(급여 + 수당)?
select sum(basicpay + sudang)
from tblInsa
where city = '서울';


--43. tblInsa. 장급(부장+과장)들의 총 급여 합은?
select sum(basicpay + sudang)
from tblInsa
where jikwi in ('부장', '과장');


--44. tblCountry. 아시아에 속한 국가의 평균 인구수는?
select avg(population)
from tblCountry
where continent = 'AS';


--45. employees. 이름(first_name)에 'NI'이 포함된 직원들의 평균 급여는?(대소문자 구분없이)
select avg(salary)
from employees
where upper(first_name) like '%NI%';


--46. tblInsa. 간부급(과장,부장)들의 평균 급여는?
select avg(basicpay + sudang)
from tblInsa
where jikwi in ('부장', '과장');


--47. tblInsa. 사원급(사원,대리)들의 평균 급여는?
select avg(basicpay + sudang)
from tblInsa
where jikwi in ('사원', '대리');


--48. tblCountry. 면적이 가장 넓은 나라의 면적은?
select max(area)
from tblCountry;


--49. tblInsa. 급여(급여+수당)가 가장 적게 받는 직원의 금액은?
select min(basicpay + sudang)
from tblInsa;


--50. tblInsa. 직원명과 태어난 년도을 가져오되 태어난 년도를 오름차순으로 가져오시오.
select name, '19' || substr(ssn, 1, 2) as "태어난 연도"
from tblInsa
order by ssn;


--51. tblInsa. 서울에 사는 여직원 중 80년대생 몇명인지?
select count(*)
from tblInsa
where city = '서울' and ssn like '8%-2%';


--52. tblInsa. 간부급(과장/부장)들은 어떤 성(김,이,박..)들이 있는지?
select distinct substr(name, 1, 1)
from tblInsa
where jikwi in ('과장', '부장');


--53. tblInsa. 직원들을 태어난 월순으로 정렬해서 가져오시오.(오름차순 → 월, 이름)
select *
from tblInsa
order by substr(ssn, 3, 2), name;


--54. tblInsa. 모든 직원을 남자 → 여자 순으로 정렬해서 가져오시오. (같은 성별끼리는 이름순으로 정렬)
select *
from tblInsa
order by substr(ssn, 8, 1), name;


--55. employees. 이름(first_name + last_name)이 가장 긴 순서대로 가져오시오.
select *
from employees
order by length(first_name || ' ' || last_name) desc;


--56. employees. 이름(first_name + last_name)이 가장 긴사람은 몇글자?
select max(length(first_name || ' ' || last_name))
from employees;


--57. employees. last_name이 5자 이상인 사람들은 first_name이 몇글자?
select length(first_name) as firstLength
from employees
where length (last_name) >= 5;


--58. tbldiary. 다이어리를 작성한 날짜가 총 며칠분이며, 날씨가 맑음, 흐림, 비가 온 날이 각각 며칠이었는지?
select
    count(*) as "총작성일수",
    count(case when weather = '맑음' then 1 end) as "맑음",
    count(case when weather = '흐림' then 1 end) as "흐림",
    count(case when weather = '비' then 1 end) as "비"
from tbldiary;


--59. tbldiary. 공부와 관련된 작성 게시물이 총 몇개인가?('오라클', '자바', '코딩'이 들어간 게시물 개수)
select 
    count(
        case when subject like '%오라클%' 
                    or subject like '%자바%' 
                    or subject like'%코딩%' then 1 
        end)  as "공부"
from tbldiary;


--60. fine_dust_standard + fine_dust. 강남구의 미세먼지(PM10) 상태가 좋음, 보통, 나쁨, 매우나쁨이 각각 며칠이었는지? 0 30, 31 50, 51, 70, 71 999
select
    count(case when pm10 between 0 and 30 then 1 end) as "좋음",
    count(case when pm10 between 31 and 50 then 1 end) as "보통",
    count(case when pm10 between 51 and 70 then 1 end) as "나쁨",
    count(case when pm10 between 71 and 999 then 1 end) as "매우나쁨"
from fine_dust
where mea_station = '강남구';


--61. lotto_detail. 1인당 당첨금이 가장 많은 순으로 가져오시오. (1등 당첨자 수, 1인 당첨금, 총 당첨금)
select * 
from lotto_detail 
order by win_money desc;


--62. tblsubway. 2017년 4월 2일에 승차한 승객수가 가장 많은 순으로 가져오시오.
select *
from tblsubway
where boardingdate = '2017-04-02'
order by passengernumber desc;


--63. tblzoo. 다리가 있고(leg) 날지 못하는(fly) 동물들의 종(family)을 가져오시오.
select distinct family
from tblzoo
where leg > 0 and fly = 'n';


--65. tbltodo. 오전(0~11시)과 오후(12~23시)에 끝마친(completedate) 할일들의 개수를 각각 가져오시오.
select
    count(case when to_char(completedate, 'am') = '오전' then 1 end) as "오전",
    count(case when to_char(completedate, 'pm') = '오후' then 1 end) as "오후"
from tbltodo;


--66. tbladdressbook. 구글 메일, 다음 메일, 네이버 메일을 사용하는 사람이 각각 몇명인지?
select 
    count(case when email like '%@gmail.com' then 1 end ) as "구글",
    count(case when email like '%@daum.net' then 1 end ) as "다음",
    count(case when email like '%@naver.com' then 1 end ) as "네이버"
from tbladdressbook;


--67. tbladdressbook. 서울 이외의 지역에서 사는 사람들이 총 몇명인지?
select count(*)
from tbladdressbook
where substr(address, 1, 2) not like '서울';

