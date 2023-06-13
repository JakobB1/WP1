use master;
drop database if exists kolokvij_vjezba_14;
go
create database kolokvij_vjezba_14;
go
use kolokvij_vjezba_14;

create table mladic(
	sifra int not null primary key identity(1,1),
	drugiputa datetime not null,
	narukvica int,
	bojaociju varchar(49) not null,
	modelnaocala varchar(41)
);

create table prijatelj(
	sifra int not null primary key identity(1,1),
	stilfrizura varchar(39),
	kratkamajica varchar(32),
	treciputa datetime,
	modelnaocala varchar(32) not null,
	prviputa datetime,
	mladic int not null
);

create table muskarac(
	sifra int not null primary key identity(1,1),
	carape varchar(36),
	ogrlica int not null,
	vesta varchar(44) not null,
	ekstrovertno bit
);

create table neprijatelj(
	sifra int not null primary key identity(1,1),
	prstena int not null,
	gustoca decimal(17,7),
	bojakose varchar(48) not null,
	ogrlica int not null,
	stilfrizura varchar(47) not null
);

create table neprijatelj_muskrac(
	sifra int not null primary key identity(1,1),
	neprijatelj int not null,
	muskarac int not null
);

create table brat(
	sifra int not null primary key identity(1,1),
	eura decimal(15,10) not null,
	gustoca decimal(14,5) not null,
	kuna decimal(15,6),
	haljina varchar(38) not null,
	bojakose varchar(39),
	prstena int,
	neprijatelj int not null
);

create table ostavljen(
	sifra int not null primary key identity(1,1),
	majica varchar(39),
	drugiputa datetime not null,
	asocijalno bit not null,
	brat int not null
);

create table ostavljena(
	sifra int not null primary key identity(1,1),
	kuna decimal(17,7),
	hlace varchar(45),
	suknja varchar(36),
	dukserica varchar(36),
	kratkamajica varchar(47) not null,
	gustoca decimal(12,10) not null,
	ostavljen int
);