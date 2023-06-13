use master;
drop database if exists kolokvij_vjezba_08;
go
create database kolokvij_vjezba_08;
go
use kolokvij_vjezba_08;

--0. Kreirajte tablice i veze između tablica
create table prijateljica(
	sifra int not null primary key identity(1,1),
	vesta varchar(50),
	nausnica int not null,
	introvertno bit not null
);

create table cura(
	sifra int not null primary key identity(1,1),
	nausnica int not null,
	indiferentno bit,
	ogrlica int not null,
	gustoca decimal(12,6),
	drugiputa datetime,
	vesta varchar(33),
	prijateljica int
);

create table decko(
	sifra int not null primary key identity(1,1),
	kuna decimal(12,10),
	lipa decimal(17,10),
	bojakose varchar(44),
	treciputa datetime not null,
	ogrlica int not null,
	ekstrovertno bit not null
);

create table muskarac(
	sifra int not null primary key identity(1,1),
	haljina varchar(47),
	drugiputa datetime not null,
	treciputa datetime
);

create table muskarac_decko(
	sifra int not null primary key identity(1,1),
	muskarac int not null,
	decko int not null
);

create table becar(
	sifra int not null primary key identity(1,1),
	eura decimal(15,10) not null,
	treciputa datetime,
	prviputa datetime,
	muskarac int not null
);

create table neprijatelj(
	sifra int not null primary key identity(1,1),
	kratkamajica varchar(44),
	introvertno bit,
	indiferentno bit,
	ogrlica int not null,
	becar int not null
);

create table brat(
	sifra int not null primary key identity(1,1),
	introvertno bit,
	novcica decimal(14,7) not null,
	treciputa datetime,
	neprijatelj int
);