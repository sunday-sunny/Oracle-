-- ex25_transaction.sql


/* 트랜잭션, Transaction
- 데이터를 조작하는 업무의 물리적(시간적) 단위
- 작업 영역(시간) = 작업 기간
- 오라클에서 발생하는 1개 이상의 명령어들을 하나의 논리 집합으로 묶어 놓은 단위
- 트랜잭션 포함되는 명령어 > DML > INSERT, UPDATE, DELETE > DB(데이터) 변경 조작


수업 목적 > 오라클에서 트랜잭션을 제어하는 방법 > 트랜잭션 명령어
- DCL > TCL 
- 하나의 트랜잭션으로 묶여있는 DML을 감시하다가 전체가 성공하면 DB에 반영 처리를 하고,
    일부 실패하면 이전에 성공한 DML을 일괄 취소 처리..

1. commit
2. rollback
3. savepoint

*/

-- 트랜잭션은 이미 시작되었음..
create table tblTrans
as
select name, buseo, jikwi from tblInsa where city = '서울';

delete from tblTrans where name = '한석봉';
commit; -- 여태 트랜잭션에 누적된 임시 결과를 실제 DB에 적용해라..



-- 새로운 트랜잭션 시작
delete from tblTrans where name = '김인수';
rollback; -- 현재 트랜잭션의 모든 작업을 없었던 일로 처리(폐기)


select * from tblTrans;

-- 새로운 트랜잭션 시작


-- 시간대별로 묶기
-- 업무별로 묶기


/*
트랜잭션이 언제 시작하고? 언제 끝나는지?

<새로운 트랜잭션이 시작하는 경우>
1. 클라이언트 접속 직후
2. commit 실행 직후
3. rollback 실행 직후


<현재 트랜잭션이 종료되는 경우>
1. commit 실행 직후 > 현재 트랜잭션을 DB 반영함
2. rollback 실행 직후 > 현재 트랜잭션을 DB 반영 안함
3. 클라이언트 접속 종료
    a. 정상적인 접속 종료
        - 현재 트랜잭션이 아직 반영 안된 명령어가 남아 있으면 사용자에게 질문
    
    b. 비정상적인 접속 종료
        - 무조건 rollback 처리
 
4. DDL 실행
    - CREATE, ALTER, DROP
    - 자동으로 commit이 된다.(***)

*/


commit;


select * from tblTrans;
insert into tblTrans values ('가가가', '영업부', '부장');
insert into tblTrans values ('나나나', '영업부', '과장');

savepoint a;

delete from tblTrans where name = '나나나';

savepoint b;

delete from tblTrans where name = '가가가';

rollback;

rollback to b;



-- 
commit;


select * from tblTrans;

-- ★ 같은 시간에 같은 테이블을 건드리는 팀원 유무 꼭 확인 ★






