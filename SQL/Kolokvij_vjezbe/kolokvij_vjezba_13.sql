use master;
drop database if exists kolokvij_vjezba_13;
go
create database kolokvij_vjezba_13;
go
use kolokvij_vjezba_13;

--0. Kreirajte tablice i veze između tablica
create table muskarac(
	sifra int not null primary key identity(1,1),
	dukserica varchar(34),
	gustoca decimal(13,10),
	haljina varchar(42) not null,
	majica varchar(39),
	suknja varchar(50) not null,
	kuna decimal(17,9) not null
);

create table neprijatelj(
	sifra int not null primary key identity(1,1),
	bojakose varchar(32),
	novcica decimal(12,6) not null,
	prviputa datetime,
	indiferentno bit not null,
	suknja varchar(44),
	jmbag char(11),
	muskarac int not null
);

create table svekar(
	sifra int not null primary key identity(1,1),
	suknja varchar(40),
	stilfrizura varchar(34) not null,
	gustoca decimal(15,10) not null,
	carape varchar(35) not null
);

create table svekrva(
	sifra int not null primary key identity(1,1),
	hlace varchar(35),
	ogrlica int,
	ekstrovertno bit not null,
	narukvica int 
);

create table svekrva_svekar(
	sifra int not null primary key identity(1,1),
	svekrva int not null,
	svekar int not null
);

create table ostavljen(
	sifra int not null primary key identity(1,1),
	kratkamajica varchar(34),
	drugiputa datetime,
	asocijalno bit not null,
	stilfrizura varchar(40),
	svekrva int not null
);

create table mladic(
	sifra int not null primary key identity(1,1),
	drugiputa datetime not null,
	carape varchar(48) not null,
	ogrlica int,
	kratkamajica varchar(42) not null,
	introvertno bit not null,
	asocijalno bit not null,
	ostavljen int 
);

create table cura(
	sifra int not null primary key identity(1,1),
	ogrlica int,
	hlace varchar(42),
	vesta varchar(31) not null,
	majica varchar(50),
	mladic int
);