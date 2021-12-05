--1. traffic_accident. 각 교통 수단 별(지하철, 철도, 항공기, 선박, 자동차) 발생한 총 교통 사고 발생 수, 총 사망자 수, 사건 당 평균 사망자 수를 가져오시오.
-- 0인거는 가져오지 않기



--2. tblZoo. 종류(family)별 평균 다리의 갯수를 가져오시오.
select family, round(avg(leg),1) as "평균다리개수"
from tblZoo
group by family;


    
--3. tblZoo. 체온이 변온인 종류 중 아가미 호흡과 폐 호흡을 하는 종들의 갯수를 가져오시오.
select breath, count(*) as cnt
from tblZoo
group by breath;



--4. tblZoo. 사이즈와 종류별로 그룹을 나누고 각 그룹의 갯수를 가져오시오.
select sizeof, family, count(*) as cnt
from tblZoo
group by sizeof, family
order by family, sizeof;



--5. tblMen. tblWomen. 서로 짝이 있는 사람 중 남자와 여자의 정보를 모두 가져오시오.
--    [남자]        [남자키]   [남자몸무게]     [여자]    [여자키]   [여자몸무게]
--    홍길동         180       70            장도연     177        65
--    아무개         175       null          이세영     163        null
--    ..

select
    name as "[남자]",
    height as "[남자키]",
    weight as "[남자몸무게]",
    (select name from tblWomen where name = tblMen.couple) as "[여자]",
    (select height from tblWomen where name = tblMen.couple) as "[여자키]",
    (select weight from tblWomen where name = tblMen.couple) as "[여자몸무게]"
from tblMen;



--10. tblAddressBook. 가장 많은 사람들이 가지고 있는 직업은 주로 어느 지역 태생(hometown)인가?
select hometown, count(*) as cnt
from tblAddressBook
where job = (select job from tblAddressBook group by job 
                        having count(*) = (select max(count(*)) from tblAddressBook group by job))
group by hometown
order by count(*) desc;


--12. tblAddressBook. 관리자의 실수로 몇몇 사람들의 이메일 주소가 중복되었다. 중복된 이메일 주소만 가져오시오.
select email
from tblAddressBook
group by email
having count(*) > 1;



-- 해야함
--13. tblAddressBook. 이메일 도메인들 중 평균 아이디 길이가 가장 긴 이메일 사이트의 도메인은 무엇인가?
select substr(email, instr(email, '@') + 1), count(*)
from tblAddressBook
group by substr(email, instr(email, '@') + 1);


select
    substr(email, instr(email, '@') + 1)
    avg(length(substr(email, 1, instr(email, '@')-1)))
--    (select * from tblAddressBook where email = sub )

from tblAddressBook
group by substr(email, instr(email, '@') + 1);


-- 해야함
--14. tblAddressBook. 평균 나이가 가장 많은 출신(hometown)들이 가지고 있는 직업 중 가장 많은 직업은?

select job
from tblAddressBook
group by job 
having count(*) = (
    select max(count(*))
    from tblAddressBook
    where hometown = (
        select hometown
        from tblAddressBook
        group by hometown
        having avg(age) = (select max(avg(age)) from tblAddressBook group by hometown)
    )
    group by job
);

select job
from 최고평균지역
group by job
having count(*) = (
select max(count(*))
from (select *from tblAddressBook
                where hometown = (
                    select hometown 
                    from tblAddressBook 
                    group by hometown
                    having avg(age) = (select max(avg(age)) from tblAddressBook group by hometown))
 ) as 최고평균지역
 group by job
 );
                



--15. tblAddressBook. 성씨별 인원수가 100명 이상 되는 성씨들을 가져오시오.
select substr(name, 1, 1) as "성", count(*) as cnt
from tblAddressBook
group by substr(name, 1, 1)
having count(*) >= 100;



--16. tblAddressBook. 남자 평균 나이보다 나이가 많은 서울 태생 + 직업을 가지고 있는 사람들을 가져오시오.
select *
from tblAddressBook
where age > (select avg(age) from tblAddressBook where gender = 'm') 
            and hometown = '서울'
            and job not in('취업준비생');



--17. tblAddressBook. 이메일이 스네이크 명명법으로 만들어진 사람들 중에서 여자이며, 20대이며, 키가 150~160cm 사이며, 고향이 서울 또는 인천인 사람들만 가져오시오.
select *
from (select * from tblAddressBook where instr(email, '_') > 1)
where gender = 'f' 
                and age >= 20 
                and height between 150 and 160 
                and hometown in ('서울', '인천');



--18. tblAddressBook. gmail.com을 사용하는 사람들의 성별 > 세대별(10,20,30,40대) 인원수를 가져오시오.
select 
    decode(gender, 'm', '남자', 'f', '여자') as "성별",
    floor(age/10) * 10 || '대' as "세대", 
    count(*) as cnt
from (select * from  tblAddressBook where substr(email, instr(email, '@') + 1) = 'gmail.com')
group by gender, floor(age / 10)
order by "세대", "성별";



--19. tblAddressBook. 가장 나이가 많으면서 가장 몸무게가 많이 나가는 사람과 같은 직업을 가지는 사람들을 가져오시오.
select *
from tblAddressBook
where job = (select job from tblAddressBook
        where (age, weight) = (select max(age), max(weight) from tblAddressBook));



--20. tblAddressBook. '건물주'와 '건물주자제분'들의 거주지가 서울과 지방의 비율이 어떻게 되느냐?
select 
    sum(cnt) as "전체",
    round((sum(case when locate = '서울특별시' then cnt end) / sum(cnt)) * 100, 1) || '%' as "서울",
    round((sum(case when locate not like '서울특별시' then cnt end) / sum(cnt)) * 100, 1) || '%' as "지방"
from(
        select substr(address, 1, instr(address, ' ')-1) as locate, count(*) as cnt
        from tblAddressBook
        where job in ('건물주', '건물주자제분')
        group by substr(address, 1, instr(address, ' ')-1)
);



--21. tblAddressBook.  동명이인이 여러명 있습니다. 이 중 가장 인원수가 많은 동명이인(모든 이도윤)의 명단을 가져오시오.
select *
from tblAddressBook
where name = (
    select name
    from tblAddressBook
    group by name
    having count(*) = (
            select max(count(*))
            from tblAddressBook
            group by name
    )
);



--22. tblAddressBook. 가장 사람이 많은 직업의(332명) 세대별 비율을 구하시오.
--    [10대]       [20대]       [30대]       [40대]
--    8.7%        30.7%        28.3%        32.2%
select 
    round((count(case when floor(age / 10 ) * 10 = 10 then 1 end) / count(*)) * 100, 1) || '%' as "[10대]",
    round((count(case when floor(age / 10 ) * 10 = 20 then 1 end) / count(*)) * 100, 1) || '%'as "[20대]",
    round((count(case when floor(age / 10 ) * 10 = 30 then 1 end) / count(*)) * 100, 1) || '%'as "[30대]",
    round((count(case when floor(age / 10 ) * 10 = 40 then 1 end) / count(*)) * 100, 1) || '%'as "[40대]"
from (
        select *
        from tblAddressBook
        where job = (
                select job
                from tblAddressBook
                group by job
                having count(*) = (
                        select max(count(*))
                        from tblAddressBook
                        group by job
                )
        )
) maxJob;


