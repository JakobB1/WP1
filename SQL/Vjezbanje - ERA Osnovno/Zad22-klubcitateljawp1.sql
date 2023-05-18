use master;
drop database if exists klubcitateljawp1;
go 
create database klubcitateljawp1;
go
use klubcitateljawp1;

create table klub(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	clan int not null
);

create table clan(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	knjiga int not null
);

create table knjiga(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	clan int not null,
	vlasnik int not null
);

create table vlasnik(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	clan int not null
);