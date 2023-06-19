use master;
drop database if exists kolokvij_vjezba_05;
go
create database kolokvij_vjezba_05;
go
use kolokvij_vjezba_05;

--0. Kreirajte tablice i veze između tablica
create table zarucnik(
	sifra int not null primary key identity(1,1),
	jmbag char(11),
	lipa decimal(12,8),
	indiferentno bit not null
);

create table mladic(
	sifra int not null primary key identity(1,1),
	kratkamajica varchar(48) not null,
	haljina varchar(30) not null,
	asocijalno bit,
	zarucnik int
);

create table cura(
	sifra int not null primary key identity(1,1),
	carape varchar(41) not null,
	maraka decimal(17,10) not null,
	asocijalno bit,
	vesta varchar(47) not null
);

create table svekar(
	sifra int not null primary key identity(1,1),
	bojakose varchar(33),
	majica varchar(31),
	carape varchar(31) not null,
	haljina varchar(43),
	narukvica int,
	eura decimal(14,5) not null
);

create table svekar_cura(
	sifra int not null primary key identity(1,1),
	svekar int not null,
	cura int not null
);

create table punac(
	sifra int not null primary key identity(1,1),
	dukserica varchar(33),
	prviputa datetime not null,
	majica varchar(36),
	svekar int not null
);

create table punica(
	sifra int not null primary key identity(1,1),
	hlace varchar(43) not null,
	nausnica int not null,
	ogrlica int,
	vesta varchar(49) not null,
	modelnaocala varchar(31) not null,
	treciputa datetime not null,
	punac int not null
);

create table ostavljena(
	sifra int not null primary key identity(1,1),
	majica varchar(33),
	ogrlica int not null,
	carape varchar(44),
	stilfrizura varchar(42),
	punica int not null
);

alter table mladic add foreign key(zarucnik) references zarucnik(sifra);
alter table ostavljena add foreign key(punica) references punica(sifra);
alter table punica add foreign key(punac) references punac(sifra);
alter table punac add foreign key(svekar) references svekar(sifra);
alter table svekar_cura add foreign key(svekar) references svekar(sifra);
alter table svekar_cura add foreign key(cura) references cura(sifra);

--1. U tablice punica, punac i svekar_cura unesite po 3 retka.
select * from svekar;
insert into svekar(carape,eura)
values  
('Crne',10.99),
('Zelene',20.99),
('Plave',30.99);

select * from punac;
insert into punac(prviputa,svekar)
values 
('2012-01-25',1),
('2013-02-11',2),
('2014-07-05',3);
             
select * from punica;
insert into punica(hlace,nausnica,vesta,modelnaocala,treciputa,punac)
values  
('Plave',4,'Crna','Suncane','2012-12-25',1),
('Zelene',7,'Plava','Dioptrijske','2012-12-25',2),
('Crne',9,'Zelena','Ray-Ban','2012-12-25',3);
 
select * from cura;
insert into cura(carape,maraka,vesta)
values  
('Crne',20.99,'Plava'),
('Plave',30.99,'Crna'),
('Zelene',40.99,'Zuta');
              
select * from svekar_cura;
insert into svekar_cura(svekar,cura)
values 
(1,3),
(2,2),
(3,1);

--2. U tablici mladic postavite svim zapisima kolonu haljina na vrijednost Osijek.
select * from mladic;
insert into mladic(kratkamajica,haljina)
values
('Plava','Zelena'),
('Crna','Crvena'),
('Zelena','Plava');

update mladic set haljina='Osijek';

--3. U tablici ostavljena obrišite sve zapise čija je vrijednost kolone ogrlica jednako 17.
select * from ostavljena;
insert into ostavljena(ogrlica,punica)
values  
(21,1),
(17,2),
(14,3);
        
delete from ostavljena where ogrlica =17; 

--4. Izlistajte majica iz tablice punac uz uvjet da vrijednost kolone prviputa nepoznate.
select majica from punac where prviputa is null;

--5.
--Prikažite asocijalno iz tablice cura, stilfrizura iz tablice ostavljena te nausnica iz tablice punica 

--uz uvjet da su vrijednosti kolone prviputa iz tablice punac poznate 
--te da su vrijednosti kolone majica iz tablice svekar sadrže niz znakova ba. 
--Podatke posložite po nausnica iz tablice punica silazno.
select a.asocijalno , f.stilfrizura , e.nausnica 
from cura a
inner join svekar_cura     b on a.sifra      = b.cura
inner join svekar          c on b.svekar     = c.sifra
inner join punac           d on c.sifra      = d.svekar
inner join punica          e on d.sifra      = e.punac
inner join ostavljena      f on e. sifra     = f.punica
where d.prviputa is not null and c.majica like '%ba%'
order by e.nausnica desc;

--6. Prikažite kolone majica i carape iz tablice svekar 
--čiji se primarni ključ ne nalaze u tablici svekar_cura.
select	a.majica , a.carape 
from	svekar a left join svekar_cura b on a.sifra = b.svekar
where	b.svekar is null;