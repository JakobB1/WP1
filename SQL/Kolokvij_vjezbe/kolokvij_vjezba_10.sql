use master;
drop database if exists kolokvij_vjezba_10;
go
create database kolokvij_vjezba_10;
go
use kolokvij_vjezba_10;

--0. Kreirajte tablice i veze između tablica
create table zarucnica(
	sifra int not null primary key identity(1,1),
	treciputa datetime,
	prviputa datetime,
	suknja varchar(32) not null,
	eura decimal(16,10) 
);

create table sestra(
	sifra int not null primary key identity(1,1),
	suknja varchar(46) not null,
	bojaociju varchar(49),
	indiferentno bit,
	dukserica varchar(32) not null,
	drugiputa datetime,
	prviputa datetime not null,
	zarucnica int
);

create table neprijatelj(
	sifra int not null primary key identity(1,1),
	gustoca decimal(15,10) not null,
	dukserica varchar(32) not null,
	maraka decimal(15,7),
	stilfrizura varchar(49) not null
);

create table punac(
	sifra int not null primary key identity(1,1),
	lipa decimal(15,9),
	eura decimal(15,10) not null,
	stilfrizura varchar(37)
);

create table punac_neprijatelj(
	sifra int not null primary key identity(1,1),
	punac int not null,
	neprijatelj int not null
);

create table svekrva(
	sifra int not null primary key identity(1,1),
	eura decimal(17,9),
	carape varchar(43),
	kuna decimal(13,9),
	majica varchar(30),
	introvertno bit not null,
	punac int
);

create table mladic(
	sifra int not null primary key identity(1,1),
	hlace varchar(48) not null,
	lipa decimal(18,6),
	stilfrizura varchar(35) not null,
	prstena int,
	maraka decimal(12,6) not null,
	svekrva int
);

create table zena(
	sifra int not null primary key identity(1,1),
	bojaociju varchar(49) not null,
	maraka decimal(13,9) not null,
	majica varchar(45),
	indiferentno bit,
	prviputa datetime,
	mladic int
);

alter table sestra add foreign key(zarucnica) references zarucnica(sifra);
alter table zena add foreign key(mladic) references mladic(sifra);
alter table mladic add foreign key(svekrva) references svekrva(sifra);
alter table svekrva add foreign key(punac) references punac(sifra);
alter table punac_neprijatelj add foreign key(punac) references punac(sifra);
alter table punac_neprijatelj add foreign key(neprijatelj) references neprijatelj(sifra);

--1. U tablice mladic, svekrva i punac_neprijatelj unesite po 3 retka.
select * from punac;
insert into punac(eura)
values  
(10.99),
(62.99),
(13.99);

     
select * from svekrva;
insert into svekrva(introvertno)
values  
(1),
(0),
(1);

select * from mladic;
insert into mladic(hlace,stilfrizura,maraka,svekrva)
values  
('Crne hlace','Kratka',13.52,1),
('Plave hlace','Duga',32.52,1),
('Zelene hlace','Celavo',113.52,1);
              
select * from neprijatelj;
insert into neprijatelj(gustoca,dukserica,stilfrizura)
values  
(15.25,'Crna','Duga'),
(25.25,'Dugih rukava','Duga'),
(35.65,'Kratkih rukava','Duga');
              
select * from punac_neprijatelj;
insert into punac_neprijatelj (punac,neprijatelj)
values  
(1,3),
(2,1),
(3,2);

--2. U tablici sestra postavite svim zapisima kolonu bojaociju na vrijednost Osijek.
select * from zarucnica;
insert into zarucnica(suknja)
values  
('Plava'),
('Zelena'),
('Crna');
        
select * from sestra;
insert into sestra(suknja,dukserica,prviputa,zarucnica)
values  
('Roza','Plava','2021-03-23',1),
('Plava','Zelena','2021-01-01',2),
('Crna','Zuta','2021-06-30',3);

update sestra set bojaociju='Osijek';

--3. U tablici zena obrišite sve zapise čija je vrijednost kolone maraka različito od 14,81.
select * from zena;
insert into zena(bojaociju,maraka,mladic)
values  
('Zelena',33.35,1),
('Plava',14.81,2),
('Crna',222.55,3);
        
delete from zena where maraka !=14.81;

--4. Izlistajte kuna iz tablice svekrva uz uvjet da vrijednost kolone carape sadrže slova ana.
select kuna from svekrva where carape like '%ana%';

--5. 
--Prikažite maraka iz tablice neprijatelj, indiferentno iz tablice zena te lipa iz tablice mladic 

--uz uvjet da su vrijednosti kolone carape iz tablice svekrva počinju slovom a 
--te da su vrijednosti kolone eura iz tablice punac različite od 22. 
--Podatke posložite po lipa iz tablice mladic silazno.
select a.maraka , f.indiferentno , e.lipa 
from neprijatelj a
inner join punac_neprijatelj  b on a.sifra      = b.neprijatelj 
inner join punac              c on b.punac      = c.sifra
inner join svekrva            d on c.sifra      = d.punac 
inner join mladic             e on d.sifra      = e.svekrva 
inner join zena               f on e.sifra      = f.mladic
where d.carape like 'a&' and c.eura != 22
order by e.lipa desc;

--6. Prikažite kolone eura i stilfrizura iz tablice punac 
--čiji se primarni ključ ne nalaze u tablici punac_neprijatelj.
select	a.eura , a.stilfrizura 
from	punac a left join punac_neprijatelj b on b.punac = a.sifra
where	b.punac is null; 