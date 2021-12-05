-- ex28_plsql.sql

/*  PL/SQL
- Oracle's Procedural langauge extension to SQL
- 기존의 ANSI-SQL에 절차 지향 언어의 기능을 추가한 SQL

ANSI-SQL
- 비절차 지향 언어. 순서가 없고 연속적이지 않다. 문장 단위 구조
- ANSI-SQL + 절차적 기능 추가 -> PL/SQL


프로시저, Procedure
- 메소드, 함수 등.. 
- 순서가 있는 명령어의 집합
- PL/SQL 명령어는 반드시 프로시저 내에서만 작성, 동작이 된다.

1. 익명 프로시저
    - 1회용 코드 작성용


2. 실명 프로시저 > 저장 프로시저
    - 데이터베이스 객체
    - 저장용
    - 재호출
    
    1) 저장 프로시저, Stored Procedure
    2) 저장 함수, Stored Function


PL/SQL 프로시저 블럭 구조

1. 4개의 키워드(블럭)으로 구성
    - DECLARE
    - BEGIN
    - EXCEPTION
    - END
    
2. DECLARE
    - 선언부
    - 프로시저내에서 사용할 변수, 객체 등을 선언하는 영역
    - 생략 가능
    
3. BEGIN
    - 실행부, 구현부
    - BEGIN ~ END
    - 구현된 코드를 가지는 영역(메소드의 body와 동일)
    - 생략 불가능
    - ANSI-SQL 작성 + 연산 + 제어 등...

4. EXCEPTION
    - 예외처리부
    - catch 역할
    - 예외 처리 코드 작성
    - 생략 가능

5. END
    - BEGIN 블럭의 종료 역할
    - 생략 불가능
    

자료형 + 변수

PL/SQL 자료형
- 이전 자료형과 동일

변수 선언하기
- 변수명 자료형 [not null] [default 값];
- 주로 질의(select)의 결과값을 저장하거나


PL/SQL 연산자
- ANSI-SQL과 동일

대입 연산자
- ANSI-SQL의 대입 연산자
    ex) update table set column = '값';
- PL/SQL의 대입 연산자
    ex) 변수 := '값';
    
    
    

*/
-- 출력되는 부분을 화면에 보이게 해줌
-- 영구저장이 아니라 프로그램 시작 때마다 켜줘야함
set serveroutput on;  

set serverout off;



-- 익명 프로시저
declare
    num number;
    name varchar2(30);
    today date;
begin    
    num := 10;
    dbms_output.put_line(num);

    name := '홍길동';
    dbms_output.put_line(name);
    
    today := sysdate;
    dbms_output.put_line(today);
end;



declare
    num number;
    num2 number;
    num3 number := 300;
    num4 number default 400;
    num5 number not null default 500; -- not null > declare 블럭에서 반드시 초기화해야한다. 
begin 
    dbms_output.put_line(num);  -- null

    num2 := 200;
    dbms_output.put_line(num2);    
    dbms_output.put_line(num3);
    dbms_output.put_line(num4);
    
    -- PLS-00218: a variable declared NOT NULL must have an initialization assignment
    dbms_output.put_line(num5);
end;



/*
변수 > 테이블 select 결과를 담는 용도
- select into 절


*/

declare
    vbuseo varchar2(15);
    vname varchar2(15);
begin
    select buseo into vbuseo from tblinsa where name = '홍길동';
    dbms_output.put_line(vbuseo);
    
    select name into vname from tblInsa where buseo = vbuseo and jikwi = '대리' and rownum = 1;
    dbms_output.put_line(vname);

end;


declare
    buseo varchar2(15);
begin
    select buseo into buseo from tblInsa where name = '홍길동';
    dbms_output.put_line(buseo);
end;


declare
    vbuseo varchar2(15);
begin
    -- PLS-00428: an INTO clause is expected in this SELECT statement
    -- PL/SQL 프로시저 안에서는 순수한 select가 올 수 없다.
    -- select문은 반드시 결과를 PL/SQL 변수에 전달해야 한다.(***)
    select buseo into vbuseo from tblInsa where name = '홍길동';
    
    -- PLS-00201: identifier 'BUSEO' must be declared
    dbms_output.put_line(vbuseo);

end;



create table tblName(
    name varchar2(15)
);
select * from tblName;



declare 
    vname varchar2(15);
begin
    select name into vname from tblInsa where buseo = '개발부' and jikwi = '부장';
    insert into tblName (name) values (vname);
end;



