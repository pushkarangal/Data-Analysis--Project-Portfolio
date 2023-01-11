use project1;
# create employee table
create table employee (empno int primary key, ename varchar(40), job varchar(40), mgr int, hiredate date, sal int, comm int, deptno int, foreign key(deptno) references dept(deptno));
describe table employee;

# create dept table
create table dept (deptno int primary key, dname varchar(40), loc varchar(40));
select * from employee;
select count(empno) from employee;
select * from dept limit 10;
# 3. List the Names and salary of the employee whose salary is greater than 1000
select ename, sal from employee where sal>1000;

# 4.List the details of the employees who have joined before end of September 81.

select * from employee where hiredate<"1981-09-30";

# 5.List Employee Names having I as second character.

select ename from employee where ename like "_i%";

#6.List Employee Name, Salary, Allowances (40% of Sal), P.F. (10 % of Sal) and Net Salary. Also assign the alias name for the columns

select ename, sal, 0.4* (sal) as "Allowances", 0.1* (sal) as "P.F.", ((sal+ (0.4*sal))-(0.1* sal)) as "Net Salary" from employee;

#7.List Employee Names with designations who does not report to anybody

select ename, job from employee where mgr is null;

#8.List Empno, Ename and Salary in the ascending order of salary.

select empno, ename, sal from employee order by sal asc;

#9.How many jobs are available in the Organization ?

select  count(distinct(job)) from employee;

#10.Determine total payable salary of salesman category

select sum(sal) from employee where job="SALESMAN";

#11.	List average monthly salary for each job within each department  
 select deptno, avg(sal) from employee group by deptno;
 
#12.Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working.

select emp.ename, emp.sal,dep.deptno, dep.dname from employee as emp left join dept as dep on emp.deptno= dep.deptno;

#13.Create the Job Grades Table as below
create table Grades ( grade varchar(5), lowest_sal int, highest_sal int);
insert into grades values("A", 0,999),("B", 1000,1999),("C", 2000,2999),("D", 3000,3999),("E", 4000,5000);
select * from grades;

#14.Display the last name, salary and  Corresponding Grade.
select ename, sal,
CASE
WHEN sal> 0 and sal<=999 then "A"
WHEN sal>=1000 and sal<=1999 then "B"
when sal>=2000 and sal<= 2999 then "C"
when sal>=3000 and sal<=3999 then "D"
else "E"
end as grade
from employee;

#15.Display the Emp name and the Manager name under whom the Employee works in the below format .
#Emp Report to Mgr.

select emp.empno, emp.ename, mgr.ename as "manager" from employee as emp inner join employee as mgr on emp.mgr=mgr.empno;

#16.Display Empname and Total sal where Total Sal (sal + Comm)

select empno, ename,
case
when comm is null then sal
else sal+ comm
end as "Total Salary"
from employee;

#17.Display Empname and Sal whose empno is a odd number

select empno,ename , sal from employee where mod(empno,2)!=0;

#18.Display Empname , Rank of sal in Organisation , Rank of Sal in their department

select ename,deptno, dense_rank()over(order by sal desc) Rank_Sal, dense_rank() over(partition by deptno order by sal desc) Rank_dept from employee;

#19.Display Top 3 Empnames based on their Salary

With rank_sal as (select ename,sal, dense_rank()over(order by sal desc) Rank_Sal from employee)
select ename,sal from rank_sal where Rank_Sal<=3;

#20. Display Empname who has highest Salary in Each Department.
select * from employee as E inner join (select deptno, max(sal) as "SAL" from employee group by deptno) as D on
E.deptno=D.deptno and E.sal=D.SAL;

