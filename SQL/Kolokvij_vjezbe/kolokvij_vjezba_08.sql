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

alter table cura add foreign key(prijateljica) references prijateljica(sifra);
alter table brat add foreign key(neprijatelj) references neprijatelj(sifra);
alter table neprijatelj add foreign key(becar) references becar(sifra);
alter table becar add foreign key(muskarac) references muskarac(sifra);
alter table muskarac_decko add foreign key(muskarac) references muskarac(sifra);
alter table muskarac_decko add foreign key(decko) references decko(sifra);

--1. U tablice neprijatelj, becar i muskarac_decko unesite po 3 retka.
select * from muskarac; 
insert into muskarac (drugiputa)
values 
('2017-11-19'),
('2019-11-19'),
('2011-11-19');
     
select * from becar;
insert into becar(eura,muskarac)
values 
(22.22,1),
(33.33,2),
(343.50,1);

select * from neprijatelj;
insert into neprijatelj(ogrlica,becar)
values  
(2,1),
(7,2),
(9,3);
               
select * from decko;
insert into decko(treciputa,ogrlica,ekstrovertno)
values  
('2013-03-12',6,0),
('2015-12-21',5,1),
('2018-11-30',2,1);
               
select * from muskarac_decko;
insert into muskarac_decko(muskarac,decko)
values  
(1,3),
(2,2),
(3,1);

--2. U tablici cura postavite svim zapisima kolonu indiferentno na vrijednost false.
select * from prijateljica;  
insert into prijateljica(nausnica,introvertno)
values  
(5,0),
(3,0),
(7,1);

select * from cura;
insert into cura(nausnica,ogrlica,prijateljica)
values  
(3,5,1),
(1,4,2),
(6,1,3);
        
update cura set indiferentno=0;

--3. U tablici brat obrišite sve zapise čija je vrijednost kolone novcica različito od 12,75.
select * from brat;
delete from brat where novcica!='12.75';

--4. Izlistajte prviputa iz tablice becar uz uvjet da vrijednost kolone treciputa nepoznate.
select prviputa from becar where treciputa is null;

--5. 
--Prikažite bojakose iz tablice decko, neprijatelj iz tablice brat te introvertno iz tablice neprijatelj 

--uz uvjet da su vrijednosti kolone treciputa iz tablice becar poznate 
--te da su vrijednosti kolone drugiputa iz tablice muskarac poznate. 
--Podatke posložite po introvertno iz tablice neprijatelj silazno.
select a.bojakose , f.neprijatelj , e.introvertno 
from decko a
inner join muskarac_decko  b on a.sifra      = b.decko
inner join muskarac        c on b.muskarac   = c.sifra
inner join becar           d on c.sifra      = d.muskarac 
inner join neprijatelj     e on d.sifra      = e.becar
inner join brat            f on e.sifra      = f.neprijatelj 
where d.treciputa is not null and c.drugiputa is not null
order by e.introvertno desc;

--6. Prikažite kolone drugiputa i treciputa iz tablice muskarac 
--čiji se primarni ključ ne nalaze u tablici muskarac_decko.
select	a.drugiputa , a.treciputa 
from	muskarac a left join muskarac_decko b on b.muskarac = a.sifra 
where	b.muskarac is null;