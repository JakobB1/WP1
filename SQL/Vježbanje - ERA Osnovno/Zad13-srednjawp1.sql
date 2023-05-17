use master;
drop database if exists srednjawp1;
go 
create database srednjawp1;
go
use srednjawp1;

create table skola(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	razredi int not null
);

create table razredi(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	ucenici int not null,
	profesori int not null
);

create table ucenici(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null
);

create table profesori(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	oib char(11),
	iban char(21),
	razredi int not null
);