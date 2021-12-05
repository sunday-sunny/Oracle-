-- ex04_operator.sql


/*
연산자, Operator

1. 산술 연산자
- +, -, *, /
- %(없음) -> 함수로 제공(mod())

2. 문자열 연산자
- +(X) -> || (O)

3. 비교 연산자
- >, >=, <, <=
- =, <> 
- 논리값 반환 > 비교 연산의 결과는 논리값 > ANSI-SQL에는 boolean이 없다.
> 결과를 눈에 보이게 표현 불가능 > 결과셋 포함 불가능하다.(테이블 저장)
- 컬럼 리스트에서 사용 불가
- 조건에서 사용

4. 논리 연산자
- and, or, not
- 컬럼 리스트에서 사용 불가
- 조건에서 사용 


5. 대입 연산자
- =
- 컬럼 = 값
- 복합 대입 연산자 없음(+= 등..)
- insert, update문에서만 주로 사용


6. 3항 연산자
- 없음
- 제어문 없음


7. 증감 연산자
- 없음
- 

8. 연산자

- in, between, like, is 등.. (= 구문(절))

-- 이부분 놓쳤으니 자료 받아서 적어놓기 ***

*/


select * from book where price > 7000;

-- 모든 도서 정가 10% 할인
-- *** 컬러명의 별칭(Alias) 만들기
-- 컬럼명 as 별명
select bookname, price, price * 0.9 as 할인가 from book;

-- 알려주긴 하지만 쓰지 말 것!! > "" 붙여서 이스케이프 > 의미없게 만든 식별자
select bookname as "책 제목" from book;
select bookname as "10+20+30" from book;
select bookname as "select " from book;

-- 별칭 : 영어 + 숫자 + _사용




