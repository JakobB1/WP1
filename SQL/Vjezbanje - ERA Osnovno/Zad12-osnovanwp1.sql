use master;
drop database if exists osnovanwp1;
go 
create database osnovanwp1;
go
use osnovanwp1;

create table skola(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	radionice int not null
);

create table radionice(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	djeca int not null
);

create table djeca(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	radionice int not null
);

create table uciteljica(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	oib char(11),
	iban char(21),
	radionice int not null
);