declare
    vname varchar2(15);
    vbuseo varchar2(15);
    vjikwi varchar2(15);
begin

    -- into 사용시
    -- 1. 컬럼의 개수, 변수 개수 일치!
    -- 2. 컬럼의 순서, 변수 순서 일치!
    -- 3. 컬럼과 변수의 자료형 일치!
    select name, buseo, jikwi into vname, vbuseo, vjikwi
    from tblInsa where num = '1001';
    
    dbms_output.put_line(vname);
    dbms_output.put_line(vbuseo);
    dbms_output.put_line(vjikwi);
end;


/*
타입 참조

1. %type
    - 컬럼 1개 참조
    - 사용하는 테이블의 특정 컬럼값의 스키마를 알아내서 변수에 그대로 적용
    - 복사되는 정보
        a. 자료형
        b. 길이
        
2. %rowtype
    - 행 전체 *참조* (여러 개의 컬럼을 한 번에 참조)
    - %type의 집합형
            
*/



declare
    vbuseo tblinsa.buseo%type;  -- tblInsa의 buseo컬럼을 확인해서 동일한 타입과 길이로 변수를 생성
begin
    select buseo into vbuseo from tblInsa where name = '홍길동';
    dbms_output.put_line(vbuseo);
end;


declare
    vname tblinsa.buseo%type;
    vcity tblinsa.city%type;
    vbasicpay tblinsa.basicpay%type;
    vibsadate tblinsa.ibsadate%type;
begin
    select 
        name, city, basicpay, ibsadate
        into vname, vcity, vbasicpay, vibsadate
    from tblInsa where num = '1001';
    
    dbms_output.put_line(vname);
    dbms_output.put_line(vcity);
    dbms_output.put_line(vbasicpay);
    dbms_output.put_line(vibsadate);
end;


-- 직원 중 일부에게 보너스 지급 > 내역 저장
create table tblBonus (
    seq number primary key,
    num number(5) not null references tblInsa(num), --직원번호(FK)
    bonus number not null 
);
select * from tblBonus;

select * from tblInsa where city = '서울' and jikwi = '부장' and buseo = '영업부';
insert into tblBonus (seq, num, bonus) values (1, '김인수의 num', '김인수의 basicpay의 1.5배');


declare
    vnum tblInsa.num%type;
    vbasicpay tblinsa.basicpay%type;
begin
    select num, basicpay into vnum, vbasicpay
    from tblInsa 
    where city = '서울' and jikwi = '부장' and buseo = '영업부';

    insert into tblBonus (seq, num, bonus) values (1, vnum, vbasicpay * 1.5);
end;





select *
from tblbonus b 
        inner join tblInsa s on s.num = b.num;




--
select * from tblMen;
select * from tblWomen;


-- 무명씨 > 성전환 수술 > tblMen -> tblWomen 옮기기
-- 1. tblMen > select > 정보
-- 2. tblWomen > insert
-- 3. tblMen > delete



-- 2. rowtype 참조
declare
--    vname tblmen.name%type;
--    vage tblmen.age%type;
--    vheight tblmen.height%type;
--    vweight tblmen.weight%type;
--    vcouple tblmen.couple%type;

    vrow tblMen%rowtype;  -- 레코드 1개를 모두 저장할 수 있는 변수
begin

    -- 1.
    select * into vrow from tblMen where name = '무명씨';
    
--    dbms_output.put_line(vrow);
        
    -- 2.
    insert into tblWomen values (vrow.name, vrow.age, vrow.height, vrow.weight, vrow.couple);

    -- 3.
    delete from tblMen where name = vrow.name;

end;




-- 제어문
-- 1. 조건문
-- 2. 반복문

declare
    vnum number := 10;
begin
    if vnum > 0 then
        dbms_output.put_line('양수');
    end if;
end;


declare
    vnum number := -10;
begin
    if vnum > 0 then
        dbms_output.put_line('양수');
    else 
        dbms_output.put_line('음수');
    end if;
end;


declare
    vnum number := -10;
begin
    if vnum > 0 then
        dbms_output.put_line('양수');
    elsif vnum < 0 then 
        dbms_output.put_line('음수');
    else
        dbms_output.put_line('0');
    end if;
end;


declare
    vgender char(1);
begin
    select substr(ssn, 8, 1) into vgender from tblInsa where num = '1001';
    
    if vgender = '1' then
        dbms_output.put_line('남자 업무 진행');
    elsif vgender = '2' then
        dbms_output.put_line('여자 업무 진행');
    end if;
end;



