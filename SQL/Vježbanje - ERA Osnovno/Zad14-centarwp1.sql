use master;
drop database if exists centarwp1;
go 
create database centarwp1;
go
use centarwp1;

create table centar(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null, 
	trgovine int not null
);

create table trgovine(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	osoba int not null,
	sef int not null
);

create table osoba(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	oib char(11),
	trgovine int not null
);

create table sef(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	oib char(11),
	trgovine int not null,
	osoba int not null
);