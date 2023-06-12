use master;
drop database if exists kolokvij_vjezba_2;
go
create database kolokvij_vjezba_2;
go
use kolokvij_vjezba_2;

create table svekar(
	sifra int not null primary key identity(1,1),
	stilfrizura varchar(48),
	ogrlica int not null,
	asocijalno bit not null
);

create table prijatelj(
	sifra int not null primary key identity(1,1),
	modelnaocala varchar(37),
	treciputa datetime not null,
	ekstrovertno bit not null,
	prviputa datetime,
	svekar int not null
);

create table decko(
	sifra int not null primary key identity(1,1),
	indiferentno bit,
	vesta varchar(34),
	asocijalno bit not null
);

create table zarucnica(
	sifra int not null primary key identity(1,1),
	narukvica int,
	bojakose varchar(37) not null,
	novcica decimal(15,9),
	lipa decimal(15,8) not null,
	indiferentno bit not null
);

create table decko_zarucnica(
	sifra int not null primary key identity(1,1),
	decko int not null,
	zarucnica int not null
);

create table cura(
	sifra int not null primary key identity(1,1),
	haljina varchar(33) not null,
	drugiputa datetime not null,
	suknja varchar(38),
	narukvica int,
	introvertno bit,
	majica varchar(40) not null,
	decko int
);

create table neprijatelj(
	sifra int not null primary key identity(1,1),
	majica varchar(32),
	haljina varchar(43) not null,
	lipa decimal(16,8),
	modelnaocala varchar(49) not null,
	kuna decimal(12,6) not null,
	jmbag char(11),
	cura int 
);

create table brat(
	sifra int not null primary key identity(1,1),
	suknja varchar,
	ogrlica int not null,
	asocijalno bit not null,
	neprijatelj int not null
);