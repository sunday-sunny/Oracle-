--ex01.sql


/* 주석 */
-- 1. /* 다중라인 주석
-- 2. -- 단일라인 주석


/* 명령어 작성 */
-- SQL 언어 > 비 절차지향 언어 > 명령어 간에 순서가 없이 서로 독립적인 형태를 가진다.
-- 1. SQL 워크시트
-- 2. Script
-- 3. SQL File


/* SQL 쿼리 실행 */
-- 블럭 잡은 문장 > Ctrl + Enter (***)
-- 블럭(X)        > F9, Ctrl +Enter


/* Oracle 서버 기본 인코딩 */
-- 변경 가능
-- ~8i : EUC-KR
-- 9i ~ 현재 : UTF-8


/* Oracle 서비스 실행 여부 확인 
- window + r (실행창) > services.msc 검색 > 서비스창 > OracleXXX 5개 있으면 정상
    1. OracleJobSchedulerXE
    2. OracleMTSRecoveryService
    3. OracleServiceXE          > (***) 오라클 서버  
    4. OracleXEClrAgent
    5. OracleXETNSListener      > (***) 오라클 서버가 클라이언트의 요청을 받을 수 있게 하는 서비스 
                                > 서버가 살아있어도 리스너가 죽어버리면 클라이언트가 접속을 못함
*/


/* SQL 표기법 
- SQL의 *키워드(명령어)*   > 대소문자 구분 (X)
- *데이터*                 > 대소문자 구분 (O)

- 관습화된 패턴
    1. 키워드(명령어)   > 대문자
    2. 사용자 식별자    > 소문자

- 표기 변환 단축키 
    - *** 블럭 > Alt + ' ***
    - 개발(개인 작업) > 다 소문자로 작성..  
    - 공유 + 팀작업   > 코드 컨벤션 > 다 소문자로 작성 > 툴 기능 

- 사용자 식별자 주의점!!
    1. 명명법 > 캐멀표기법 베이스 + 헝가리언 표기법(tbl -> 접두에 테이블을 나타내는 걸 붙임)
        ex) select * from tblStudent;
    2. 식별자 30바이트 이하만 가능   
*/


/* 오라클 */
-- 데이터베이스, DB
-- 관계형 데이터베이스, Relational Database, RDB   
-- 데이터베이스 관리 시스템, DBMS
-- 관계형 데이터베이스 관리 시스템, RDBMS


/* 관계형 데이터베이스 */
-- 데이터를 표 형식으로 저장/관리한다.
-- SQL를 사용하여 조작한다.


/* SQL
- 사용자가 관계형 데이터베이스와 대화를 할 때 사용하는 언어
- 자바에 비해 자연어에 가깝다.
- ANSI

- 특징
    1. DBMS 제작사와 독립적이다.
     - SQL은 모든 DBMS 제작자와 독립적으로 개발된다. 
        > 버전업된 SQL을 모든 제작자에게 공개한다.
        > DBMS 제작자는 변경된 SQL 문법을 자신의 DBMS에 반영한다.
    
    2. 표준 SQL, ANSI-SQL
        - 어떤 DBMS를 사용하던지 공통이다.
        - 계속 발전 중..
        ex) SQL-86, SQL89, SQL92, SOL99.. SQL2011..
        
    3. 대화식 언어이다.
        - 비절자지향
        - 질문 > 답변 > 질문 > 답변
    
- 종류
    1. 표준SQL, ANSI-SQL
        - 공통 
        
    2. 각 DBMS 제작사별 SQL > 확장 SQL
        - 각각 개별 > DBMS 바뀔 때마다 공부를 따로
        - PL/SQL(오라클)
    
    오라클(DB, 100%) = ANSI-SQL(70%) + PL/SQL(30%) + 설계(기타)
*/



/* ANSI-SQL 종류
1. DDL (Data Definition Language)
    - 데이터 정의어
    - 테이블, 뷰, 사용자, 인덱스 등의 객체를 생성/수정/삭제 명령어
    - 구조를 생성/관리할 때 사용한다.
        a. Create : 생성
        b. Drop : 삭제
        c. Alter : 수정
        - 데이터베이스 관리자
        - 데이터베이스 담당자
        - 프로그래머(일부)

2. DML (Data Manipulation Language)
    - 데이터 조작어
    - 데이터베이스의 데이터를 추가/수정/삭제/조회 명령어
    - 사용 빈도 > 가장 높음 > CRUD
    a. Select : 조회(읽기), Read
    b. Insert : 추가, Create
    c. Update : 수정, Update
    d. Delete : 삭제, Delete
    - 데이터베이스 관리자
    - 데이터베이스 담당자
    - 프로그래머(***)
    
3. DCL (Data Control Language)
    - 데이터 제어어
    - 계정 관리, 보안 통제, 트랜잭션 처리 등 ... 
    a. Commit
    b. Rollback
    c. Grant
    d. Revoke
    - 데이터베이스 관리자
    - 데이터베이스 담당자
    - 프로그래머(일부)

4. DQL (Data Query Langague)
    - 데이터 질의어
    - DML 중 Select만 이렇게 부른다.

5. TCL (Transaction Control Language)
    - DCL 중 Commit, Rollback만 이렇게 부른다.
*/




/* chapter2.

관계형 데이터베이스 모델 
    - 테이블(Table ) == 릴레이션(Relation)

테이블
    - 스키마(Sheme) > 클래스(Class)
    - 인스턴스(Instance) > 인스턴스, 객체

    ex) 제품 테이블(쇼핑몰)
        - 제품(번호, 제품명, 가격)
        - 1, 마우스, 20000


속성(셀)은 단일값(원자값, 스칼라(Scalar))을 가진다.
*/


