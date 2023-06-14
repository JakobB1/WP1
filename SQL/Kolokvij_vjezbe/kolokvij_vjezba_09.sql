use master;
drop database if exists kolokvij_vjezba_09;
go
create database kolokvij_vjezba_09;
go
use kolokvij_vjezba_09;

--0. Kreirajte tablice i veze između tablica
create table ostavljena(
	sifra int not null primary key identity(1,1),
	modelnaocala varchar(34) not null,
	suknja varchar(32),
	eura decimal(18,7) not null,
	lipa decimal(15,7) not null,
	treciputa datetime not null,
	drugiputa datetime not null
);

create table snasa(
	sifra int not null primary key identity(1,1),
	prstena int,
	drugiputa datetime not null,
	haljina varchar(38) not null,
	ostavljena int
);

create table prijateljica(
	sifra int not null primary key identity(1,1),
	treciputa datetime,
	novcica decimal(16,7),
	kuna decimal(14,10) not null,
	drugiputa datetime,
	haljina varchar(45),
	kratkamajica varchar(49)
);

create table punac(
	sifra int not null primary key identity(1,1),
	narukvica int not null,
	modelnaocala varchar(30),
	kuna decimal(12,8),
	bojaociju varchar(33),
	suknja varchar(45)
);

create table punac_prijateljica(
	sifra int not null primary key identity(1,1),
	punac int not null,
	prijateljica int not null
);

create table cura(
	sifra int not null primary key identity(1,1),
	vesta varchar(49) not null,
	ekstrovertno bit,
	carape varchar(37),
	suknja varchar(37) not null,
	punac int not null
);

create table brat(
	sifra int not null primary key identity(1,1),
	novcica decimal(18,9) not null,
	ekstrovertno bit,
	vesta varchar(32) not null,
	cura int 
);

create table zarucnik(
	sifra int not null primary key identity(1,1),
	gustoca decimal(17,6),
	haljina varchar(40),
	kratkamajica varchar(48) not null,
	nausnica int not null,
	brat int not null
);

alter table snasa add foreign key(ostavljena) references ostavljena(sifra);
alter table zarucnik add foreign key(brat) references brat(sifra);
alter table brat add foreign key(cura) references cura(sifra);
alter table cura add foreign key(punac) references punac(sifra);
alter table punac_prijateljica add foreign key(punac) references punac(sifra);
alter table punac_prijateljica add foreign key(prijateljica) references prijateljica(sifra);