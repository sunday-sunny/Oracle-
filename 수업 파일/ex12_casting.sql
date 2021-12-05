-- ex12_casting.sql


/* null 관련 함수 */

-- nvl(exp1, exp2)
-- null value 
select name, nvl(population, -1)
from tblCountry;

select name, nvl(tel, '연락처없음') 
from tblInsa;


-- nvl2(exp1, exp2, exp3)
select name, nvl2(tel, tel, '연락처없음') 
from tblInsa;


/* 형변환 함수 
1. to_char()        : 숫자 -> 문자
2. to_char()        : 날짜 -> 문자 (***)
3. to_number()  : 문자 -> 숫자
4. to_date()        : 문자 -> 날짜 (***)

숫자 <-> 문자
날짜 <-> 문자


1. to_char()
- char to_char(컬럼명, 형식문자열)

형식 문자열 구성요소
a. 9    : 숫자 1개를 문자 1개로 바꾸는 역할 (빈자리는 버린다.) 부호자리를 확보 > %5d
b. 0    : 숫자 1개를 문자 1개로 바꾸는 역할 (빈자리를 0으로 채운다.) 부호자리를 확보 > %05d
c. $    : 통화기호 표현 
d. L    : 통화기호 표현(로컬) > 설정에 따른.. 환경설정 > NLS > 통화표시 변경 가능
e. '.'   : 소수점 표시
f. ','    : 자릿수 표시


*/



select 
    weight,                                       -- 우측정렬(숫자) 
    '@' || to_char(weight) || '@',      -- 좌측정렬(문자)
    '@' || to_char(weight, '999') || '@',   -- 부호비트를 날리기 위해서는 substr로 잘라야함..(좋진 않음)
    '@' || to_char(weight, '99') || '@',     -- 자리수가 부족한 거는 아예 ###으로 나옴 (아니면 복구불가)
    '@' || to_char(weight, '000') || '@'
from tblcomedian;


select 
    100, 
    to_char(100, '999'),
    '$' || to_char(100, '999'),
    to_char(100, '$999'), -- $ 붙일 수 있게 지원해줌
    to_char(100, 'L999')
from dual;


select
    123.456,
    to_char(123.456, '999999'),  -- 이러면 무조건 정수로만 나와서 잘림.
    to_char(123.456, '999.999'),
    to_char(123.456, '9999.99') -- 심지어 이러면 반올림도 됨..(ㄷ..)
from dual;


select
    123456789,
    to_char(123456789),
    to_char(123456789, '999,999,999') -- '%,d'
from dual;


/*

2. to_char()
- 날짜 -> 문자
- char to_char(컬럼명, '형식문자열')
- 형변환보단, 날짜의 일부 요소를 원하는 형태로 추출하는 역할(*****)

형식문자열 구성요소
a. yyyy
b. yy
c. month
d. mon
e. mm
f. day
g. dy
h. ddd
i. dd
j. d
k. hh
l. hh24
m. mi
n. ss
o. am(pm)


*/

select sysdate, to_char(sysdate,'yyyy') from dual;  -- 2021. 년(4자리) (***)
select sysdate, to_char(sysdate, 'yy') from dual;   -- 21. 년(2자리)

select sysdate, to_char(sysdate, 'month') from dual;    -- 11월(풀네임)
select sysdate, to_char(sysdate, 'mon') from dual;      -- 11월(약어)
select sysdate, to_char(sysdate, 'mm') from dual;       -- 11(2자리) (***)

select sysdate, to_char(sysdate, 'day') from dual;      -- 월요일(풀네임)
select sysdate, to_char(sysdate, 'dy') from dual;       -- 월(약어)

select sysdate, to_char(sysdate, 'ddd') from dual;      -- 319, 일 (올해의 며칠)
select sysdate, to_char(sysdate, 'dd') from dual;       --15, 일 (이번월의 며칠) (***)
select sysdate, to_char(sysdate, 'd') from dual;        -- 2, 일 (이번 주의 며칠 == 요일)

select sysdate, to_char(sysdate, 'hh') from dual;       -- 10, 시(12H)
select sysdate, to_char(sysdate, 'hh24') from dual;     -- 10, 시(24H) (***)

select sysdate, to_char(sysdate, 'mi') from dual;       -- 40, 분 (***)
select sysdate, to_char(sysdate, 'ss') from dual;       -- 37, 초 (***)
select sysdate, to_char(sysdate, 'am') from dual;       -- 오전
select sysdate, to_char(sysdate, 'pm') from dual;       -- 오후



