use master;
drop database if exists vodoinstalaterwp1;
go 
create database vodoinstalaterwp1;
go
use vodoinstalaterwp1;

create table vodoinstalaer(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	popravak int not null,
	segrt int not null
);

create table popravak(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	kvar int not null
);

create table kvar(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	popravak int not null
);

create table segrt(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null
);