use master;
drop database if exists kolokvij_vjezba_16;
go
create database kolokvij_vjezba_16;
go
use kolokvij_vjezba_16;

--0. Kreirajte tablice i veze između tablica
create table prijatelj(
	sifra int not null primary key identity(1,1),
	treciputa datetime,
	majica varchar(49),
	asocijalno bit not null,
	hlace varchar(42)
);

create table zena(
	sifra int not null primary key identity(1,1),
	gustoca decimal(12,8),
	lipa decimal(16,6),
	ogrlica int,
	carape varchar(32),
	nausnica int not null,
	modelnaocala varchar(46) not null,
	prijatelj int
);

create table zarucnik(
	sifra int not null primary key identity(1,1),
	novcica decimal(13,9) not null,
	bojakose varchar(41) not null,
	kuna decimal(16,8) not null,
	prstena int not null,
	kratkamajica varchar(44) not null,
	nausnica int not null
);

create table punac(
	sifra int not null primary key identity(1,1),
	kratkamajica varchar(45),
	bojakose varchar(41),
	novcica decimal(16,8),
	treciputa datetime not null
);

create table punac_zarucnik(
	sifra int not null primary key identity(1,1),
	punac int not null,
	zarucnik int not null
);

create table brat(
	sifra int not null primary key identity(1,1),
	vesta varchar(44) not null,
	dukserica varchar(34),
	prstena int,
	majica varchar(36) not null,
	punac int not null
);

create table mladic(
	sifra int not null primary key identity(1,1),
	haljina varchar(30),
	lipa decimal(12,8),
	kratkamajica varchar(33),
	kuna decimal(12,10),
	treciputa datetime not null,
	brat int not null
);

create table svekrva(
	sifra int not null primary key identity(1,1),
	jmbag char(11),
	ogrlica int,
	bojakose varchar(40) not null,
	drugiputa datetime not null,
	mladic int not null
);

alter table zena add foreign key(prijatelj) references prijatelj(sifra);
alter table svekrva add foreign key(mladic) references mladic(sifra);
alter table mladic add foreign key(brat) references brat(sifra);
alter table brat add foreign key(punac) references punac(sifra);
alter table punac_zarucnik add foreign key(punac) references punac(sifra);
alter table punac_zarucnik add foreign key(zarucnik) references zarucnik(sifra);

--1. U tablice mladic, brat i punac_zarucnik unesite po 3 retka.
select * from punac;
insert into punac(treciputa)
values  
('2014-11-21'),
('2015-08-11'),
('2017-04-26');

select * from brat;
insert into brat(vesta,majica,punac)
values  
('Plava','Crna',1),
('Plava','Crna',2),
('Plava','Crna',3);

select * from mladic;
insert into mladic(treciputa,brat)
values  
('2020-11-21',1),
('2019-01-21',2),
('2021-04-06',3);

select * from zarucnik;
insert into zarucnik(novcica,bojakose,kuna,prstena,kratkamajica,nausnica)
values  
(21.33,'Crna',12.32,1,'Zuta',5),
(321.33,'Plava',12.32,4,'Plava',7),
(121.33,'Zelena',12.32,7,'Zelena',3);

select * from punac_zarucnik;
insert into punac_zarucnik(punac,zarucnik)
values  
(1,3),
(2,2),
(3,1);

--2. U tablici zena postavite svim zapisima kolonu lipa na vrijednost 13,77.
update zena set lipa = 13.77;

--3. U tablici svekrva obrišite sve zapise čija je vrijednost kolone ogrlica različito od 18.
delete from svekrva where ogrlica !=18;

--4. Izlistajte prstena iz tablice brat uz uvjet da vrijednost kolone dukserica sadrže slova ana.
select prstena from brat where dukserica like '%ana%';

--5. 
--Prikažite kuna iz tablice zarucnik, drugiputa iz tablice svekrva te lipa iz tablice mladic 

--uz uvjet da su vrijednosti kolone dukserica iz tablice brat počinju slovom a 
--te da su vrijednosti kolone bojakose iz tablice punac sadrže niz znakova ba. 
--Podatke posložite po lipa iz tablice mladic silazno.
select a.kuna , e.lipa   
from zarucnik a
inner join punac_zarucnik     b on a.sifra      = b.zarucnik 
inner join punac              c on b.punac      = c.sifra
inner join brat               d on c.sifra      = d.punac 
inner join mladic             e on d.sifra      = e.brat 
inner join svekrva            f on e.sifra      = f.mladic
where d.dukserica like 'a&' and c.bojakose like '%ba%'
order by e.kuna desc;

--6. Prikažite kolone bojakose i novcica iz tablice punac 
--čiji se primarni ključ ne nalaze u tablici punac_zarucnik.
select	a.bojakose ,a.novcica 
from	punac a left join punac_zarucnik b on b.punac = a.sifra
where	b.punac is null;  