-- 데이터:자료집합,  정보: 유용한 자료
-- 무결성 제약조건 : 데이터 입력시 잘못된 데이터의 입력을 제약
-- primary key, foreign key, not null, unique, check
-- 테이블 생성시 primary key 등록방법
create table mem3(
 id varchar2(100) primary key,
 pw varchar2(100)
);

-- primary key 수정
-- constraint 별칭
alter table mem2 add constraint pk_mem2_id primary key(id);


-- 테이블 생성 foreign key 등록
-- 다른테이블의 primary key로 등록이 되어야 foreign key로 등록가능
create table board4 (
bno number(4) primary key,
btitle varchar2(1000) not null,
bcontent clob,
id varchar2(100),
constraint fk_board4_mem2_id foreign key(id) references mem2(id)
);

drop table board4;

-- foreign key 수정
create table board3 as select * from board;

alter table mem2 add constraint pk_mem2_id primary key(id);

alter table board3 
add constraint fk_board3_mem2_id foreign key(id) references mem2(id);

-- foreign key 삭제
alter table board3 drop constraint fk_board3_mem2_id;


-- 부모키 삭제시 foreign key키 등록된 데이터 모두삭제
alter table board3 drop constraint fk_board3_mem2_id;

alter table board3 
add constraint fk_board3_mem2_id foreign key(id) references mem2(id)
on delete cascade
;
-- 부모키 삭제시 foreign key키 등록된 id null처리
alter table board3 
add constraint fk_board3_mem2_id foreign key(id) references mem2(id)
on delete set null
;
-- decode 조건 같은경우만 실행
select sno,name,
decode(sno,10,'반장',
           20,'부반장',
           30,'총무',
           40,'총무2') as leader2 from stuscore2;

-- case when 비교연산자를 사용가능
select sno,name,
case when sno<=10 then '반장'
when sno>=20 then '부반장'
when sno>=30 then '총무'
end as leader2
from stuscore2;

-----------------------------------------------------------------------------

insert into board3 values(
board_seq.nextval,'제목입니다.3','내용입니다.3','abc',board_seq.currval,0,0,0,'1.jpg',sysdate
);

------------------------------------------
-- 부모키 삭제시 foreign key키 등록된 데이터 모두삭제
alter table board3 drop constraint fk_board3_mem2_id;

alter table board3 
add constraint fk_board3_mem2_id foreign key(id) references mem2(id)
on delete cascade
;
-- 부모키 삭제시 foreign key키 등록된 id null처리
alter table board3 
add constraint fk_board3_mem2_id foreign key(id) references mem2(id)
on delete set null
;

delete mem2 where id='ccc';

select * from board3;

select * from mem2 where id='aaa';

delete mem2 where id='aaa';

select * from board3 where id='aaa'
;

delete board3 where id='aaa';

drop table mem3;
drop table mem2;
drop table board3;
drop table board2;

drop table mem;

create table mem(
id varchar2(100) primary key,
pw varchar2(100) not null,
name varchar2(100) unique, -- 중복불가,null허용
phone char(13) default '010-0000-0000',
gender nvarchar2(2) check(gender in('남자','여자')),
hobby varchar2(100) default '게임',
age number(3) check (age between 0 and 120)
);

insert into mem(id,pw,gender) values ('aaa','1111','남자');

select * from mem;

select sno,
case when sno between 1 and 10 then '1반'
when sno between 11 and 20 then '2반'
when sno between 21 and 30 then '3반'
when sno between 31 and 40 then '4반'
when sno between 41 and 50 then '5반'
when sno between 51 and 60 then '6반'
when sno between 61 and 70 then '7반'
when sno between 71 and 80 then '8반'
when sno between 81 and 90 then '9반'
when sno between 91 and 100 then '10반'
else '기타'
end as class
from stuscore2;



------------------------------------------------------------

drop table stu;

create table stuscore2 as select * from stuscore;


select * from stuscore2;

---------------------------------
-- 논리 / 조건
select * from stuscore2;

alter table stuscore2 add leader nvarchar2(2);

update stuscore2 set leader='반장' where name='유관순';

-- decode 조건 같은경우만 실행
select sno,name,
decode(sno,10,'반장',
           20,'부반장',
           30,'총무',
           40,'총무2') as leader2 from stuscore2;

