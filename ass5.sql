create database Assign5
use Assign5

create schema bank1;
create table bank1.Customer1
(
	CId int primary key identity(1000,1),
	CName nvarchar(50) not null,
	CEmail nvarchar(50) not null unique,
	Contact nvarchar(50) not null unique,
	CPwd as right(CName,2)+cast(CId as nvarchar(10))+left(Contact,2) persisted 
)
insert into bank1.Customer1(CName,CEmail,Contact) values ('MaryKarl','marykarl@gmail.com','9754268714')
insert into bank1.Customer1(CName,CEmail,Contact) values ('Kembral','kembral@gmail.com','6502384524')
insert into bank1.Customer1(CName,CEmail,Contact) values ('Feni','feni@gmail.com','7546823108')
insert into bank1.Customer1(CName,CEmail,Contact) values ('Aval','aval@gmail.com','7546321875')
insert into bank1.Customer1(CName,CEmail,Contact) values ('Detra','detra@gmail.com','9845023698')

select * from bank1.Customer1

create table bank1.MailInfo
(	
	MailTo nvarchar(50),
	MailDate date,
	MailMessage nvarchar(50)
)
select * from bank1.MailInfo

create trigger InsertIntoCust
on bank1.Customer1
after insert
as
begin
declare @id int
declare @name nvarchar(50)
declare @mail nvarchar(50)
declare @contact nvarchar(50)
declare @pwd nvarchar(50)

declare @msg nvarchar(50)

select @id=Cid,@name=CName,@mail=CEmail,@contact=Contact,@pwd=(right(CName,2)+cast(CId as nvarchar(10))+left(Contact,2)) from inserted
select @msg='your NetBanking password is : '+@pwd+'it is valid up to 2 days only. Update it!!!!!!!'

insert into MailInfo values (@mail,GETDATE(),@msg)

if(@@ROWCOUNT>=1)
begin
print 'After trigger value inserted'
end
end

insert into bank1.Customer1(CName,CEmail,Contact) values ('Elon','Elon@gmail.com','9243615754')
select * from bank1.Customer1
select * from bank1.MailInfo;