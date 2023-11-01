drop database if exists `quanlysinhvien`;
create database quanlysinhvien;
use quanlysinhvien;
create table Class(
ClassID int primary key auto_increment not null,
ClassName varchar(60) not null,
StartDate datetime not null,
`Status` bit(1)
);
create table Student (
StudentID int primary key auto_increment not null,
StudentName varchar(30),
Address varchar(50),
Phone varchar(20),
`Status` bit(1),
ClassID int not null,
foreign key (ClassID) references Class(ClassID)
);
create table Subject (
SubID int primary key auto_increment not null,
SubName varchar(30) not null,
Credit tinyint default 1,
check(credit > 0),
`Status` bit(1) default 1
);
create table Mark (
MarkID int primary key auto_increment not null,
SubID int unique key not null,
StudentID int unique key not null,
Mark float default 0,
check(Mark >= 0 and Mark <= 100),
ExamTimes tinyint default 1
);
-- TH01 - thêm dữ liệu vào trong bảng
insert into Class(ClassID, ClassName, StartDate, `Status`) values
(1, 'A1', '2008/12/20', b'1'),
(2, 'A2', '2008/12/22', b'1'),
(3, 'B3', current_date(), b'0');
insert into Student(StudentID, StudentName, Address, Phone, `Status`, ClassID) values
(1, 'Hung', 'Ha noi', '0912113113', 1, 1),
(2, 'Hoa', 'Hai phong', '', 1, 1),
(3, 'Manh', 'HCM', '0123123123', 0, 2);
insert into Subject(SubID, SubName, Credit, `Status`) values
(1, 'CF', 5, 1),
(2, 'C', 6, 1),
(3, 'HDJ', 5, 1),
(4, 'RDBMS', 10, 1);
insert into Mark(MarkID, SubID, StudentID, Mark, ExamTimes) values
(1, 1, 1, 8, 1),
(2, 1, 2, 10, 2), -- đặt SubID là unique key mà lại gán dữ liệu trùng lặp vào đây không hiểu để làm gì
(3, 2, 1, 12, 1);
-- TH02
-- Hiển thị danh sách tất cả các học viên
select * from quanlysinhvien.student;
-- Hiển thị danh sách các học viên đang theo học
select * from quanlysinhvien.student where Status = true;
-- Hiển thị danh sách các môn học có thời gian học nhỏ hơn 10 giờ
select * from quanlysinhvien.subject where Credit < 10;
-- Hiển thị danh sách học viên lớp A1
select S.StudentId, S.StudentName, C.ClassName
from Student S join Class C on S.ClassID = C.ClassID
where C.ClassName = 'A1';
-- Hiển thị điểm môn CF của các học viên
select S.StudentID, S.StudentName, Sub.SubName, M.Mark
from Student S join Mark M on S.StudentID = M.StudentID join `Subject` Sub on M.SubID - Sub.SubID
where sub.subname = 'CF';