-- case when 비교연산자를 사용가능
select sno,name,
case when sno<=10 then '반장'
when sno>=20 then '부반장'
when sno>=30 then '총무'
end as leader2
from stuscore2;

-- avg컬럼을 가지고, rank별칭을 사용해서 90이상 A,80점이상 B,C,D,F
select sno,name,avg,
case when avg>=90 then 'A'
when avg>=80 then 'B'
when avg>=70 then 'C'
when avg>=60 then 'D'
else 'F'
end as rank
from stuscore2;

select * from stuscore2;

alter table stuscore2 add event date;
alter table stuscore2 add rank nvarchar2(1);

select sdate,last_day(sdate),trunc(sdate,'month') from stuscore;

select sdate,event,last_day(sdate) from stuscore2;


update stuscore2 set event=last_day(sdate);

update stuscore2 set event = sysdate;

select * from stuscore2;

update stuscore2 set rank = (
case when avg>=90 then 'A'
when avg>=80 then 'B'
when avg>=70 then 'C'
when avg>=60 then 'D'
else 'F'
end 
);

select rank,
case when avg>=90 then 'A'
when avg>=80 then 'B'
when avg>=70 then 'C'
when avg>=60 then 'D'
else 'F'
end 
from stuscore2;


select * from stuscore2;


alter table stuscore2 modify sdate invisible;
alter table stuscore2 modify leader invisible;
alter table stuscore2 modify event invisible;

alter table stuscore2 modify sdate visible;
alter table stuscore2 modify event visible;
alter table stuscore2 modify leader visible;

select * from stuscore2 
order by sno;

-- 'class'컬럼을 1개 추가
-- 1~10까지 1반, 2반,3반......10반,기타 컬럼에 추가하시오.
select sno,
case when sno between 1 and 10 then '1반'
when sno between 11 and 20 then '2반'
when sno between 21 and 30 then '3반'
when sno between 31 and 40 then '4반'
when sno between 41 and 50 then '5반'
when sno between 51 and 60 then '6반'
when sno between 61 and 70 then '7반'
when sno between 71 and 80 then '8반'
when sno between 81 and 90 then '9반'
when sno between 91 and 100 then '10반'
else '기타'
end as class
from stuscore2;

alter table stuscore2 add class nvarchar2(3);

select sno,class from stuscore2;

update stuscore2 set class = (
case when sno between 1 and 10 then '1반'
when sno between 11 and 20 then '2반'
when sno between 21 and 30 then '3반'
when sno between 31 and 40 then '4반'
when sno between 41 and 50 then '5반'
when sno between 51 and 60 then '6반'
when sno between 61 and 70 then '7반'
when sno between 71 and 80 then '8반'
when sno between 81 and 90 then '9반'
when sno between 91 and 100 then '10반'
else '기타'
end
);

commit;

select sno,name,total from stuscore2;
select * from stuscore2;

select total,rank() over(order by total desc) from stuscore2;

----

-- 그룹함수 max,min,avg,sum,count...
-- to_char(), to_number(), to_date()
select to_char(sum(kor),'9,999'),round(avg(kor),2),max(kor),min(kor),count(kor) from stuscore2;
select avg(kor) from stuscore2;
select max(kor),min(kor) from stuscore2;
select count(kor) from stuscore2;

select name,max(kor) from stuscore2; -- 단일컬럼과 그룹컬럼을 함께 사용할수 없음

-- group by 단일컬럼
-- max(kor) 이름을 기준으로 최대국어점수를 출력하시오.
select * from stuscore2;

-- 전체평균, 반별 평균
select avg(avg) from stuscore2;

-- 단일컬럼과 그룹컬럼을 함께 사용할수 없음.
select class,avg(avg) from stuscore2;

-- 반별평균 - 52.3333333 보다 낮은 반을 출력하시오.
-- 그룹컬럼의 조건절은 where에서 사용할수 없음.
-- 그룹컬럼의 조건절은 having에 입력해야 함.
select class,avg(avg) from stuscore2
group by class
having avg(avg)<=52.33
;

--- department_id employee테이블
select salary,department_id from employees
order by department_id;

select avg(salary) from employees;