-- 직원 1명 선택 > 보너스 지급 > 간부(basicpay * 1.5), 사원(basicpay * 2)
declare
    vnum tblInsa.num%type;
    vbasicpay tblInsa.basicpay%type;
    vjikwi tblinsa.jikwi%type;
    vbonus number;
    
begin 
    select num, basicpay, jikwi into vnum, vbasicpay, vjikwi 
    from tblInsa where name = '홍길동';

    if vjikwi in ('부장', '과장') then
        vbonus := vbasicpay * 1.5;
    elsif vjikwi in ('대리', '사원') then
        vbonus := vbasicpay * 2;
    end if;
    
    insert into tblBonus values (2, vnum, vbonus);

end;


select * from tblBonus;



/*
case 문
- ANSI-SQL case와 유사 & 다른 구문
- 자바의 switch, 다중 if문과 유사
*/

declare
    vcontinent tblCountry.continent%type;
    vresult varchar2(30);
begin  
    select continent into vcontinent from tblCountry where name = '영국';
    
    if vcontinent = 'AS' then
        vresult := '아시아';
    elsif vcontinent = 'EU' then
        vresult := '유럽';
    elsif vcontinent = 'AF' then
        vresult := '아프리카';
    else
        vresult := '기타';
    end if; 
    dbms_output.put_line(vresult);
    
    
    case vcontinent
        when 'AS' then vresult := '아시아';
        when 'EU' then vresult := '유럽';
        when 'AF' then vresult := '아프리카';
        else vresult := '기타';
    end case;
    dbms_output.put_line(vresult);
    
    case 
        when vcontinent = 'AS' then vresult := '아시아';
        when vcontinent = 'EU' then vresult := '유럽';
        when vcontinent = 'AF' then vresult := '아프리카';
        else vresult := '기타';
    end case;
    dbms_output.put_line(vresult);
end;


/*
반복문
1. loop
    - 단순 반복
    
    ex) loop
        
        exit when 종료조건
        end loop;
        
2. for loop
    - 횟수 반복(자바 for)
    
    ex) for i in 1 .. 10 loop
        end loop;
    
3. while loop
    - 조건 반복(자바 while)
    - loop 기반
    
    ex) while  vnum <= 10 loop
        dbms_output.put_line(vnum);
        vnum := vnum + 1;
        end loop;
*/

set serverout on;


declare
    vnum number := 1;
begin
    loop
        dbms_output.put_line(to_char(sysdate, 'hh24:mi:ss'));
        vnum := vnum + 1;
        
        exit when vnum > 10; -- 조건부 break        
    end loop;
end;


create table tblLoop (
    seq number primary key,
    data varchar2(30) not null
);
select * from tblloop;
create sequence seqLoop;

-- 데이터 * 1000건 추가


declare
    vnum number := 1;
begin
    loop
        insert into tblLoop values (seqLoop.nextVal, '데이터' || vnum);
        vnum := vnum + 1;
        exit when vnum > 10000;
    end loop;
end;


select count(*) from tblloop;


-- 2. for loop

begin
    for i in reverse 1 .. 10 loop
        dbms_output.put_line('숫자' || i);
    end loop;
end;

create table tblGugudan (
    dan number not null,
    num number not null,
    result number not null,
    
    -- 복합키는 제약조건을 따로 빼서 줘야함
    -- 복합키 선언 방법
    constraint tblgugudan_dan_num_pk primary key(dan, num)
);

alter table tblGugudan
    add constraint tblgugudan_dan_num_pk primary key(dan, num);



begin
    for dan in 2 .. 9 loop
        for num in 1..9 loop
            insert into tblGugudan (dan, num, result)
                values(dan, num, dan*num);
        end loop;
    end loop;
end;



-- 3. while loop
declare
    vnum number := 1;
begin
    while  vnum <= 10 loop
        dbms_output.put_line(vnum);
        vnum := vnum + 1;
    end loop;
end;



/*
select > 결과셋 > PL/SQL 변수 대입

1. select into
    - 결과셋의 레코드가 1개일 때만 사용이 가능하다.

2. cursor
    - 결과셋의 레코드가 N개 일 때 사용한다.

declare
    변수 선언;
    커서 선언; -- 결과셋 참조 객체
begin
    커서 열기;
        LOOP
            데이터 접근(레코드 마다) <- 커서 사용
        END LOOP;
    커서 닫기;
end;

*/


declare
    vname tblinsa.name%type;
begin
    -- ORA-01422: exact fetch returns more than requested number of rows
    select name into vname from tblInsa; --where num = '1001';
    dbms_output.put_line(vname);