select 
    sysdate, -- *** RR/MM/DD *** 이 표현은 클라이언트툴에 따라 다르다.
    to_char(sysdate, 'yyyy-mm-dd') as today,  -- 이 표현은 모든 클라이언트에 동일하다.
    to_char(sysdate, 'hh24:mi:ss') as time,
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') as now,
    to_char(sysdate, 'day am hh:mi:ss') as "가끔씩"
from dual;



-- 여러 절에서 to_char() 사용
-- 1. 컬럼 리스트에서 사용
select to_char(sysdate, 'yyyy-mm-dd') from dual;

 select
    name, to_char(ibsadate, 'yyyy-mm-dd day'), basicpay,
    case
        when to_char(ibsadate, 'd') in ('1', '7') then basicpay / 2 
        else basicpay * 2
    end as extraPay
 from tblInsa;
 
 
 select
    count(case when to_char(ibsadate, 'd') in ('1', '7') then 1 end) as 주말입사,
    count(case when to_char(ibsadate, 'd') not in ('1', '7') then 1 end) as 평일입사
 from tblInsa;


-- 2. 조건절에서 사용
select name, ibsadate from tblInsa;


-- 2010년에 입사한 직원들
select name, ibsadate 
from tblinsa
where ibsadate >= '2010-01-01' and ibsadate <= '2010-12-31';


-- 시분초가 명시되어 있지 않은 날짜상수('2010-01-01')는 date로 암시적 형변환이 될 때 > 자정(00:00:00)으로 들어감.
select 
    name, 
    ibsadate,
    to_char(ibsadate, 'yyyy-mm-dd hh24:mi:ss') as 입사일
from tblinsa
where ibsadate between '2010-01-01' and '2010-12-31';


-- 2010-01-01 00:00:00 ~ 2010-12-31 00:00:00
-- 2010-01-01 00:00:00 ~ 2010-12-31 23:59:59
-- 홍길동 > 2010-12-31 14:30:00

-- SQL상에서 날짜 상수를 표현할 때 > 년월일만 표현 가능, 시분초는 표현 불가능
--        > 년월일만 표현한 상수의 시분초는 무조건 자정(00:00:00)으로 할당된다.
select 
    name, ibsadate,
    to_char(ibsadate, 'yyyy-mm-dd hh24:mi:ss') as 입사일
from tblinsa
where ibsadate between '2010-01-01 00:00:00' and '2010-12-31 23:59:59';


select 
    name, ibsadate,
    to_char(ibsadate, 'yyyy-mm-dd hh24:mi:ss') as 입사일
from tblinsa
where to_char(ibsadate, 'yyyy') = '2010'; -- 완벽한 조건


select 
    name, ibsadate,
    to_char(ibsadate, 'yyyy-mm-dd day') as 입사일
from tblinsa
where to_char(ibsadate, 'd') = '2'; --월요일 입사자만 가져옴


-- 3. 정렬
select 
    name, ibsadate,
    to_char(ibsadate, 'yyyy-mm-dd day') as 입사일
from tblinsa
order by to_char(ibsadate, 'd'); -- 입사 요일별 정렬



-- 3. to_number()
-- number to_number(컬럼명)
select 
    '123' * 2 as "별칭1입니다!", -- 문자열 * 2 > 작동 > 암시적 형변환 발생
    to_number('123') as "별칭2입니다!" -- "100" > 100 > 산술 연산하려고
from dual;



-- 4. to_date()
-- 문자 -> 날짜
-- date to_date(컬럼명, 형식문자열)

-- SQL은 날짜 상수를 문자열 상수를 통해서 만든다. > 문맥에 따라..
-- ex) '2021-11-15'

select * from tblInsa
where ibsadate > '2010-01-01'; -- 날짜와 비교중.. > 암시적으로 형변환

select name, '2010-01-01', sysdate from tblInsa; -- 이 때의 '2010-01-01'은 그대로 문자열.. 형변환 발생X

select * from tblInsa
where ibsadate > to_date('2010-01-01');

select name, to_date('2010-01-01'), sysdate 
from tblInsa; -- date 형식으로 출력

select name, to_date('2020-11-15') - ibsadate from tblinsa;

select * from tblinsa
where ibsadate > to_date('2010-01-01 12:00:00', 'yyyy-mm-dd hh24:mi:ss');