select department_id,sum(salary),avg(salary) from employees
group by department_id
having avg(salary)>=(select avg(salary) from employees)
order by department_id
;


select department_id,sum(salary),avg(salary) from employees
group by department_id
having avg(salary)>=6461
order by department_id
;


select sysdate,add_months(sysdate,6) from dual;

select hire_date,hire_date+100,add_months(hire_date,6) from employees;


select distinct department_id from employees;


select count(*) from employees;
select count(manager_id) from employees;

select * from employees,departments;

-- 조인 : 2개테이블 사용
select count(*) from member,board;

select count(*) from member; -- 100
select count(*) from board;  -- 100

select department_id from employees;

select emp_name,employees.department_id,department_name,parent_id from employees,departments
where employees.department_id = departments.department_id
;

select * from departments;

select department_id,department_name from departments;

-- cross join 100*100 = 10000 
select * from employees,departments;

-- equi join : 동일한 컬럼이 존재할때 
select * from employees,departments
where employees.department_id = departments.department_id;

-- 작성자  board테이블 : id, member테이블 : id,이름,전화번호
-- join을 했을경우, 공통컬럼 외 다른 컬럼의 내용을 바꾸면 변경된 내용을 가지고 옴.
select member.id,name,phone,bno,btitle from member,board
where member.id = board.id
;

-- id,이름,전화번호
select * from member;
select * from board;

update member set name='길동스' where id='aaa';


select * from mem;
drop table mem;

create table mem as select * from member;
select * from member;


delete mem where id not in('aaa','bbb','ccc','ddd','eee','fff','ggg','hhh','iii','jjj','kkk');

select * from mem;

alter table mem add nicname varchar2(100);

select pw,rpad(substr(pw,0,2),4,'*') from mem;
select name,substr(name,0,2)||'즈' from mem;
select name,concat(substr(name,0,2),'즈') from mem;

update mem set nicname = (
concat(substr(name,0,2),'즈')
);

select * from mem;
--- 순서
alter table mem modify phone invisible;
alter table mem modify email invisible;
alter table mem modify gender invisible;
alter table mem modify hobby invisible;

alter table mem modify phone visible;
alter table mem modify email visible;
alter table mem modify gender visible;
alter table mem modify hobby visible;


select bno,btitle,bcontent,id,nicname from board;

select bno,id from board;
select id,pw from mem;

select bno,btitle,bcontent,board.id,nicname from board,mem
where board.id=mem.id;

-- 사원테이블-employees - emp_name,department_id,salary,
-- 부서테이블 departments - department_id,department_name

-- 사원이름,부서번호,부서이름,월급
-- 테이블 별칭 가능
select emp_name,a.department_id,department_name,salary 
from employees a,departments b
where a.department_id = b.department_id;


select a.id,nicname,bno,btitle from mem a,board b
where a.id = b.id and a.id='aaa';



select * from stuscore;

create table scoregrade (
grade char(1),
lowgrade number(7,4),
highgrade number(7,4)
);


insert into scoregrade values('A',90,100);
insert into scoregrade values('B',80,89.9999);
insert into scoregrade values('C',70,79.9999);
insert into scoregrade values('D',60,69.9999);
insert into scoregrade values('F',0,59.9999);
commit;

drop table scoregrade;

-- non equi join : 같은 컬럼이 없고 두 테이블 조인하는 방법
-- scoregrade,stuscore 2개테이블을 조인해서 grade 등급을 입력
-- 같은 컬럼이 존재하지 않음.
select grade,lowgrade,highgrade from scoregrade;
select sno,name,kor,eng,math,total,avg,sdate from stuscore;

-- stuscore avg컬럼을 scoregrade lowgrade,highgrade 범위를 조회해서 grade 추가
select name,avg,grade from stuscore a,scoregrade b
where avg between lowgrade and highgrade
;

-- 월급을 가지고 직급을 추가하려고 합니다.
-- salgrade : grade,lowgrade,highgrade 
-- 20000-50000 대표, 13000 부사장 10000 부장 8000 과장 6000 대리, 그외 사원
-- '대표','부사장','부장','과장','대리','사원'

select emp_name,salary from employees
order by salary desc;

create table salgrade (
grade nvarchar2(3), --'부사장'
lowgrade number(5),
highgrade number(5)
);