end;



-- 다중행 + 단일 컬럼
-- 직원명 60개 가져오기

declare
    vname tblInsa.name%type;
    cursor vcursor is select name from tblInsa order by name;
begin
    open vcursor; --커서 열기 > select 실행 > 결과셋에 커서가 연결(참조)
        loop
            fetch vcursor into vname;   -- select into의 역할
            exit when vcursor%notfound; -- boolean
            
            dbms_output.put_line(vname);
        end loop;
    close vcursor;
end;



-- '기획부' 이름, 직위, 급여
declare
    cursor vcursor
        is select name, jikwi, basicpay from tblInsa where buseo = '기획부' order by num;
    
    vname tblInsa.name%type;
    vjikwi tblInsa.jikwi%type;
    vbasicpay tblInsa.basicpay%type;
begin
    open vcursor;
    
    loop
        fetch vcursor into vname, vjikwi, vbasicpay;
        exit when vcursor%notfound;
        
        dbms_output.put_line(vname || '-' || vjikwi || '-' || vbasicpay);
            
    end loop;
    
    close vcursor;
end;


select * from tblBonus;
insert into tblBonus values(2, 1001, 3915000);
delete from tblBonus;

create sequence seqBonus start with 3;

-- 모든 직원에게 보너스 지급. 간부(1.5), 사원(2)
declare
    cursor vcursor 
        is select * from tblInsa;
    vrow tblInsa%rowtype;
begin
    open vcursor;
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
    
        if vrow.jikwi in ('과장', '부장') then
            insert into tblBonus values (seqBonus.nextVal, vrow.num, vrow.basicpay * 1.5);
        elsif vrow.jikwi in ('사원', '대리') then
            insert into tblBonus values (seqBonus.nextVal, vrow.num, vrow.basicpay * 2);
        end if;
        
    end loop;
    close vcursor;
end;



-- 직원당 보너스 총 얼마? 총 몇 번?
select
    i.name,
    count(*),
    sum(b.bonus)
from tblBonus b
        inner join tblInsa i on i.num = b.num 
group by name
order by name desc;



/* DB 프로젝트
진행기간 : 2021.11.22 - 2021.12.03(2주간, 일 4시간, 총 40시간)
-> 아니면 차라리 기간을 줄여서 작성 11.29-12.03(1주간)
- 하루 8시간 산정하여 적는게 편함
*/


-- 커서 탐색
-- 1. 커서 + loop > 소홀X (소홀히 하면 안됨..!)
-- 2. 커서 + for loop > 극단적 간단한 표현

declare
    cursor vcursor
        is select * from tblInsa;
begin 
    for vrow in vcursor loop -- loop + fetch + vrow + exit when
        dbms_output.put_line(vrow.name);
    end loop;
end;



begin 
    for vrow in (select * from tblInsa) loop
        dbms_output.put_line(vrow.name);
    end loop;
end;



-- 예외 처리
declare
--    vname tblInsa.name%type;
    vname number;
begin 
    dbms_output.put_line('시작');
    select name into vname from tblInsa where num = '1001';
    dbms_output.put_line('끝');
exception
    when others then
        dbms_output.put_line('예외 처리');
end;



-- DB계층 > 오류 발생 > 기록 남긴다.
create table tblLog(
    seq number primary key,                                                                                    -- PK
    code varchar2(7) not null check (code in ('A001', 'B001', 'B002', 'C001')), -- 에러 상태 코드
    message varchar2(1000) not null,                                                                    -- 에러 메시지
    regdate date default sysdate not null                                                               -- 에러 발생 시간
);


create sequence seqLog;

commit;
rollback;

select * from tblCountry;
drop table tblCountry;

delete from tblCountry;

declare 
    vcnt number;
    vname tblInsa.name%type;
begin
    select count(*) into vcnt from tblCountry;
    select name into vname from tblInsa where num = '1000';
    
    dbms_output.put_line(100/ vcnt); -- ORA-01476: divisor is equal to zero
    dbms_output.put_line(vname);    -- ORA-01403: no data found
    
exception
    when NO_DATA_FOUND then
        insert into tblLog values (seqLog.nextVal, 'B001', '선택한 이름이 null입니다.', default);
    
    when ZERO_DIVIDE then
            insert into tblLog values (seqLog.nextVal, 'A001', 'tblCountry가 비어있습니다.', default);
    
    when others then 
        dbms_output.put_line('예외');
    
end;

select * from tblLog;

