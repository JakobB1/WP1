use master;
drop database if exists fakultetwp1;
go 
create database fakultetwp1;
go
use fakultetwp1;

create table studenti(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	rok int not null
);

create table rok(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	studenti int not null
);