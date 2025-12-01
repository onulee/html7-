select * from (
select rownum rnum, a.* from (select * from member order by id asc ) a
)
where rnum>=11 and rnum<=20
;

-- select * from 테이블명
-- select * from (select조건문)

-- 1. employees테이블에서 이름에 a가 들어가 있는 사람을 출력하시오.
select * from employees where emp_name like '%a%'
;

-- 2. 그 가운데, 월급 7000달러 이상인 사람을 출력하시오.
select * from (select * from employees where emp_name like '%a%')
where salary>=7000;

select * from (select * from (select * from employees where emp_name like '%a%')
where salary>=7000    )
where hire_date>='2004/01/01';

select * from employees
where emp_name like '%a%' and salary >=7000;


select * from (
select row_number() over(order by id asc) rnum,a.* from member a
)
where rnum>=11 and rnum <=20
;



select rownum,a.* from member a
order by id asc;

select rownum,a.* from
(select * from member) a
;



-- 정렬이 없는 경우
select rownum,a.* from member a

;

--- 정렬이 있는 경우
select row_number() over(order by id asc) ,a.* from member a;


---------------------------------------
-- rank() over(), dense_rank() over()
select rank() over(order by total desc),dense_rank() over(order by total desc)
name,total from stuscore;

select rank() over(order by name asc) ranks,name,avg from stuscore;


----------------------------------------
select * from stuscore;

alter table stuscore add rank number(3) default '0';

select rank() over(order by total desc) ranks,sno,name,total,rank from stuscore;
select rank() over(order by total desc) ranks from stuscore;

select sno from stuscore;
select sno,rank() over(order by total desc) ranks from stuscore;

-- rank수정하는 update 명령어
update stuscore a set rank = 
(
select ranks from(
select sno,rank() over(order by total desc) ranks from stuscore
) b
where a.sno=b.sno
)
;

select * from stuscore3;

create table stuscore3 as select * from stuscore;

update stuscore3 set rank = 0;

commit;

alter table stuscore3 add grade nchar(1) default 'D';

select * from stuscore3;

-- non equi 조인으로 
-- stuscore3, scoregrade
-- avg 90-100 A, 80-89.9999 B, C,D,F  grade테이블에 수정해서 값을 입력하시오.
select * from scoregrade;
select * from stuscore3;

commit;

update stuscore3 a set a.grade = (
select gd from (
select b.grade gd,a.sno sno from stuscore3 a,scoregrade b
where avg between lowgrade and highgrade
) c 
where a.sno=c.sno
);




update stuscore3 set grade = (
select grade from scoregrade 
where avg between lowgrade and highgrade
);

commit;



-- avg기준으로 순위를 ranks컬럼에 출력, 입력하시오. -> rank() over() 
select * from stuscore3;
select rank() over(order by total desc) ranks,total,avg from stuscore3;

update stuscore3 a set rank = (
select ranks from (
select sno,rank() over(order by total desc) ranks from stuscore3) b 
where a.sno = b.sno
);

select sno,rank,rank() over(order by total desc) ranks from stuscore3;
commit;








