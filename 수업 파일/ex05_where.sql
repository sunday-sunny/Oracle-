/*

ex05_where.sql


*/


select * from tblCountry;

select name, area
from  tblCountry
where continent = 'AS';


select name, buseo, basicpay 
from tblInsa 
where buseo = '영업부';

select buseo, count(*)
from tblInsa
group by buseo;

select *
from tblInsa
where buseo = '영업부' and city = '서울' and (jikwi ='사원' or jikwi ='대리');

select *
from tblInsa
where basicpay >= 1500000 and basicpay <= 2000000;

-- tblComedian;
-- 1. 몸무게가 60kg 이상이고, 키가 170미만인 사람만 가져오시오.
-- 2. 여자만 가져오시오.

select last || first as name, gender, height, weight, nick
from tblComedian
where weight >= 60 and height < 170;

select *
from tblComedian
where gender = 'f';


-- tblInsa;
-- 3. 부서가 '개발부'이고 급여를 150만원 이상 받는 직원을 가져오시오.
-- 4. 급여 + 수당한 금액이 200만 이상 받는 직원을 가져오시오.

select *
from tblInsa
where buseo = '개발부' and basicpay >= 1500000;

select name, basicpay, sudang, basicpay + sudang
from tblInsa
where (basicpay + sudang) >= 2000000;


-- 조건절(where)에서 사용되는 여러 구문들.. (연산자, 함수, 절..)

/*

between ~ and
- where절에서 사용
- 범위 조건 사용
- 컬럼명 between 최소값 and 최댓값
- 연산자 사용보다 가독성 향상(성능 느림)
- 최소값, 최대값 > inclusive
*/

-- tblComedian;
-- 1. 몸무게가 60kg 이상이고, 키가 170미만인 사람만 가져오시오.

select last || first as name, gender, height, weight, nick
from tblComedian
where weight between 64 and 66;

-- 비교 연산에 사용되는 자료형
-- 1. 숫자형
select * from tblInsa where basicpay >= 1500000;
select * from tblInsa where basicpay between 1500000 and 2000000;

-- 2. 문자형
select * from tblInsa where name >= '박' and name <= '유';
select * from tblInsa where name between '박' and '유';

-- 3. 날짜형
select * from tblInsa where ibsadate > '2010-01-01' and ibsadate <= '2010-12-31';
select * from tblInsa where ibsadate between '2010-01-01' and '2010-12-31';


/*
in
- where절에서 사용 > 조건으로 사용
- 열거형 조건 > 제시된 값 중 하나라도 만족
- 컬럼명 in(값1, 값2, 값3 ..)
*/

-- tblInsa 홍보부, 개발부 
select * from tblInsa where buseo in ('홍보부', '개발부');

-- tblInsa (부장, 과장) + (서울, 인천)
select * 
from tblInsa 
where jikwi in ('부장', '과장') 
    and city in ('서울', '인천')
    and basicpay between 2500000 and 2600000;

/*
like 
- where절에서 사용 > 조건으로 사용 
- 패턴 비교 > 정규 표현식의 동작과 유사
- 컬럼명 like '패턴 문자열'
- 문자형에만 사용 가능(숫자, 날짜 적용 불가능)

패턴 문자열 구성 요소
1. _ : 임의의 문자 1개
2. % : 임의의 문자 n개(0~무한대)
*/

select name 
from tblInsa
where name like '이%';

select name 
from tblInsa
where tel like '010-____-____';

-- tblInsa. 남자 직원만
-- tblInsa. 여자 직원만

select *
from tblInsa
where ssn like '%-1%';

select *
from tblInsa
where ssn like '%-2%';


/*
RDBMS에서의 null
- 자바의 null과 유사
- 컬럼값이 비어있는 상태
- null 상수 제공
- 대다수의 언어에서 null은 연산의 대상이 될 수 없다.

null 조건
- where절 사용
- 컬럼명 is null
*/

select * from tblCountry
where population is null;

select * from tblCountry
where population is not null;

-- 아직 실행하지 않은 할 일
select * 
from tblTodo
where completedate is null;

-- 완료한 일
select * 
from tblTodo
where completedate is not null;




