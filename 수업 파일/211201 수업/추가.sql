-- 추가.sql

drop table tblResult;
drop table tblSemester;
drop table tblSubject;
drop table tblStudent;



/* 학생 */
CREATE TABLE tblStudent (
	seq NUMBER NOT NULL primary key,
	name VARCHAR2(50),
	tel VARCHAR2(15)
);


/* 과목 */
CREATE TABLE tblSubject (
	seq NUMBER NOT NULL primary key,
	name VARCHAR2(50) NOT NULL
);


/* 학기 */
CREATE TABLE tblSemester (
	student_seq NUMBER NOT NULL,
	subject_seq NUMBER NOT NULL,
	grade NUMBER,
	class NUMBER,
    constraint tblsemester_ss_pk primary key(student_seq, subject_seq),
    constraint tblsemester_st_fk foreign key(student_seq) references tblStudent(seq),
    constraint tblsemester_su_fk foreign key(subject_seq) references tblSubject(seq)
);


/* 성적 */
CREATE TABLE tblResult (
	seq NUMBER NOT NULL primary key, 
	student_seq NUMBER,
	subject_seq NUMBER, 
	score NUMBER,
    constraint tblresult_ss_fk foreign key(student_seq, subject_seq) references tblSemester(student_seq, subject_seq)
);




-- 학생
insert into tblStudent values (1, '홍길동', '010-1111-1111');
insert into tblStudent values (2, '아무개', '010-2222-2222');
insert into tblStudent values (3, '테스트', '010-3333-3333');
insert into tblStudent values (4, '유재석', '010-4444-4444');
insert into tblStudent values (5, '강호동', '010-5555-5555');


--과목
insert into tblSubject values (1, '국어');
insert into tblSubject values (2, '영어');
insert into tblSubject values (3, '수학');
insert into tblSubject values (4, '국사');
insert into tblSubject values (5, '윤리');
insert into tblSubject values (6, '물리');
insert into tblSubject values (7, '생물');

--학기
insert into tblSemester values (1, 1, 1, 1);
insert into tblSemester values (1, 2, 1, 1);
insert into tblSemester values (1, 3, 1, 1);

insert into tblSemester values (2, 1, 1, 2);
insert into tblSemester values (2, 2, 1, 2);
insert into tblSemester values (2, 3, 1, 2);
insert into tblSemester values (2, 4, 1, 2);

insert into tblSemester values (3, 1, 1, 3);
insert into tblSemester values (3, 2, 1, 3);
insert into tblSemester values (3, 3, 1, 3);
insert into tblSemester values (3, 4, 1, 3);
insert into tblSemester values (3, 5, 1, 3);
insert into tblSemester values (3, 6, 1, 3);
insert into tblSemester values (3, 7, 1, 3);

insert into tblSemester values (4, 3, 1, 4);
insert into tblSemester values (4, 4, 1, 4);
insert into tblSemester values (4, 5, 1, 4);
insert into tblSemester values (4, 6, 1, 4);
insert into tblSemester values (4, 7, 1, 4);

insert into tblSemester values (5, 2, 1, 5);
insert into tblSemester values (5, 3, 1, 5);

--성적
insert into tblResult values (1, 1, 1, 100);
insert into tblResult values (2, 1, 2, 90);
insert into tblResult values (3, 1, 3, 95);

insert into tblResult values (4, 2, 1, 99);
insert into tblResult values (5, 2, 2, 77);
insert into tblResult values (6, 2, 3, 88);
insert into tblResult values (7, 2, 4, 66);

insert into tblResult values (8, 3, 1, 89);
insert into tblResult values (9, 3, 2, 87);
insert into tblResult values (10, 3, 3, 77);
insert into tblResult values (11, 3, 4, 85);
insert into tblResult values (12, 3, 5, 76);
insert into tblResult values (13, 3, 6, 98);
insert into tblResult values (14, 3, 7, 70);

insert into tblResult values (15, 4, 3, 68);
insert into tblResult values (16, 4, 4, 63);
insert into tblResult values (17, 4, 5, 58);
insert into tblResult values (18, 4, 6, 58);
insert into tblResult values (19, 4, 7, 60);

insert into tblResult values (20, 5, 2, 99);
insert into tblResult values (21, 5, 3, 98);




select * from tblStudent;
select * from tblSubject;
select * from tblSemester;
select * from tblResult;


commit;



select 
    *
from tblStudent s 
        inner join tblSemester m on s.seq = m.student_seq;


select
    *
from tblSemester s 
        inner join tblResult r on (s.student_seq = r.student_seq) and (s.subject_seq = r.subject_seq);


select
    st.name as "학생명",
    sb.name as "과목명",
    r.score as "점수"
from tblSemester s 
        inner join tblResult r on s.student_seq = r.student_seq and s.subject_seq = r.subject_seq 
        inner join tblStudent st on st.seq = s.student_seq 
        inner join tblSubject sb on sb.seq = s.subject_seq;


