
-- ovo je komentar i neće se izvesti
use master;
drop database if exists edunovawp1;
go
create database edunovawp1;
go
use edunovawp1;

create table smjer(
	naziv varchar(50),
	trajanje int,
	cijena decimal(18,2),
	upisnina decimal(18,2),
	verificiran bit
);

create table polaznik(
	ime varchar(50),
	prezime varchar(50),
	oib char(11),
	email varchar(100)
);

create table grupa(
	naziv varchar(50),
	smjer varchar(50), -- krivo
	datumpocetka datetime
);

--create database tomislav;

--drop database tomislav;

--drop database edunovawp1;