-- 익명 프로시저 끝~
-- ~ 실명 프로시저 시작




/* 익명 프로시저 

1. 저장 프로시저, Stored Procedure

CREATE [OR REPLACE] PROCEDURE 프로시저명
IS(AS)
[   변수 선언;
    커서 선언;]
BEGIN
    구현부;
[EXCEPTION
    예외처리;]
END [프로시저명];

*/


set serveroutput on;


-- Procedure PRONUM이(가) 컴파일되었습니다. > 오라클 서버에 저장했습니다.
create or replace procedure procNum
is
    vnum number;
begin
    vnum := 100;
    dbms_output.put_line('num:' || vnum);
end procNum;

drop procedure proNum;  -- 프로시저 삭제.

-- 저장 프로시저 호출하는 방법
-- 1. PL/SQL 블럭에서 호출하기 > 권장
-- 2. 스크립트 환경에서 호출하기(ANSI-SQL 환경) > 비권장




-- 1. PL/SQL 블럭에서 호출하기 > 권장
begin
    procNum; -- 저장 프로시저 호출
end;


create or replace procedure procTest
is
begin
    procNum;    -- 다른 프로시저 호출(메소드 -> 다른 메소드 호출)
end;



begin
    procTest;
end;



-- 2. 스크립트 환경에서 호출하기(ANSI-SQL 환경) > 비권장 
--  > 프로시저와 연계된 연속 작업 불가능(리턴값을 받지 못해서)
execute procNum;
exec procNum;
call procNum(); -- 뒤에 수업할 때 다시 사용(JDBC)



-- 프로시저(= 메소드)
-- 1. 매개변수
-- 2. 반환값



-- 매개변수가 있는 프로시저
create or replace procedure procTest(pnum number)
is
    vsum number := 0;
begin
    vsum := pnum + 100;
    dbms_output.put_line(vsum);
end procTest;

-- 호출
begin
    procTest(100);
end;



create or replace procedure procTest(
    pwidth number, 
    pheight number
)
is
    varea number;
begin
    varea := pwidth * pheight;
    dbms_output.put_line(varea);
end procTest;

-- 호출
begin
    procTest(100,200);
end;



/*
매개변수 모드
- 매개변수의 값을 전달하는 방법
1. in
2. out
3. in out
*/



create or replace procedure procTest(
    pnum1 in number,    -- in 역할 > 매개변수 역할
    pnum2 in number,
    presult out number  -- out 역할 > 반환값의 역할 
)
is
begin 
    presult := pnum1 + pnum2;

end procTest;


declare
    vresult number;
begin
    procTest(10,20, vresult); -- 공간 그 자체를 매개변수로 넘긴다.(참조 변수) > 변수의 주소값 전달
    dbms_output.put_line(vresult);
end;


-- 직원 번호 전달 > 이름, 나이, 부서, 직위 반환
-- pnum in tblInsa.num%type // 타입 참조 불가능
-- pnum in number(10) // 길이 기재 불가능 
create or replace procedure procGetInsa(
    pnum in number,
    pname out varchar2,
    page out varchar2,
    pbuseo out varchar2,
    pjikwi out varchar2
)
is
begin 
    select
        name, 
        floor(months_between(sysdate, to_date('19' || substr(ssn, 1, 6), 'yyyymmdd')) / 12), 
        buseo, jikwi 
            into pname, page, pbuseo, pjikwi
    from tblInsa where num = pnum;

end procGetInsa;



declare
    vname tblInsa.name%type;
    vage number;
    vbuseo tblInsa.buseo%type;
    vjikwi tblInsa.jikwi%type;
begin
    procGetInsa(1001, vname, vage, vbuseo, vjikwi);
    dbms_output.put_line(vname);
    dbms_output.put_line(vage);
    dbms_output.put_line(vbuseo);
    dbms_output.put_line(vjikwi);
end;


--직원 추가 프로시저
insert into tblInsa(num, name, ssn, ibsadate, city, tel, buseo, jikwi, basicpay, sudang)
    values((select max(num)+1 from tblInsa), '', '','','', '', '', '' ,0, 0);

create or replace procedure procAddInsa(
    pname varchar2,
    pssn varchar2,
    pibsadate varchar2,
    pcity varchar2,
    ptel varchar2,
    pbuseo varchar2,
    pjikwi varchar2,
    pbasicpay number,
    psudang number,
    presult out number -- 성공(1) or 실패(0)
)
is
begin
    insert into tblInsa(num, name, ssn, ibsadate, city, tel, buseo, jikwi, basicpay, sudang)
        values((select max(num)+1 from tblInsa), pname, pssn , pibsadate, pcity, ptel, pbuseo, pjikwi, pbasicpay, psudang);
        
    presult := 1;    

