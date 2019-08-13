create database HCNResortManagement
go 
	
use HCNResortManagement
 go 
 


create table Department
(
	DEPID varchar(6) primary key ,
	DepName varchar(50) not null
)
go 

 create table Position
 (
	POSID varchar(6) primary key,
	DEPID varchar(6) not null,
	PosName Varchar(50),
	foreign key (DEPID) references dbo.Department (DEPID)
 )
 go
 
 create table RoleUser
 (
	ROLEID varchar (6) primary key,
	type varchar(50) not null
 )
 go


 Create table Employee
 (
	EMPID varchar(6) primary key,
	EmpName varchar(50) not null,
	Address varchar(100) not null, 
	Gender bit not null,
	Email varchar(50) not null,
	Phone varchar(20) not null,
	DEPID varchar(6) not null,
	POSID  varchar(6) not null,
	UserName varchar (50),
	Password varchar(50),
	ROLEID varchar(6),
	Active bit,
	foreign key (DEPID) references dbo.Department (DEPID),
	foreign key (POSID) references dbo.Position (POSID),
	foreign key (ROLEID) references dbo.RoleUser (ROLEID)
 ) 
 go
	
 Create table Guest
 (
	PASSPORT varchar(20) primary key,
	GuestName varchar(50) not null,
	Email varchar(50) not null,
	Phone varchar(20) not null,
	Gender bit not null
)
go

Create table Room
(
	ROOMID varchar(4) primary key ,
	RoomType varchar(50) not null,
	RoomStatus bit not null,
	Active bit not null,
	RoomPrice int not null
)
go 

Create table Service
(
	SERID varchar(6) primary key,
	SerName varchar(100) not null,
	SerPrice int not null,
	Active bit not null
)
go

Create table Reservation 
(
	RESID varchar(6) primary key,
	ROOMID varchar(4) not null,
	PASSPORT varchar(20) not null,
	BookDate date not null,
	DateOut date not null,
	EMPID varchar(6) not null,
	DateUse int not null,
	ResPrice int not null,
	foreign key (ROOMID) references dbo.Room (ROOMID),
	foreign key (EMPID) references dbo.Employee (EMPID),
	foreign key (PASSPORT) references dbo.Guest (PASSPORT)
)
go


create table Bill
(
	BILLID int identity primary key,
	RESID varchar(6),
	BookDate date not null,
	TotalPrice int not null,
	foreign key (RESID) references dbo.Reservation (RESID)
)
go

Create table ServiceBillDetail 
(	
	BILLID int identity primary key,
	RESID varchar (6) not null,
	SERID varchar(6),
	BookDate date not null,
	Quantity int not null default 1,
	SerPrice int not null,
	
	foreign key (RESID) references dbo.Reservation (RESID),
	foreign key (SERID) references dbo.Service (SERID)
)
go


insert into dbo.Department 
values('DEP001', 'Reception'),
	('DEP002','Housekeeping')
go

insert into dbo.Position
values('POS001','DEP001','Employee'),
		('POS002','DEP002','Employee')
go

insert into dbo.RoleUser
values('ROL001','Admin'),
	('ROL002','Employee')
go

insert into dbo.Employee
values('EMP001', 'HCN Resort Management', 'Viet Nam', 1, 'abc@gmal.com', '00000000', 'DEP001', 'POS001', 'admin', 'admin','ROL001', 1)
go

insert into dbo.Guest
values ('P132213', 'Guest name', 'xyz@gmail.com', '12321312', 1)
go

insert into dbo.Service
values('SER001', 'DinnerVip', 2000, 1)
go

insert into dbo.Room
values('A001', 'Single room',0,1,'2000'),
	('B002', 'Double room',0,1,'3000'),
	('H001', 'VIP room',0,1,'10000')
	go

insert into Reservation 
values ('Res002','H001','P132213','2019/06/10', '2019/06/15','EMP001',DATEDIFF(day, '2019/06/10', '2019/06/15'),5000)
select RESID,ROOMID,r.PASSPORT,BookDate,DateOut, GuestName,EMPID,ResPrice from Reservation as r
join guest as g
on r.PASSPORT = g.PASSPORT
select *from Reservation as r
join guest as g
on r.PASSPORT = g.PASSPORT
SELECT DATEDIFF(day, '2019/06/10', '2019/06/15')
insert into ServiceBillDetail(RESID, SERID,BookDate,Quantity,SerPrice)
 values ('Res001','SER001','12-06-2019',2,2000)
 select * from Bill where BookDate>= '2019/06 /21' AND BookDate <= DATEADD(day,1,'2019/06 /20')
 select * from Bill where CAST(BookDate as Date) <='2019/06 /21'
 Create table Product
 (
	ProID varchar not null primary key,
	ProName varchar(50) not null,
	Active bit not null
 )
 Create table ServiceDetail
(	
	ID int identity primary key,
	ProID varchar (6) not null,
	SERID varchar(6) not null,
	Quantity int not null default 1,
	foreign key (ProID) references dbo.Reservation (RESID),
	foreign key (SERID) references dbo.Service (SERID)
)
insert into Product values('pro001','coca',0)