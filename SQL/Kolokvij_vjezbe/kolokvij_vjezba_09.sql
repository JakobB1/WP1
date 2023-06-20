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

--1. U tablice brat, cura i punac_prijateljica unesite po 3 retka.
select * from punac;
insert into punac(narukvica)
values  
(6),
(3),
(8);

select * from cura;
insert into cura(vesta,suknja,punac)
values  
('Plava vesta','Crna suknja',1),
('Crna vesta','Zelena suknja',2),
('Zelena vesta','Crvena suknja',3);
                 
select * from brat;
insert into brat(novcica,vesta,cura)
values  
(99.99,'Plava vesta',1),
(33.99,'Zelena vesta',2),
(54.99,'Crna vesta',3);
              
select * from prijateljica;
insert into prijateljica(kuna)
values 
(12.12),
(123.12),
(54.15);

select * from punac_prijateljica;
insert into punac_prijateljica (punac,prijateljica)
values  
(1,3),
(2,2),
(3,1);

--2. U tablici snasa postavite svim zapisima kolonu drugiputa na vrijednost 24. travnja 2020.
select * from ostavljena;
insert into ostavljena(modelnaocala,eura,lipa,treciputa,drugiputa)
values  
('Suncane',232.33,141.22,'2021-04-04','2012-11-02'),
('Dioptrijske',212.33,131.22,'2019-04-04','2012-11-02'),
('RayBan',33.33,222.22,'2012-04-04','2012-11-02');
        
select * from snasa;
insert into snasa(drugiputa,haljina,ostavljena)
values  
('2013-11-23','Plava',1),
('2014-09-11','Crna',2),
('2015-12-02','Zelena',3);
        
update snasa set drugiputa = '2020-04-24';

--3. U tablici zarucnik obrišite sve zapise čija je vrijednost kolone haljina jednako AB.
delete from zarucnik where haljina='AB';

--4. Izlistajte carape iz tablice cura uz uvjet da vrijednost kolone ekstroventno nepoznate.
select carape from cura where ekstrovertno is null;

--5
--Prikažite kuna iz tablice prijateljica, nausnica iz tablice zarucnik te ekstroventno iz tablice brat 

--uz uvjet da su vrijednosti kolone ekstroventno iz tablice cura poznate 
--te da su vrijednosti kolone modelnaocala iz tablice punac sadrže niz znakova ba. 
--Podatke posložite po ekstroventno iz tablice brat silazno.
select a.kuna , f.nausnica , e.ekstrovertno 
from prijateljica a
inner join punac_prijateljica   b on a.sifra      = b.prijateljica 
inner join punac                c on b.punac      = c.sifra
inner join cura                 d on c.sifra      = d.punac
inner join brat                 e on d.sifra      = e.cura
inner join zarucnik             f on e.sifra      = f.brat
where d.ekstrovertno is not null and c.modelnaocala like '%ba%'
order by e.ekstrovertno;

--6. Prikažite kolone modelnaocala i kuna iz tablice punac 
--čiji se primarni ključ ne nalaze u tablici punac_prijateljica.
select	a.modelnaocala , a.kuna 
from	punac a left join punac_prijateljica b on b.punac = a.sifra 
where	b.punac is null; 