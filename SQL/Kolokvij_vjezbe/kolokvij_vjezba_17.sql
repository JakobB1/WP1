use master;
drop database if exists kolokvij_vjezba_17;
go
create database kolokvij_vjezba_17;
go
use kolokvij_vjezba_17;

--0. Kreirajte tablice i veze između tablica
create table prijatelj(
	sifra int not null primary key identity(1,1),
	maraka decimal(13,6),
	narukvica int,
	nausnica int,
	lipa decimal(15,10),
	carape varchar(33) not null,
	stilfrizura varchar(35)
);

create table punica(
	sifra int not null primary key identity(1,1),
	indiferentno bit,
	narukvica int,
	gustoca decimal(18,10) not null,
	prijatelj int
);

create table becar(
	sifra int not null primary key identity(1,1),
	narukvica int,
	asocijalno bit not null,
	vesta varchar(48),
	kuna decimal(13,10),
	kratkamajica varchar(30) not null
);

create table brat(
	sifra int not null primary key identity(1,1),
	asocijalno bit not null,
	dukserica varchar(35),
	novcica decimal(15,6) not null,
	introvertno bit not null
);

create table brat_becar(
	sifra int not null primary key identity(1,1),
	brat int not null,
	becar int not null
);

create table ostavljen(
	sifra int not null primary key identity(1,1),
	bojaociju varchar(45),
	bojakose varchar(33),
	novcica decimal(16,7) not null,
	brat int not null
);

create table cura(
	sifra int not null primary key identity(1,1),
	ogrlica int,
	kuna decimal(16,8),
	indiferentno bit,
	jmbag char(11),
	maraka decimal(12,7) not null,
	ostavljen int not null
);

create table prijateljica(
	sifra int not null primary key identity(1,1),
	lipa decimal(12,9),
	haljina varchar(37),
	maraka decimal(13,8) not null,
	modelnaocala varchar(41) not null,
	cura int
);

alter table punica add foreign key(prijatelj) references prijatelj(sifra);
alter table prijateljica add foreign key(cura) references cura(sifra);
alter table cura add foreign key(ostavljen) references ostavljen(sifra);
alter table ostavljen add foreign key(brat) references brat(sifra);
alter table brat_becar add foreign key(brat) references brat(sifra);
alter table brat_becar add foreign key(becar) references becar(sifra);

--1. U tablice cura, ostavljen i brat_becar unesite po 3 retka.
select * from brat;
insert into brat(asocijalno,novcica,introvertno)
values  
(0,12.32,1),
(1,23.53,0),
(0,71.45,1);

select * from ostavljen;
insert into ostavljen(novcica,brat)
values  
(71.62,1),
(61.82,2),
(32.12,3);

select * from cura;
insert into cura(maraka,ostavljen,kuna)
values  
(31.52,1,10.20),
(51.42,2,20.20),
(41.22,3,30.20);

select * from becar ;
insert into becar(asocijalno,kratkamajica)
values  
(0,'Plava'),
(1,'Crvena'),
(1,'Zelena');

select * from brat_becar;
insert into brat_becar(brat,becar)
values  
(1,3),
(2,2),
(3,1);

--2. U tablici punica postavite svim zapisima kolonu narukvica na vrijednost 11.
update punica set narukvica =11;

--3. U tablici prijateljica obrišite sve zapise čija je vrijednost kolone haljina različito od AB.
delete from prijateljica where haljina !='AB';

--4. Izlistajte novcica iz tablice ostavljen uz uvjet da vrijednost kolone bojakose sadrže slova ana.
select novcica from ostavljen where bojakose like '%ana%';

--5.
--Prikažite vesta iz tablice becar, modelnaocala iz tablice prijateljica te kuna iz tablice cura 

--uz uvjet da su vrijednosti kolone bojakose iz tablice ostavljen počinju slovom a 
--te da su vrijednosti kolone dukserica iz tablice brat sadrže niz znakova ba. 
--Podatke posložite po kuna iz tablice cura silazno.
select a.vesta , f.modelnaocala , e.kuna 
from becar a
inner join brat_becar         b on a.sifra      = b.brat 
inner join brat               c on b.brat       = c.sifra
inner join ostavljen          d on c.sifra      = d.brat 
inner join cura               e on d.sifra      = e.ostavljen
inner join prijateljica       f on e.sifra      = f.cura
where d.bojakose like 'a&' and c.dukserica like '%ba%'
order by e.kuna desc;

--6. Prikažite kolone dukserica i novcica iz tablice brat 
--čiji se primarni ključ ne nalaze u tablici brat_becar.
select	a.dukserica , a.novcica 
from	brat a left join brat_becar b on b.brat = a.sifra
where	b.brat is null; 