use master;
drop database if exists opgwp1;
go 
create database opgwp1;
go
use opgwp1;

create table opg(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	proizvodi int not null
);

create table proizvodi(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	sirovine int not null
);

create table sirovine(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	proizvodi int not null
);

create table djelatnik(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	proizvodi int not null
);