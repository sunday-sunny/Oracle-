-- ex10_string_function.sql

/*
문자열 함수
upper(), lower(), initcp()
*/
select initcap('abc') from dual; -- 첫글자를 대문자로.

select first_name
from employees
where upper(first_name) like '%DE%';


/*
substr()
- 문자열 추출 함수
- varchar2 substr(컬럼명, 시작위치, 가져올 문자개수)
- varchar2 substr(컬럼명, 시작위치)
- ** SQL은 One-based Index 사용. 첨자를 1부터 시작한다.

*/

select
    title,
    substr(title, 3, 4)
from tbltodo;

select
    first_name || last_name,
    substr(first_name || last_name, 3, 4)
from employees;

-- 남자 직원
select *
from tblInsa
where substr(ssn, 8, 1) in ('1','3');

-- 직원명, 태어난 년도
select 
    name, 
    '19' || substr(ssn, 1,2) as birthyear
from tblinsa;

-- 서울에 사는 여직원 중 80년대생 몇 명?
select
    count(*)
from tblinsa
where city = '서울' and substr(ssn, 8, 1) = '2' and substr(ssn,1,1) = '8';

-- 직원들의 성이 뭐가 있나
select 
    distinct substr(name , 1, 1)
from tblinsa;

-- 김 이 박 최 정 > 몇 명?
select
    count (case when substr(name, 1, 1) = '김' then name end) as "김씨",
    count (case when substr(name, 1, 1) = '이' then name end) as "이씨",
    count (case when substr(name, 1, 1) = '박' then name end) as "박씨",
    count (case when substr(name, 1, 1) = '최' then name end) as "최씨",
    count (case when substr(name, 1, 1) = '정' then name end) as "정씨",
    count (case when substr(name, 1, 1) not in ('김', '이', '박', '최', '정') then name end) as "기타"
from tblinsa;


/*
length()
- 문자열 길이(문자수 반환)
- number length(컬럼명)

- 컬럼 리스트에서 사용
- 조건절에서 사용
- 정렬에서 사용

*/

select name, length(name) as 글자수
from tblCountry;

select name
from tblCountry
where length(name) between 4 and 6;

select name
from tblCountry
where mod(length(name),2) = 1;

select name
from tblCountry
order by length(name), name;

select *
from tblInsa
order by substr(ssn, 8, 1), ssn;

select
    title,
    case 
        when length(title) >= 8 then substr(title, 1, 8) || '...' 
        else title    
    end as 줄임말
from tblTodo;

-- 2021-11-12
1. 
select 
    first_name || ' ' || last_name as fullname,
    length(first_name || ' ' || last_name)
from employees
order by length(first_name || ' ' || last_name) desc;

2. 
select 
    max(length(first_name || ' ' || last_name)) as maxLength,
    min(length(first_name || ' ' || last_name)) as minLength,
    avg(length(first_name || ' ' || last_name)) as avgLength
from employees;


3. 
select first_name
from employees
where length(last_name) >= 4
order by length(first_name);



/*
instr()
- 검색 함수 (= indexOf())
- 검색어의 위치를 반환 
- number instr(컬럼명, 검색어)
- number instr(컬럼명, 검색어, 시작위치)

*/


select
    '안녕하세요. 홍길동님',
    instr('안녕하세요. 홍길동님', '홍길동') as c2,
    instr('안녕하세요. 홍길동님', '아무개') as c3, -- 못 찾으면 0을 반환
    instr('안녕하세요. 홍길동님, 홍길동님', '홍길동') as c4-- 첫번째 찾은 것을 반환
from dual;


select * 
from tblinsa
where substr(tel, 1, 3) = '010;


/*
lpad(), rpad()
varchar2 lpad(컬럼명, 개수, 문자)

*/

select 
    'a', lpad('a', 5, 'b'), rpad('a', 5, 'b'),
    '1', lpad('1', 3, '0')
from dual;


/*
trim(), ltrim(), rtrim()
- varchar2 trim(컬럼명)
*/

