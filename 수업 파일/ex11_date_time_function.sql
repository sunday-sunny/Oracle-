-- ex11_date_time_function.sql

/*
날짜 시간 함수
- 현재 시스템의 시간을 반환
- date sysdate
- 자바의 Calendar.getInstance()

- 툴마다 날짜 포멧이 다름. 

*/

select sysdate from dual;

/*
날짜 연산
- +, -
1. 시각 - 시각 = 일
2. 시각 +/- 시간 = 시각(날짜)
*/

-- 1. 시각 - 시각
-- 현재시각 - 입사일
select
    name,
    ibsadate,
    round((sysdate - ibsadate)) as "근무일", 
    round((sysdate - ibsadate) / 365) as "근무년수", -- 사용금지
    round((sysdate - ibsadate) * 24) as "근무시간",
    round((sysdate - ibsadate) * 24 * 60) as "근무분",
    round((sysdate - ibsadate) * 24 * 60 * 60) as "근무초"
from tblInsa;


select
    title,
    adddate,
    completedate,
    round(completedate - adddate, 1) as 걸린일수
from tblTodo
where (completedate - adddate) < 3
order by  (completedate - adddate);



-- 2. 시각 +/- 시간
select sysdate, sysdate + 100 -- 100일 뒤
from dual;

select sysdate, sysdate - 100 -- 100일 전
from dual;

-- 2시간 뒤
select sysdate + (2/24) from dual;

-- 3시간 전
select sysdate - (3/24) from dual;

-- 30분 뒤
select sysdate + (0.5/24) from dual;
select sysdate + ( 30 / 24 / 60) from dual;


/*
last_day()
- date last_day(date)
- 해당 컬럼값이 포함된 달의 마지막 날짜

*/

select sysdate, last_day(sysdate) from dual;

/*
months_between()
- number months_between(date, date)
- 시각 - 시각 = 월 반환

add_months()
- date add_months(date, number)
- 시각 + 시간(월) = 시각

*/

select 
    name,
    round(sysdate - ibsadate) as "근무시간(일)",
    round(months_between(sysdate, ibsadate)) || '월' as "근무시간(월)",
    round(months_between(sysdate, ibsadate) / 12 ) || '년'  as "근무시간(년)"
from tblInsa;


select
    sysdate,
    sysdate + 100,
    sysdate - 100,
    add_months(sysdate, 1), -- 한 달 뒤
    add_months(sysdate, -1), -- 할 달 전
    add_months(sysdate, 1* 12), -- 1년 뒤
    add_months(sysdate, -3 * 12 ) -- 3년 전
from dual;

-- 시각 - 시각
-- 1. 일, 시, 분, 초 > '-' 연산
-- 2. 월, 년 > months_between()

-- 시각 +- 시간
-- 1. 일, 시, 분, 초 > '+,-' 연산
-- 2. 월, 년 > add_months()






