use master;
drop database if exists restoranwp1;
go 
create database restoranwp1;
go
use restoranwp1;

create table restoran(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	kategorije int not null
);

create table kategorije(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	jelo int not null
);

create table jelo(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	pice int not null
);

create table pice(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	jelo int not null
);