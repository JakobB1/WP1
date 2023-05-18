use master;
drop database if exists kudwp1;
go 
create database kudwp1;
go
use kudwp1;

create table kud(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	nastup int not null
);

create table nastup(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	clan int not null,
	mjesto int not null
);

create table clan(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	nastup int not null
);

create table mjesto(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null
);