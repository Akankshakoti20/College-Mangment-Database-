drop table iamarks;
drop table subject;
drop table class;
drop table semsec;
drop table student;
create table student
(
	usn varchar(10),
	sname varchar(10),
	address varchar(10),
	phone varchar(10),
	gender varchar(1),
	primary key(usn)
);
create table semsec
(
	ssid varchar(6),
	sem int,
	sec varchar(2),
	primary key(ssid)
);
create table class
(
	usn varchar(10),
	ssid varchar(6),
	primary key(usn,ssid),
	foreign key(usn) references student(usn),
	foreign key(ssid) references semsec(ssid)
);
create table subject
(
	subcode varchar(7),
	title varchar(20),
	sem int,
	credits int,
	primary key(subcode)
);
create table iamarks
(
	usn varchar(10),
	subcode varchar(7),
	ssid varchar(6),
	test1 int,
	test2 int,
	test3 int,
	finalia int,
	primary key(usn,subcode,ssid),
	foreign key(usn) references student(usn),
	foreign key(ssid) references semsec(ssid),
	foreign key(subcode) references subject(subcode)
);
desc student;
desc semsec;
desc class;
desc subject;
desc iamarks;
insert into student values('4all4is001','suresh','mangaluru',8877881122,'m');
insert into student values('4all4is002','sandhya','bengaluru',7722829912,'f');
insert into student values('4all4is003','trisha','bengaluru',7712312312,'f');
insert into student values('4all4is004','supriya','mangaluru',8877881122,'f');
insert into student values('4all4is010','abhay','bengaluru',9900211201,'m');
insert into student values('4all4is011','darshan','bengaluru',9923211099,'m');
insert into student values('4all4is012','ashwitha','bengaluru',7894737377,'f');
insert into student values('4all4is020','ajay','tumkur',9845091341,'m');
insert into student values('4all4is021','sanjana','kundapura',7696772121,'f');
insert into student values('4all4is022','krishna','bellary',9944850121,'m');
insert into student values('4all4is023','santhosh','mangaluru',9912332201,'m');
insert into student values('4all4is040','lokesh','kalburgi',9900232201,'m');
insert into student values('4all4is041','ashika','shimoga',9905542212,'f');
insert into student values('4all4is042','vinayaka','bijapura',8800880011,'m');

insert into semsec values('cse8a',8,'a');
insert into semsec values('cse8b',8,'b');
insert into semsec values('cse8c',8,'c');
insert into semsec values('cse6a',6,'a');
insert into semsec values('cse4a',4,'a');
insert into semsec values('cse4b',4,'b');
insert into semsec values('cse4c',4,'c');
insert into semsec values('cse2a',2,'a');


insert into class values('4all4is001','cse8a');
insert into class values('4all4is002','cse8a');
insert into class values('4all4is003','cse8b');
insert into class values('4all4is004','cse8c');
insert into class values('4all4is010','cse6a');
insert into class values('4all4is011','cse6a');
insert into class values('4all4is012','cse6a');
insert into class values('4all4is020','cse4a');
insert into class values('4all4is021','cse4b');
insert into class values('4all4is022','cse4c');
insert into class values('4all4is023','cse4c');
insert into class values('4all4is040','cse2a');
insert into class values('4all4is041','cse2a');
insert into class values('4all4is042','cse2a');

insert into subject values('10is81','PW',8,4);
insert into subject values('10is82','INS',8,4);
insert into subject values('10is88','PWL',8,2);
insert into subject values('15is61','CN',6,4);
insert into subject values('15is62','DBMS',6,4);
insert into subject values('15is41','DMS',4,4);
insert into subject values('15is42','ADE',4,4);
insert into subject values('15che21','Chemistry',2,4);
insert into subject values('15pcd22','PCD',2,4);

insert into iamarks(usn,subcode,ssid,test1,test2,test3)values('4all4is001','10is81','cse8a',15,16,18);
insert into iamarks(usn,subcode,ssid,test1,test2,test3)values('4all4is001','10is82','cse8a',10,9,6);
insert into iamarks(usn,subcode,ssid,test1,test2,test3)values('4all4is003','10is88','cse8b',15,5,9);
insert into iamarks(usn,subcode,ssid,test1,test2,test3)values('4all4is004','10is82','cse8c',20,15,17);
insert into iamarks(usn,subcode,ssid,test1,test2,test3)values('4all4is011','15is62','cse6a',17,10,10);
insert into iamarks(usn,subcode,ssid,test1,test2,test3)values('4all4is022','15is41','cse4c',10,9,6);
insert into iamarks(usn,subcode,ssid,test1,test2,test3)values('4all4is023','15is42','cse4c',12,11,13);
insert into iamarks(usn,subcode,ssid,test1,test2,test3)values('4all4is042','15pcd22','cse2a',9,14,13);

select * from student;
select * from semsec;
select * from subject;
select * from class;
select * from iamarks;

--Query1
select s.*, ss.sem, ss.sec
from student s, semsec ss, class c
where s.usn = c.usn and ss.ssid = c.ssid
and ss.sem = 4 and ss.sec = 'c';

--Query2
select ss.sem, ss.sec, s.gender, count(s.gender) as count
from student s, semsec ss, class c
where s.usn = c.usn and ss.ssid = c.ssid
group by ss.sem, ss.sec, s.gender
order by sem;

--Query3
create view test1_view as 
select test1,subcode
from iamarks
where usn='4all4is001';
select * from test1_view;

--Query4
create or replace procedure avgmarks is 
cursor c_iamarks is 
select greatest(test1,test2) as a, greatest(test1,test3) as b, greatest(test3,test2) as c 
from iamarks
where finalia is null for update;

c_a number;
c_b number;
c_c number;
c_sm number;
c_av number;

begin
open c_iamarks;
loop 
fetch c_iamarks into c_a,c_b,c_c;
	exit when c_iamarks%notfound;
if(c_a!=c_b)then
	c_sm:=c_a+c_b;
else
	c_sm:=c_a+c_c;
end if;

c_av:=c_sm/2;

update iamarks set finalia = c_av where current of c_iamarks;

end loop;
close c_iamarks;
end;
/

begin
avgmarks;
end;
/
select * from iamarks;

--Query5
select s.usn,s.sname,s.address,s.phone,s.gender,
(case
when ia.finalia between 17 and 20 then 'outstanding'
when ia.finalia between 12 and 16 then 'average'
else 'weak'
end)as cat
from student s, semsec ss, iamarks ia, subject sub
where s.usn = ia.usn
and ss.ssid = ia.ssid
and sub.subcode = ia.subcode
and sub.sem = 8;
*/

