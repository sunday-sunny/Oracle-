-- ex09_numerical_function.sql

/*
숫자 함수( = 수학 함수)
- 자바의 Math 클래스

round()
- 반올림 함수
- number round(컬럼명) : 정수 반환
- number round(컬럼명, 소수 이하 자릿수) : 실수 반환

*/

select round(height / weight, 1)
from tblcomedian;

select round(avg(basicpay)) from tblInsa;


/*
floor(), trunc()
- 절삭 함수
- 무조건 내림 함수
- number floor(컬럼명)
- number trunc(컬러명 [, 소수이하자릿수])

ceil()
- 무조건 올림 함수
- number ceil(컬럼명)

mod()
- 나머지 함수
- number mod(피제수, 제수)

*/
select mod(10,3) from dual;

select 
    floor(100/60) as 시,
    mod(100,60) as 분
from dual;

select
    abs(10), abs(-10),
    power(2,2), power(2,3), power(2,4)
from dual;

