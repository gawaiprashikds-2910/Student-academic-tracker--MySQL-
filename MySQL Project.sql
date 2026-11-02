CREATE DATABASE Student_Academic_Tracker;
USE Student_Academic_Tracker;

										-- Table of Student --
CREATE TABLE Student(
stu_id INT PRIMARY KEY,
first_name VARCHAR (20),
Last_name VARCHAR (20),
age INT,
DOB DATE
);

DESCRIBE Student;

INSERT INTO Student (stu_id,first_name,Last_name,age,DOB) 
VALUES (1,'PRASHIK','GAWAI',24,'2002-10-29'),
	   (2,'AKASH','GAWANDE',25,'2001-12-13'),
       (3,'PRACHI','WANKHADE',26,'2000-05-27'),
       (4,'RAJ','PATIL',27,'1999-10-05'),
       (5,'PRASHANT','SHIRSAT',20,'2006-07-18');
       
SELECT * FROM Student;          

									-- Table of Teacher --
CREATE TABLE Teacher(
teacher_id INT PRIMARY KEY,
name VARCHAR (25),
email VARCHAR (30) UNIQUE,
salary INT);

DESCRIBE Teacher;

INSERT INTO Teacher (teacher_id,name,email,salary)
		VALUES (101,'PRIYA','priya@gmail.com',25000),
				(102,'RAHUL','rahul@gmail.com',27000),
                (103,'PANKAJ','pankaj@gmail.com',29000),
                (104,'ASHITOSH','ashitosh@gmail.com',26000),
                (105,'SHAKSHI','shakshi@gmail.com',30000);
                
SELECT * FROM Teacher;    


										-- Table of Library --
CREATE TABLE Library (
Lab_id INT PRIMARY KEY,
stu_id int,
books varchar (30),
book_issue DATETIME,
book_return DATETIME,
FOREIGN KEY (stu_id) REFERENCES Student (stu_id)
);

DESCRIBE Library;

INSERT INTO Library (Lab_id,stu_id,books,book_issue,book_return)
			VALUES  (301,4,'English','2026-01-20 10:00:00','2026-01-25 11:30:00'),
					(302,3, 'Mathematics','2026-01-22 09:15:00','2026-01-27 10:45:00'),
					(303,1,'Marathi','2026-01-24 12:20:00', NULL),
					(304,2, 'Science','2026-01-28 14:10:00','2026-02-02 09:30:00'),
					(305,5, 'History','2026-02-01 11:00:00', NULL);
                    
SELECT * FROM Library;


										-- Table of Stu_Subject --
CREATE TABLE Stu_Subject(
stu_id INT,
subject VARCHAR (50),
department VARCHAR (25),
FOREIGN KEY (stu_id) REFERENCES Student (stu_id)
);

DESCRIBE Stu_Subject;

INSERT INTO Stu_Subject VALUES
			(1, 'English, Mathematics, Marathi', 'Arts'),
			(2, 'Physics, Chemistry, Mathematics', 'Science'),
			(3, 'English, Accountancy, Statistics', 'Commerce'),
			(4, 'Computer Science, Mathematics', 'Commerce'),
			(5, 'Marathi,Political-Science, Mathematics', 'Arts');

SELECT * FROM Stu_Subject;


									-- Table of Student_Info with JSON --
Create table Student_Info (
stu_id int,
name varchar (30),
profile JSON
);

DESCRIBE Student_Info;

INSERT INTO Student_Info (stu_id, name, profile)
VALUES 
(1, "PRASHIK_GAWAI",
'{
    "phone_no": 9876543210,
    "admission_date": "2024-06-10",
    "status": "Active",
    "email": "prashik@gmail.com"
}'
);

INSERT INTO Student_Info (stu_id, name, profile)
VALUES 
(2, "AKASH_GAWANDE",
'{
    "phone_no": "9876500001",
    "admission_date": "2024-06-12",
    "status": "Active",
    "email": "akash@gmail.com"
}'
);

INSERT INTO Student_Info (stu_id, name, profile)
VALUES (3, "PRACHI_WANKHADE",
'{
    "phone_no": "9876500002",
    "admission_date": "2024-06-15",
    "status": "Active",
    "email": "prachi@gmail.com"
}'
);

INSERT INTO Student_Info (stu_id, name, profile)
VALUES(4, "RAJ_PATIL",
'{
    "phone_no": "9876500003",
    "admission_date": "2024-06-18",
    "status": "Inactive",
    "email": "raj@gmail.com"
}'
);

