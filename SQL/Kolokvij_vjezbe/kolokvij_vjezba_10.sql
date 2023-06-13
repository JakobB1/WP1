use master;
drop database if exists kolokvij_vjezba_10;
go
create database kolokvij_vjezba_10;
go
use kolokvij_vjezba_10;

--0. Kreirajte tablice i veze između tablica
create table zarucnica(
	sifra int not null primary key identity(1,1),
	treciputa datetime,
	prviputa datetime,
	suknja varchar(32) not null,
	eura decimal(16,10) 
);

create table sestra(
	sifra int not null primary key identity(1,1),
	suknja varchar(46) not null,
	bojaociju varchar(49),
	indiferentno bit,
	dukserica varchar(32) not null,
	drugiputa datetime,
	prviputa datetime not null,
	zarucnica int
);

create table neprijatelj(
	sifra int not null primary key identity(1,1),
	gustoca decimal(15,10) not null,
	dukserica varchar(32) not null,
	maraka decimal(15,7),
	stilfrizura varchar(49) not null
);

create table punac(
	sifra int not null primary key identity(1,1),
	lipa decimal(15,9),
	eura decimal(15,10) not null,
	stilfrizura varchar(37)
);

create table punac_neprijatelj(
	sifra int not null primary key identity(1,1),
	punac int not null,
	neprijatelj int not null
);

create table svekrva(
	sifra int not null primary key identity(1,1),
	eura decimal(17,9),
	carape varchar(43),
	kuna decimal(13,9),
	majica varchar(30),
	introvertno bit not null,
	punac int
);

create table mladic(
	sifra int not null primary key identity(1,1),
	hlace varchar(48) not null,
	lipa decimal(18,6),
	stilfrizura varchar(35) not null,
	prstena int,
	maraka decimal(12,6) not null,
	svekrva int
);

create table zena(
	sifra int not null primary key identity(1,1),
	bojaociju varchar(49) not null,
	maraka decimal(13,9) not null,
	majica varchar(45),
	indiferentno bit,
	prviputa datetime,
	mladic int
);