insert into salgrade values('대표',20000,50000);
insert into salgrade values('부사장',13000,19999);
insert into salgrade values('부장',10000,12999);
insert into salgrade values('과장',8000,9999);
insert into salgrade values('대리',6000,7999);
insert into salgrade values('사원',0,5999);
commit;

select * from salgrade;

select emp_name,salary,grade from employees,salgrade
where salary between lowgrade and highgrade;

-- case when
select emp_name, salary,
case when salary between 20000 and 50000 then '대표'
when salary between 13000 and 19999 then '부사장'
when salary between 10000 and 12999 then '부장'
when salary between 8000 and 9999 then '과장'
when salary between 6000 and 7999 then '대리'
else '사원'
end as grade
from employees
;

-- stuscore2 테이블 scoregrade테이블 조인해서 grade 학점을 출력하시오.
select * from stuscore2;
select * from scoregrade;

select name,avg,grade from stuscore2,scoregrade
where avg between lowgrade and highgrade
;

-- grade컬럼을 추가해서 조인해서 나온 결과를 입력하시오.
alter table stuscore2 add grade varchar2(1);
select * from stuscore2;

-- grade컬럼: non equi join update방법
update stuscore2 set grade = (
select grade from scoregrade
where avg between lowgrade and highgrade
);

select name,avg,grade from stuscore2;


--[ 조인 ]
-- cross join : equi join-같은컬럼 있는 경우,non equi join-같은컬럼이 없는 경우
-- self join : 같은 테이블 2개 사용할때

-- manager_id : 사원중에 자신의 상사의 id를 적용
select employee_id,emp_name,manager_id,emp_name from employees;

select a.employee_id,a.emp_name,a.manager_id,b.emp_name from employees a,employees b
where a.manager_id = b.employee_id
;

select count(*) from employees;

-- outer join : 해당컬럼에 null값이 있어도 출력시켜줌.
-- manager_id에 null값이 존재 그 반대편에 (+)를 넣어줌. 
select a.employee_id,a.emp_name,a.manager_id,b.emp_name from employees a,employees b
where a.manager_id = b.employee_id(+)
;

select manager_id from employees
where manager_id is null;

-- count : null값은 카운터 하지 않음.
select count(manager_id) from employees;

--- employees,departments 테이블을 이용해서
--- 사원명,부서번호,부서명을 출력하시오.
select emp_name,a.department_id,department_name
from employees a,departments b
where a.department_id(+) = b.department_id
;

select distinct department_id from employees
order by department_id;

select distinct department_id from departments
order by department_id;

-----------------------------------------------------------
-- ansi join 
-- equi join
select emp_name,a.department_id,department_name
from employees a,departments b
where a.department_id = b.department_id
;

-- ansi equi join
select emp_name,department_id,department_name
from employees inner join departments
using (department_id)
;

--- out join
-- employees department_id에 null 있는 경우 반대편에 (+)를 입력해야 함.
select emp_name,a.department_id,department_name
from employees a,departments b
where a.department_id(+) = b.department_id(+)
;

-- ansi outer join : left outer join, right outer join, full outer join
select emp_name,department_id,department_name
from employees left outer join departments 
using(department_id);


-------------------------------------------------------
-- rownum 순번 출력하는 방법
select * from member;
select rownum,a.* from member a;

select rownum,a.* from employees a;

create table board2 as select * from board;

--- bno 1번부터 10번까지 출력하시오.
select * from board2
where bno>=1 and bno<=10
order by bno;

select rownum,a.* from board2 a
where rownum between 11 and 20
;

-- rownum 함수
select * from 
( select rownum rnum,a.* from (select * from board2 order by bno asc) a
) where rnum between 11 and 20
;

-- row_number()
select * from 
( select row_number() over(order by bno asc) rnum,a.* from board2 a )
where rnum between 11 and 20
;


select rownum,a.* from stuscore a;
select rownum,a.* from member a;

select row_number() over(order by id) rnum,a.* from member a;








delete board2 where bno = 4;
delete board2 where bno = 7;
delete board2 where bno = 11;
delete board2 where bno = 12;
delete board2 where bno = 15;
delete board2 where bno = 22;
delete board2 where bno = 25;
delete board2 where bno = 29;
commit;














