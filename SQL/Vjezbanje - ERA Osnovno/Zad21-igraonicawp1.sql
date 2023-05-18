use master;
drop database if exists igraonicawp1;
go 
create database igraonicawp1;
go
use igraonicawp1;

create table igraonica(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	skupina int not null
);

create table skupina(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	djeca int not null
);

create table djeca(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	skupina int not null
);

create table teta(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	skupina int not null
);