exception 
    when others then 
        presult := 0;
end procAddInsa;


-- 호출
declare
    vresult number;
begin
    procAddInsa('아무개', '951129-2012345', '2018-05-10', '서울', '010-1234-5678',
                '영업부', '사원', 2000000, 100000, vresult);
                
    if vresult = 1 then
        dbms_output.put_line('성공');
    else
        dbms_output.put_line('실패');
    end if;
end;


select * from tblInsa;



-- 문제1. 직원번호(num)와 보내스배율(1.2, 1.5)을 전달하면 tblBonus에 항목을 추가하는 프로시저를 만드시오.
-- in > num, bonus 
-- out > result
-- a. num > select > basicpay 
-- b. num + basicpay * 보너스배율 > insert
-- c. result > 확인용 out 매개변수 사용

select * from tblBonus;


create or replace procedure procBonus(
    pnum number,
    pbonus number,
    presult out number
)
is
    vbasicpay tblinsa.basicpay%type;

begin 
    
    -- 1.
    select basicpay into vbasicpay from tblInsa where num = pnum;
    -- 2.
    insert into tblBonus (seq, num, bonus) values (seqBonus.nextVal, pnum, vbasicpay * pbonus);
    -- 3.
    presult := 1;
    
exception 
    when others then
        presult := 0;
end procBonus;


-- 호출
declare
    vresult number;
begin 
    procBonus(1001, 3, vresult);
    if vresult = 1 then
        dbms_output.put_line('Success');
    else
        dbms_output.put_line('Failed');
    end if;
end;




-- 문제2. 직원이 퇴사하는 프로시저를 만드시오.
-- in > num, num2
-- out > result
-- a. 해당 직원이 담당하는 프로젝트가 있는지 확인
-- b. 다른 직원에게 프로젝트를 위임한다.
-- c. 해당 직원이 퇴사한다.
-- d. result > 확인용 out 매개변수 사용
select * from tblStaff;
select * from tblProject;


create or replace procedure procDeleteStaff(
    pseq number,    -- 퇴사자
    pseq2 number,   -- 위임자
    presult out number 
)
is
    vcnt number;
begin
    -- 1.
    select count(*) into vcnt from tblProject where staff_seq = pseq;
    -- 2.
    if vcnt > 0 then
        update tblProject 
        set staff_seq = pseq2 
        where staff_seq = pseq; 
    end if;
    
    -- 3.
    delete from tblStaff where seq = pseq;
    
    -- 4.
    presult := 1;
    
exception
    when others then
        presult := 0;

end procDeleteStaff;


-- 호출
declare
    vresult number;
begin
    procDeleteStaff(2, 3, vresult);
    
    if vresult = 1 then
        dbms_output.put_line('Success');
    else
        dbms_output.put_line('Failed');
    end if;
        
end;


/*
프로시저
    - in > N개
    - out > N개

함수
    - in > N개
    - out > 1개


2. 함수, Function
- 실행 후 결과값을 반드시 1개만 반환하는 프로시저
- 함수에서도 out 매개변수를 사용할 수 있다. > 사용하면 안된다. > return문을 사용해야 한다.

*/

create or replace function fnSum(
    pnum1 number,
    pnum2 number
) return number 
is
begin 
    return pnum1 + pnum2;
end fnSum;



declare
    vsum number;
begin 
    vsum := fnSum(10, 20);
    dbms_output.put_line(vsum);
end;



create or replace function fnGender(
    pssn varchar2
) return varchar2
is
begin
    if substr(pssn, 8, 1) = '1' then
        return '남자';
    elsif substr(pssn, 8, 1) = '2' then
        return '여자';
    end if;
    
end fnGender;


-- *** 저장 프로시저는 ANSI-SQL내에서 사용이 불가능하다. > 이유 : 반환값 형태와 개수 때문
-- *** 저장 함수는 ANSI-SQL내에서 사용이 가능하다. > 이유 : 반환값 형태와 개수(1개)
select
    num,
    basicpay,
    fnGender(ssn) as gender -- *** function
from tblInsa;


select * from employees;





-- ----------------- 2021-11-30(화) ----------------------

