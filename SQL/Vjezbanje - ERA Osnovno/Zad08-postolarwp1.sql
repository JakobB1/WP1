use master;
drop database if exists postolarwp1;
go 
create database postolarwp1;
go
use postolarwp1;

create table postolar(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezima varchar(50) not null,
	segrt int not null
);

create table korisnik(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	obuca int not null
);

create table obuca(
	sifra int not null primary key identity(1,1),
	nazivMarke varchar(50) not null,
	popravak int not null
);

create table popravak(
	sifra int not null primary key identity(1,1),
	datumPopravka datetime not null
);

create table segrt(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	popravak int not null
);