INSERT INTO Student_Info (stu_id, name, profile)
VALUES(5, "PRASHANT_SHIRSAT",
'{
    "phone_no": "9876500004",
    "admission_date": "2024-06-20",
    "status": "Active",
    "email": "prashant@gmail.com"
}'
);

SELECT * FROM Student_Info;

---------------------------------------------------------------------------------------------------------

-- Question Queries

-- Q1. Show teachers with salary above 26000 ?
SELECT name, salary FROM teacher WHERE salary >26000;


-- Q2. Show the student who's age is above 25 and name start with letter "R" ?
SELECT * FROM Student where age > 25 
				and first_name like 'R%';
                
                
-- Q3. which students borrow the book from the library and did not return ?
select s.first_name,s.Last_name, l.books, l.book_return
	from Student s join Library l on s.stu_id= l.stu_id 
    where l.book_return is null;


-- Q4. Join the two table which is the showing stu.subject and student with left join ?
select * from Student 
	as s left join Stu_Subject as s_s 
		on s.stu_id = s_s.stu_id;


-- Q5. Show the teacher name in Ascending/Decending order ?
select * from Teacher order by name asc;
select * from Teacher order by name desc;


-- Q6. Show the name with the help of "like Command"
select * from Student 
		where first_name like 'A%'
				and Last_name like '%E';


-- Q7. Apply Compound Condition on  tables
select * from Student where age >= 25 and DOB >= '2001-12-13';
select * from Teacher where salary > 20000;


-- Q8. Use the Aggrigate function on tables
select  avg(age) from Student; -- avg.age - 24.40


select first_name, min(age) from student 
group by first_name limit 1;  -- prashik 24 is min age


select count(*) from Student; -- 5 students in the table


select first_name,Last_name,max(age) from Student
	group by first_name ,Last_name limit 1;


select sum(salary) from Teacher;  -- 137000


select name,min(salary) from Teacher group by name limit 1; -- min.salary 25000 


-- Q9. We want to teacher name in small letter what is the command?
select lower(name) as name from Teacher;


-- Q10. Use the subquery for find the value of min salary of the teacher?
select Min(salary) from Teacher;  -- 25000

select name ,salary from Teacher where salary=25000;

select name ,salary from Teacher where salary=
					(select Min(salary) from Teacher);


-- Q11. Show the teacher name of "Ashitosh" with the help of Index concept
create index idx_name_email on Teacher (name,email);

select * from Teacher where name= 'ASHITOSH' AND 
							email='ashitosh@gmail.com';


-- Stored Procedures in Student Table
call info_Student;
call info_Student(26);

call info_Student(@record);
select @record as total_Student;


call info_teacher;
call info_teacher(25000);

call info_teacher(@record);
select @record as total_Teacher;


-- View concept
create view view_teacher as
select * from Teacher;

select * from view_teacher;


create view salary_view as 
select * from Teacher where salary >=27000;

select * from salary_view;


-- Trigger on Teacher table
create table Teacher_backup(
teacher_id INT,
name VARCHAR (25),
email VARCHAR (30),
salary INT);

delimiter // 
create trigger t1
before delete on Teacher
for each row
begin
insert into Teacher_backup values(OLD.teacher_id,OLD.name,OLD.email,OLD.salary);

end;
//
delimiter ;

show triggers;
delete from Teacher where teacher_id=105;
select * from Stu_backup;


insert into Teacher values(106,'RADHA','radha@gmail.com',-22000);

delimiter //
create trigger t2
before insert on Teacher
for each row
Begin
		if NEW.salary <0 then
        set NEW.salary = 0;
        end if;
        end;
        //
        delimiter ;
			
show triggers;        
select * from Teacher;    
insert into Teacher values(107,'KAJAL','kajal@gmail.com',-22300);


-- JSON CONCEPT
SELECT name,
profile-> '$.email' as email from student_info;


select name,
profile-> '$.email' as email from student_info 
	where name like 'P%E';
    
    begin;
UPDATE Teacher set salary=salary-1000 where  teacher_id =103; 
commit;

update Teacher set salary= salary-5000 where teacher_id = 102;
commit;



begin;
update Teacher set salary = salary- 3000 where 
	teacher_id = 103;
    rollback;


select * from student;
select * from teacher;
select * from stu_subject;
select * from library;
select * from student_info;
