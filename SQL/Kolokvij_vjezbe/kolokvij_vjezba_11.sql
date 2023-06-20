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

alter table muskarac add foreign key(neprijatelj) references neprijatelj(sifra);
alter table punica add foreign key(djevojka) references djevojka(sifra);
alter table djevojka add foreign key(svekrva) references svekrva(sifra);
alter table svekrva add foreign key(punac) references punac(sifra);
alter table punac_mladic add foreign key(punac) references punac(sifra);
alter table punac_mladic add foreign key(mladic) references mladic(sifra);

--1. U tablice djevojka, svekrva i punac_mladic unesite po 3 retka.
select * from punac;
insert into punac(kuna,vesta)
values  
(123.99,'Plava'),
(124.99,'Zelena'),
(125.99,'Crna');
        
select * from svekrva;
insert into svekrva(narukvica,carape,punac)
values  
(5,'Plave',1),
(1,'Zelene',2),
(2,'Crne',3);
        
select * from djevojka; 
insert into djevojka(kratkamajica,ekstrovertno,majica,introvertno,svekrva)
values  
('Plava',0,'Zelena',0,1),
('Zelena',1,'Plava',1,2),
('Crna',0,'Crna',1,3);
        
select * from mladic;
insert into mladic(ogrlica,drugiputa,hlace)
values  
(2,'2013-11-15','Plave'),
(2,'2012-12-25','Crne'),
(2,'2011-01-05','Zelene');
        
select * from punac_mladic;
insert into punac_mladic(punac,mladic)
values  
(3,3),
(2,2),
(1,3);

--2. U tablici muskarac postavite svim zapisima kolonu novcica na vrijednost 15,70.
select * from neprijatelj;
insert into neprijatelj(narukvica,novcica,bojakose,introvertno,asocijalno)
values  
(2,22.22,'Crna',1,0),
(2,33.33,'Plava',0,0),
(3,44.44,'Zelena',1,0);
        
select * from muskarac;
insert into muskarac(narukvica,neprijatelj)
values  
(1,1),
(2,2),
(4,3);
        
update muskarac set novcica =15.70;

--3. U tablici punica obrišite sve zapise čija je vrijednost kolone drugiputa 8. travnja 2019.
select * from punica;
insert into punica(carape,majica,haljina,bojakose,djevojka)
values  
('Crne','Plava','Zelena','Plava',1),
('Crne','Plava','Zelena','Plava',2),
('Crne','Plava','Zelena','Plava',3);
        
delete from punica where drugiputa ='2020-04-30';

--4. Izlistajte haljina iz tablice svekrva uz uvjet da vrijednost kolone carape sadrže slova ana.
select haljina from svekrva where carape like '%ana%';

--5.
--Prikažite drugiputa iz tablice mladic, haljina iz tablice punica te prstena iz tablice djevojka 

--uz uvjet da su vrijednosti kolone carape iz tablice svekrva počinju slovom a 
--te da su vrijednosti kolone kuna iz tablice punac različite od 21. 
--Podatke posložite po prstena iz tablice djevojka silazno.
select a.drugiputa , f.haljina , e.prstena 
from mladic a 
inner join punac_mladic    b on a.sifra     = b. mladic
inner join punac           c on b.punac     = c.sifra
inner join svekrva         d on c.sifra     = d.punac
inner join djevojka        e on d.sifra     = e.svekrva
inner join punica          f on e.sifra     = f.djevojka
where d.carape like 'a%' and c.kuna =21
order by e.prstena desc;

--6. Prikažite kolone kuna i vesta iz tablice punac čiji se primarni ključ ne nalaze u tablici punac_mladic.
select	a.kuna, a.vesta 
from	punac a left join punac_mladic b on b.punac = a.sifra 
where	b.punac is null;