/* Trigger, 트리거
- 프로시저의 일종(이름이 있다. 저장이 된다.)
- 특정 사건이 발생하면(미리 예약) 자동으로 호출되는 프로시저
- 특정 테이블 지정(목표) > 감시 > insert or update or delete > 미리 준비해놓은 프로시저 호출

1. 프로시저 > 사용자가 호출 > PL/SQL상에서..
2. 함수 > 사용자가 호출 > PL/SQL + ANSI-SQL상에서..
3. 트리거 > 시스템이 호출 > ?? > 이벤트가 발생하면 미리 등록해놓은 트리거가 실행


create or replace trigger 트리거명
    -- 트리거 옵션 
    before | after
    insert | update | delete on 테이블명
    for each row
declare 
    선언부;
begin
    실행부;
exception
    예외처리부;
end;

*/


select * from tblStaff;
select * from tbllogstaff;

-- 직원 추가, 수정, 삭제 > tblLogStaff 기록
create sequence seqLogStaff start with 5;

create table tblLogStaff (
    seq number primary key,
    message varchar2(1000) not null,
    regdate date default sysdate not null
);

-- A.
insert into tblStaff (seq, name, salary, address) 
    values (5, '유재석', 300, '서울시');

insert into tblLogStaff (seq, message, regdate)
    values (seqLogStaff.nextVal, '유재석 직원을 추가했습니다.', default);



-- B. 프로시저
-- 앞으로는 이 procAddStaff를 사용하세요 공지!
create or replace procedure procAddStaff (
    pseq number,
    pname varchar2,
    psalary number,
    paddress varchar2
)
is 
begin 
    insert into tblStaff (seq, name, salary, address) 
    values (pseq, pname, psalary, paddress);

    insert into tblLogStaff (seq, message, regdate)
    values (seqLogStaff.nextVal, pname || ' 직원을 추가했습니다.', default);
end procAddStaff;


begin
    procAddStaff(6, '강호동', 350, '부산시');
end;



-- C. 트리거
create or replace trigger trgLogStaff
    after
    insert on tblStaff -- tblStaff에 새로운 행이 insert되면 그 직후에 이 트리거 호출
declare

begin
    insert into tblLogStaff (seq, message, regdate)
    values (seqLogStaff.nextVal, '새 직원을 추가했습니다.', default);
end trgLogStaff;


insert into tblStaff (seq, name, salary, address) 
    values (7, '제시', 250, '울산시');

/*
연속된 2개 작업을 할 때..(직원 추가 > 로그 기록)
- 직원 추가(주업무) > 로그 기록(보조업무)
- 계좌 송금(주업무) > 계좌 인출(주업무)

1. 프로시저
    - 연속된 작업이 모두 주업무일 때..(동등한 수준의 업무들..)
    - 눈에 보인다.
    
2. 트리거
    - 선행 작업은 주업무이고, 후생 작업은 보조업무일 때..(수준이 다른 업무들..)
    - 눈에 안보인다.
    - 트리거가 프로시저보다 약간 더 무겁(24시 감시하기 때문에, 비용 높)

For each row
1. 사용 O
    - 행 단위 트리거 > 트리거 실행 반복
    - 감시하던 작업이 여러개의 레코드에서 발생하면 그 횟수만큼 트리거 발생
    - 적용된 레코드의 정보를 사용하는 경우
    
2. 사용 X
    - 문장 단위 트리거 > 트리거 실행 1회
    - 감시하던 작업이 여러개의 레코드에서 발생해도 트리거는 단 1번만 실행
    - 적용된 레코드의 정보를 사용하지 않는 경우
    
For each row에서만 사용 가능한 상관 관계
- 사건이 발생한 레코드를 참조하는 역할 

1. :new
    - 새로운 데이터로 추가(변경)된 행을 참조
    - insert or update -> 새로운 정보를 가져오는 역할

2. :old
    - 변경되거나 삭제되는 이전 행을 참조
    - update or delete -> 이전 정보를 가져오는 역할
*/


select * from tblTodo;

create or replace trigger trgTodo
    after
    update on tblTodo
    for each row
begin
--    dbms_output.put_line('tblTodo가 수정되었습니다.');
--    dbms_output.put_line(:new.title || '이 수정되었습니다.');
    dbms_output.put_line('수정전 : ' || :old.title );
    dbms_output.put_line('수정후 : ' || :new.title );
end;

set serveroutput on;


update tblTodo set title = '고양이 산책시키기' where seq= 5; -- 적용되는 행의 개수 > 1개
update tblTodo set completedate = sysdate where completedate is null; -- 적용되는 행의 개수 > N개

rollback;


--
select * from tblStaff;
select * from tblProject;

