create database xyz_company
use xyz_company
--drop table employee

create table employee(
id int Primary key,
name Varchar(50),
salary int
);

Insert into employee
(id,name,salary)
Values
(1,'muskan',20000)

select * from employee;