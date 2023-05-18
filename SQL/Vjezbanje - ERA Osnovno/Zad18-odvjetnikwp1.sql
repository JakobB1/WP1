use master;
drop database if exists odvjetnikwp1;
go 
create database odvjetnikwp1;
go
use odvjetnikwp1;

create table odvjetnik(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	obrana int not null
);

create table klijent(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null
);

create table obrana(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	klijent int not null,
	suradnici int not null
);

create table suradnici(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	klijent int not null,
	obrana int not null
);