-- 업무 위임 프로시저
declare
    vresult number;
begin
    procDeleteStaff(4, 3, vresult);
    dbms_output.put_line(vresult);
end;

-- 트리거(퇴사 -> 어떤 업무를 누구에게 위임했는지 기록)
create or replace trigger trgDeleteStaff
    before
    delete on tblStaff
    for each row
declare
    vname tblStaff.name%type; 
begin 
    select name into vname from tblStaff where seq = :old.seq;
    dbms_output.put_line('[' || to_char(sysdate, 'HH24:MI:SS') || ']퇴사자(' || vname || ')');
end trgDeleteStaff;


create or replace trigger trgDelegateProject
    after
    update on tblProject
    for each row
declare
    vname1 tblStaff.name%type;
    vname2 tblStaff.name%type;
begin     
    select name into vname1 from tblStaff where seq = :old.staff_seq;
    select name into vname2 from tblStaff where seq = :new.staff_seq;
    
    dbms_output.put_line('[' || to_char(sysdate, 'HH24:MI:SS') || ']퇴사자(' || vname1 || ') 인계자(' || vname2 || ')');
    
end trgDelegateProject;

rollback;


/*
개인당 2-5개 이내 트리거 생성 > 포트폴리오 넣을 정도만.. 면접 대답할 정도만..
면접 질문 > 대답(정의, 설명) + 사례(***)
*/



/*
테이블 삭제
- 테이블 관계(부모-자식)
- 삭제하려는 테이블과 관계를 맺고 있는 자식 테이블을 확인하는 방법?
    1. ERD(FM)
    2. 
    
삭제 방법 
    1. 자식 테이블 삭제 > 부모 테이블 삭제
    2. FK 제약사항을 삭제
    3. drop table tblStaff cascade constraints purge -- 2번을 먼저 실행한 뒤 drop을 합친 행동


*/


-- 자식 테이블 목록을 보여줌
SELECT fk.owner, fk.constraint_name , fk.table_name
FROM all_constraints fk, all_constraints pk
WHERE fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME
   AND fk.CONSTRAINT_TYPE = 'R'
   AND pk.TABLE_NAME = 'TBLGENRE' --대문자
ORDER BY fk.TABLE_NAME;



/*
- 화요일 > 테이블 정의서 > 데이터
- 수요일 > 데이터 > 업무 SQL
- 목요일 > 업무 SQL > DB Object(뷰, 프로시저..) > 개인당 비율 정하기 
- 금요일

-- eXRD 그림 참고
점선 : 비식별 관계
실선 : 식별 관계 (참조하는 FK가 PK 역할을 하는 것)

- 대부분은 비식별 관계가 나옴
- 식별 관계는 테이블간 관계가 강하다.
*/




-- 업무 SQL > 운영실 직원 학생 명단.. > select
select * from tblInsa;


-- 업무 SQL > 결과셋 소비(보는 사람?) > 최종 사용자

-- 프로시저의 결과셋을 반환하는 작업
-- 소비 > 또 다른 PL/SQL or 자바 응용 프로그램


-- 커서를 반환하는 방법
create or replace procedure procBuseo(
    pbuseo varchar2
)
is
    cursor vcursor
        is select * from tblInsa where buseo = pbuseo;
    
    vrow tblInsa%rowtype;

begin
    open vcursor;
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        -- *** 문제!!
        dbms_output.put_line(vrow.name);    -- 최종 소비
        
    end loop;
    close vcursor;

end procBuseo;

set serveroutput on;


-- 2. cursor 반환하여 출력 (실제 현장에서 사용..!)
declare
    vbuseo varchar2(15) := '영업부';
begin
    procBuseo(vbuseo);
end;


create or replace procedure procBuseo(
    pbuseo varchar2,
    presult out sys_refcursor   -- 반환값으로 사용할 때 커서의 자료형
)
is
begin
    open presult
        for select * from tblInsa where buseo = pbuseo;
end procBuseo;


-- 보통 자바 연동은 위 프로시저만 넘기고, 아래 코드는 DB개발자 테스트용
declare 
    vbuseo varchar2(15) := '영업부';
    vresult sys_refcursor; -- out 커서
    vrow tblInsa%rowtype;
begin
    procBuseo(vbuseo, vresult);
    
    loop
        fetch vresult into vrow;
        exit when vresult%notfound;
        
        -- *** 선택
        dbms_output.put_line(vrow.name || '-' || vrow.jikwi || '-' || vrow.buseo);
    end loop;
end;



