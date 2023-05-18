use master;
drop database if exists nakladnikwp1;
go 
create database nakladnikwp1;
go
use nakladnikwp1;

create table nakladnik(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	djela int not null,
	mjesto int not null
);

create table djela(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	nakladnik int not null
);

create table mjesto(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	nakladnik int not null
);