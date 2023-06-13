use master;
drop database if exists kolokvij_vjezba_11;
go
create database kolokvij_vjezba_11;
go
use kolokvij_vjezba_11;

--0. Kreirajte tablice i veze između tablica
create table neprijatelj(
	sifra int not null primary key identity(1,1),
	narukvica int not null,
	novcica decimal(12,8) not null,
	bojakose varchar(39) not null,
	gustoca decimal(14,10),
	introvertno bit not null,
	asocijalno bit
);

create table muskarac(
	sifra int not null primary key identity(1,1),
	maraka decimal(16,5),
	novcica decimal(13,10),
	nausnica int,
	narukvica int not null,
	gustoca decimal(12,6),
	neprijatelj int not null
);

create table mladic(
	sifra int not null primary key identity(1,1),
	ogrlica int not null,
	stilfrizura varchar(35),
	drugiputa datetime not null,
	hlace varchar(41) not null
);

create table punac(
	sifra int not null primary key identity(1,1),
	jmbag char(11),
	kuna decimal(16,5) not null,
	vesta varchar(45) not null
);

create table punac_mladic(
	sifra int not null primary key identity(1,1),
	punac int not null,
	mladic int not null
);

create table svekrva(
	sifra int not null primary key identity(1,1),
	narukvica int not null,
	carape varchar(39) not null,
	haljina varchar(31),
	punac int not null
);

create table djevojka(
	sifra int not null primary key identity(1,1),
	kratkamajica varchar(45) not null,
	prstena int,
	ekstrovertno bit not null,
	majica varchar(42) not null,
	introvertno bit not null,
	svekrva int
);

create table punica(
	sifra int not null primary key identity(1,1),
	carape varchar(33) not null,
	drugiputa datetime,
	majica varchar(40) not null,
	haljina varchar(30) not null,
	bojakose varchar(37) not null,
	djevojka int not null
);