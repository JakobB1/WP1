use master;
drop database if exists kolokvij_vjezba_08;
go
create database kolokvij_vjezba_08;
go
use kolokvij_vjezba_08;

create table prijateljica(
	sifra int not null primary key identity(1,1),
	vesta varchar(50),
	nausnica int not null,
	introvertno bit not null
);

