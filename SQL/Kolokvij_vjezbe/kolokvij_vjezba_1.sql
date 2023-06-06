use master;
drop database if exists kolokvij_vjezba_1;
go
create database kolokvij_vjezba_1;
go
use kolokvij_vjezba_1;

create table mladic(
	sifra int not null primary key identity(1,1),
	suknja varchar(50) not null,
	kuna decimal(16,8) not null,
	drugiputa datetime,
	asocijalno bit,
	ekstrovertno bit not null,
	dukserica varchar(48) not null,
	muskarac int
);