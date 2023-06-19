use master;
drop database if exists kolokvij_vjezba_01;
go
create database kolokvij_vjezba_01;
go
use kolokvij_vjezba_01;

--0. Kreirajte tablice i veze između tablica
create table sestra(
	sifra int not null primary key identity(1,1),
	introvertno bit,
	haljina varchar(31) not null,
	maraka decimal(16,6),
	hlace varchar(46) not null,
	narukvica int not null
);

create table zena(
	sifra int not null primary key identity(1,1),
	treciputa datetime,
	hlace varchar(46),
	kratkamajica varchar(31) not null,
	jmbag char(11) not null,
	bojaociju varchar(39) not null,
	haljina varchar(44),
	sestra int not null
);

create table muskarac(
	sifra int not null primary key identity(1,1),
	bojaociju varchar(50) not null,
	hlace varchar(30),
	modelnaocala varchar(43),
	maraka decimal(14,5) not null,
	zena int not null
);

create table mladic(
	sifra int not null primary key identity(1,1),
	suknja varchar(50) not null,
	kuna decimal(16,8) not null,
	drugiputa datetime,
	asocijalno bit,
	ekstrovertno bit not null,
	dukserica varchar(48) not null,
	muskarac int
);

create table punac(
	sifra int not null primary key identity(1,1),
	ogrlica int,
	gustoca decimal(14,9),
	hlace varchar(41) not null
);

create table cura(
	sifra int not null primary key identity(1,1),
	novcica decimal(16,5) not null,
	gustoca decimal(18,6) not null,
	lipa decimal(13,10),
	ogrlica int not null,
	bojakose varchar(38),
	suknja varchar(36),
	punac int 
);

create table svekar(
	sifra int not null primary key identity(1,1),
	bojaociju varchar(40) not null,
	prstena int,
	dukserica varchar(41),
	lipa decimal(13,8),
	eura decimal(12,7),
	majica varchar(35)
);

create table sestra_svekar(
	sifra int not null primary key identity(1,1),
	sestra int not null,
	svekar int not null
);

alter table cura add foreign key(punac) references punac(sifra);
alter table mladic add foreign key(muskarac) references muskarac(sifra);
alter table muskarac add foreign key(zena) references zena(sifra);
alter table zena add foreign key(sestra) references sestra(sifra);
alter table sestra_svekar add foreign key(sestra) references sestra(sifra);
alter table sestra_svekar add foreign key(svekar) references svekar(sifra);

--1. U tablice muskarac, zena i sestra_svekar unesite po 3 retka.
select * from sestra;
insert into sestra(haljina,hlace,narukvica)
values	
('Plava haljina','Kratke hlace',3),
('Zuta haljina','Duge hlace',4),
('Zelena haljina','Crne hlace',5);
      
select * from zena;
insert into zena(kratkamajica,jmbag,bojaociju,sestra)
values
('Plava majica',111111,'zelena',2),
('Zelena majica',222222,'plava',3),
('Crna majica',333333,'smeda',1);
          
select * from muskarac;
insert into muskarac(bojaociju,maraka,zena)
values
('Crna',10.10,3),
('Plava',20.20,1),
('Zelena',30.30,2);
           
select * from svekar;
insert into svekar(bojaociju,eura,majica)
values	
('Plava',40.00,'Crna majica'),
('Crna',50.00,'Bijela majica'),
('Zelena',60.00,'Plava majica');

select * from sestra_svekar;
insert into sestra_svekar(sestra,svekar) 
values	
(1,1),
(2,2),
(3,3);

--2. U tablici cura postavite svim zapisima kolonu gustoca na vrijednost 15,77.
select * from cura;
insert into cura(novcica,gustoca,ogrlica)
values
(10.10,10,1),
(20.50,20,2),
(30.50,30,3);

update cura set gustoca = 15.77;

--3. U tablici mladic obrišite sve zapise čija je vrijednost kolone kuna veće od 15,78.
select * from mladic;
insert into mladic(suknja,kuna,ekstrovertno,dukserica)
values 
('Suknja01',22.22,0,'Dukserica01'),
('Suknja02',4.25,1,'Dukserica02'),
('Suknja03',22.22,0,'Dukserica03'),
('Suknja04',33.50,1,'Dukserica04'),
('Suknja05',5.55,0,'Dukserica05');

delete from mladic where kuna > 15.78;

--4. Izlistajte kratkamajica iz tablice zena uz uvjet da vrijednost kolone hlace sadrže slova ana.
select * from zena;
insert into zena(hlace,kratkamajica,jmbag,bojaociju,sestra)
values 
('Ana','Kratka01',444444,'plava',3);

select kratkamajica from zena where hlace like '%ana%';

 
--5. 
--Prikažite dukserica iz tablice svekar, asocijalno iz tablice mladic te hlace iz tablice muskarac 

--uz uvjet da su vrijednosti kolone hlace iz tablice zena počinju slovom a 
--te da su vrijednosti kolone haljina iz tablice sestra sadrže niz znakova ba. 
--Podatke posložite po hlace iz tablice muskarac silazno.
select a.dukserica, f.asocijalno, e.hlace 
from svekar a 
inner join sestra_svekar  b on a.sifra = b.svekar 
inner join sestra         c on b.sestra = c.sifra 
inner join zena           d on c.sifra = d.sestra 
inner join muskarac       e on d.sifra = e.zena 
inner join mladic         f on e.sifra = f.muskarac 
where d.hlace like 'a%' and c.haljina like '%ba%'
order by e.hlace desc;

--6. Prikažite kolone haljina i maraka iz tablice sestra 
--čiji se primarni ključ ne nalaze u tablici sestra_svekar.
select	a.haljina, a.maraka 
from	sestra a inner join sestra_svekar b on a.sifra = b.sestra 
where	b.sestra is null;  