/*
replace()
- 문자열 치환
- varchar2 replace(컬럼명, 찾을 문자열, 바꿀 문자열)
*/

select 
    replace('홍길동', '홍', ' 김'),
    replace('홍길동', '이', ' 김') -- 찾는 문자열이 없으면 그대로 출력
from dual;


-- 직원명, 주민번호, 성별 (남자|여자)
select 
    name, ssn, 
    case 
        when substr(ssn, 8, 1) = '1' then '남자'
        else '여자'
    end
from tblinsa;

-- 쓸 수는 있지만 가독성이 너무 떨어진다.
select 
    name, ssn, 
    replace(replace(substr(ssn,8,1),'1', '남자'), '2', '여자')
from tblinsa;

select
    name,
    replace(replace(replace(replace(replace(continent, 'AS', '아시아'), 'SA', '아메리카'), 'EU', '유럽'), 'AF', '아프리카'), 'AU', '호주')
from tblCountry;

select 
    name,
    case
        when continent = 'AS' then '아시아'
        when continent = 'SA' then '아메리카'
        when continent = 'EU' then '유럽'
        when continent = 'AF' then '아프리카'
        when continent = 'AU' then '호주'
    end as national
from tblCountry;


/*
decode()
- 문자열 치환
- replace(), case 유사
- varchar2 decode(컬럼명, 찾을 문자열, 바꿀 문자열[, 찾을 문자열, 바꿀 문자열] * n ..)
- replace -> 못찾으면 원본 반환
- decode -> 못찾으면 null 반환 > case문과 유사

*/

select decode(substr(ssn, 8, 1), '1', '남자', '2', '여자')
from tblInsa;

select
    continent,
    decode(continent, 'AS', '아시아', 'SA', '아메리카', 'EU', '유럽', 'AF', '아프리카', 'AU', '호주') as national
from tblCountry;

select 
    count(decode(gender, 'm', 1)) as 남자,
    count(decode(gender, 'f', 1)) as 여자
from tblComedian;




-- 2021-11-12


-- tblInsa. 부장 몇 명? 과장 몇 명? 대리 몇 명?
select
    count(decode(jikwi, '부장', 1)) as 부장,
    count(decode(jikwi, '과장', 1)) as 과장,
    count(decode(jikwi, '대리', 1)) as 대리,
    count(decode(jikwi, '사원', 1)) as 사원
from tblinsa;


-- tblInsa. 간부(부장, 과장) 몇 명? 사원(대리, 사원) 몇 명?
select
    count(decode(jikwi, '부장', 1, '과장', 1)) as 간부급,
    count(decode(jikwi, '대리', 1, '사원', 1)) as 사원급
from tblinsa;

-- tblInsa. 기획부, 영업부, 총무부, 개발부의 각각 평균 급여?
select
    avg(decode(buseo, '기획부', basicpay)) as 기획부,
    avg(decode(buseo, '영업부', basicpay)) as 영업부,
    avg(decode(buseo, '총무부', basicpay)) as 총무부,
    avg(decode(buseo, '개발부', basicpay)) as 개발부
from tblinsa;

-- tblInsa. 남자 직원 가장 나이가 많은 사람이 몇 년도 태생? 여자 직원 중 가장 어린 사람이 몇 년도 태생인지
select 
    '19' || min(decode(substr(ssn, 8, 1), '1', substr(ssn, 1, 2))) as 남자최연장자,
    '19' || max(decode(substr(ssn, 8, 1), '2', substr(ssn, 1, 2))) as 여자최연소자
from tblInsa;


-- tblAddressBook. 학생 몇 명? 건물주 몇 명?
select 
    count(decode(job, '학생', 1)) as 학생수,
    count(decode(job, '건물주', 1)) as 건물주수
from tbladdressbook;


-- tblAddressBook. 강동구 몇 명? 마포구 몇 명?
select
    count(decode(substr(address, 7, 3), '강동구', 1)) as 강동구,
    count(decode(substr(address, 7, 3), '마포구', 1)) as 마포구
from tbladdressbook
where substr(address, 1, 2) = '서울';



