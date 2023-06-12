use master;
drop database if exists kolokvij_vjezba_04;
go
create database kolokvij_vjezba_04;
go
use kolokvij_vjezba_04;

create table ostavljen(
	sifra int not null primary key identity(1,1),
	modelnaocala varchar(43),
	introvertno bit,
	kuna decimal(14,10)
);

create table punac(
	sifra int not null primary key identity(1,1),
	treciputa datetime,
	majica varchar(46),
	jmbag char(11) not null,
	novcica decimal(18,7) not null,
	maraka decimal(12,6) not null,
	ostavljen int not null
);

create table mladic(
	sifra int not null primary key identity(1,1),
	kuna decimal(15,9),
	lipa decimal(18,5),
	nausnica int,
	stilfrizura varchar(49),
	vesta varchar(34) not null
);

create table zena(
	sifra int not null primary key identity(1,1),
	suknja varchar(39) not null,
	lipa decimal(18,7),
	prstena int not null
);

create table zena_mladic(
	sifra int not null primary key identity(1,1),
	zena int not null,
	mladic int not null
);

create table snasa(
	sifra int not null primary key identity(1,1),
	introvertno bit,
	treciputa datetime,
	haljina varchar(44) not null,
	zena int not null
);

create table becar(
	sifra int not null primary key identity(1,1),
	novcica decimal(14,8),
	kratkamajica varchar(48) not null,
	bojaociju varchar(36) not null,
	snasa int not null
);

create table prijatelj(
	sifra int not null primary key identity(1,1),
	eura decimal(16,9),
	prstena int not null,
	gustoca decimal(16,5),
	jmbag char(11) not null,
	suknja varchar(47) not null,
	becar int not null
);