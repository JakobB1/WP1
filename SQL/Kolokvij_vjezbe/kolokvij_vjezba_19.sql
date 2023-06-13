use master;
drop database if exists kolokvij_vjezba_19;
go
create database kolokvij_vjezba_19;
go
use kolokvij_vjezba_19;

create table decko(
	sifra int not null primary key identity(1,1),
	modelnaocala varchar(42) not null,
	gustoca decimal(16,10) not null,
	dukserica varchar(47) not null,
	stilfrizura varchar(40),
	novcica decimal(14,7) not null
);

create table svekar(
	sifra int not null primary key identity(1,1),
	nausnica int not null,
	indiferentno bit not null,
	suknja varchar(37) not null,
	drugiputa datetime,
	kuna decimal(13,6) not null,
	decko int
);

create table ostavljena(
	sifra int not null primary key identity(1,1),
	hlace varchar(41),
	ekstrovertno bit not null,
	narukvica int,
	eura decimal(17,6) not null,
	kratkamajica varchar(46)
);

create table punica(
	sifra int not null primary key identity(1,1),
	stilfrizura varchar(39) not null,
	maraka decimal(15,6) not null,
	jmbag char(11) not null
);

create table punica_ostavljena(
	sifra int not null primary key identity(1,1),
	punica int not null,
	ostavljena int not null
);

create table punac(
	sifra int not null primary key identity(1,1),
	maraka decimal(12,7),
	treciputa datetime,
	ekstrovertno bit,
	hlace varchar(32),
	punica int not null
);

create table svekrva(
	sifra int not null primary key identity(1,1),
	ekstrovertno bit,
	carape varchar(42),
	gustoca decimal(13,10) not null,
	stilfrizura varchar(34) not null,
	punac int not null
);

create table muskarac(
	sifra int not null primary key identity(1,1),
	drugiputa datetime not null,
	gustoca decimal(16,7),
	maraka decimal(16,9),
	ogrlica int not null,
	svekrva int
);