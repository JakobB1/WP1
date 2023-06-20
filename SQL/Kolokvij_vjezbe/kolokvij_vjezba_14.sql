use master;
drop database if exists kolokvij_vjezba_14;
go
create database kolokvij_vjezba_14;
go
use kolokvij_vjezba_14;

--0. Kreirajte tablice i veze između tablica
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

alter table prijatelj add foreign key(mladic) references mladic(sifra);
alter table ostavljena add foreign key(ostavljen) references ostavljen(sifra);
alter table ostavljen add foreign key(brat) references brat(sifra);
alter table brat add foreign key(neprijatelj) references neprijatelj(sifra);
alter table neprijatelj_muskrac add foreign key(neprijatelj) references neprijatelj(sifra);
alter table neprijatelj_muskrac add foreign key(muskarac) references muskarac(sifra);

--1. U tablice ostavljen, brat i neprijatelj_muskarac unesite po 3 retka.
select * from muskarac;
insert into muskarac(ogrlica,vesta)
values
(2,'Plava'),
(4,'Zelena'),
(3,'Crvena');

select * from neprijatelj;
insert into neprijatelj(prstena,bojakose,ogrlica,stilfrizura)
values
(3,'Plava',3,'Zelena'),
(1,'Zelena',5,'Smeda'),
(2,'Smeda',4,'Plava');

select * from neprijatelj_muskrac;
insert into neprijatelj_muskrac(neprijatelj,muskarac)
values
(1,3),
(2,3),
(3,1);

select * from brat;
insert into brat(eura,gustoca,haljina,neprijatelj)
values 
(22.22,33.33,'Plava',3),
(32.22,23.33,'Zelena',2),
(42.22,63.33,'Plava',1);

select * from ostavljen;
insert into ostavljen(drugiputa,asocijalno,brat)
values 
('2021-04-23',0,1),
('2022-04-23',1,2),
('2023-04-23',1,3);