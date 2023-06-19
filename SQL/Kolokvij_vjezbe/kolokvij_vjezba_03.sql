use master;
drop database if exists kolokvij_vjezba_03;
go
create database kolokvij_vjezba_03;
go
use kolokvij_vjezba_03;

--0. Kreirajte tablice i veze između tablica
create table cura(
	sifra int not null primary key identity(1,1),
	dukserica varchar(49),
	maraka decimal(13,7),
	drugiputa datetime,
	majica varchar(49),
	novcica decimal(15,8),
	ogrlica int not null
);

create table svekar(
	sifra int not null primary key identity(1,1),
	novcica decimal(16,8) not null,
	suknja varchar(44) not null,
	bojakose varchar(36),
	prstena int,
	narukvica int not null,
	cura int not null
);

create table brat(
	sifra int not null primary key identity(1,1),
	jmbag char(11),
	ogrlica int not null,
	ekstrovertno bit not null
);

create table prijatelj(
	sifra int not null primary key identity(1,1),
	kuna decimal(16,10),
	haljina varchar(37),
	lipa decimal(13,10),
	dukserica varchar(31),
	indiferentno bit not null
);

create table prijatelj_brat(
	sifra int not null primary key identity(1,1),
	prijatelj int not null,
	brat int not null
);

create table ostavljena(
	sifra int not null primary key identity(1,1),
	kuna decimal(17,5),
	lipa decimal(15,6),
	majica varchar(36),
	modelnaocala varchar(31) not null,
	prijatelj int 
);

create table snasa(
	sifra int not null primary key identity(1,1),
	introvertno bit,
	kuna decimal(15,6) not null,
	eura decimal(12,9) not null,
	treciputa datetime,
	ostavljena int not null
);

create table punica(
	sifra int not null primary key identity(1,1),
	asocijalno bit,
	kratkamajica varchar(44),
	kuna decimal(13,8) not null,
	vesta varchar(32) not null,
	snasa int
);

alter table svekar add foreign key(cura) references cura(sifra);
alter table punica add foreign key(snasa) references snasa(sifra);
alter table snasa add foreign key(ostavljena) references ostavljena(sifra);
alter table ostavljena add foreign key(prijatelj) references prijatelj(sifra);
alter table prijatelj_brat add foreign key(prijatelj) references prijatelj(sifra);
alter table prijatelj_brat add foreign key(brat) references brat(sifra);

--1. U tablice snasa, ostavljena i prijatelj_brat unesite po 3 retka
select * from ostavljena;
insert into ostavljena(modelnaocala)
values  ('Ray-Ban'),
        ('Suncane'),
        ('Dioptrijske');
              
select * from snasa;
insert into snasa(kuna,eura,ostavljena)
values  
(1.99,10.99,1),
(2.33,20.99,2),
(3.99,30.99,3);     
             
select * from prijatelj;
insert into prijatelj(indiferentno)
values  
(1),
(1),
(0);

select * from brat;
insert into brat(ogrlica, ekstrovertno)
values  
(1,1),
(2,0),
(3,1);
            
select * from prijatelj_brat;
insert into prijatelj_brat(prijatelj,brat)
values  
(1,3), 
(2,2), 
(3,1);

--2. U tablici svekar postavite svim zapisima kolonu suknja na vrijednost Osijek.
select * from cura;
insert into cura(ogrlica)
values 
(2),
(7),
(6);

select* from svekar;
insert into svekar(novcica,suknja,narukvica,cura)
values  
(22.22,'Plava',7,1),
(33.11,'Zelena',4,2),
(44.55,'Crna',3,3);
       
update svekar set suknja = 'Osijek';

--3. U tablici punica obrišite sve zapise čija je vrijednost kolone kratkamajica jednako AB.
select * from snasa;
insert into snasa(kuna,eura,ostavljena)
values  
(23.23,33.33,1),
(23.23,33.33,2),
(23.23,33.33,3);
        
select * from punica;       
insert into punica(kuna,vesta,snasa)
values  
(33.11,'Zelena',1),
(22.21,'Crna',2),
(21.51,'Plava',3);
        
delete from punica where kratkamajica='AB';

--4. Izlistajte majica iz tablice ostavljena uz uvjet da vrijednost kolone lipa nije 9,10,20,30 ili 35.
select majica from ostavljena where lipa not in (9,10,20,30,35);

--5. 
--Prikažite ekstroventno iz tablice brat, vesta iz tablice punica te kuna iz tablice snasa 

--uz uvjet da su vrijednosti kolone lipa iz tablice ostavljena različito od 91 
--te da su vrijednosti kolone haljina iz tablice prijatelj sadrže niz znakova ba. 
--Podatke posložite po kuna iz tablice snasa silazno.
select a.ekstrovertno, f.vesta , e.kuna 
from brat a 
inner join prijatelj_brat b on a.sifra     = b.brat
inner join prijatelj      c on b.prijatelj = c.sifra
inner join ostavljena     d on c.sifra     = d.prijatelj 
inner join snasa          e on d.sifra     = e.ostavljena
inner join punica         f on e.sifra     = f.snasa 
where d.lipa != 91.00 and c.haljina like '%ba%'
order by e.kuna desc;

--6. Prikažite kolone haljina i lipa iz tablice prijatelj 
--čiji se primarni ključ ne nalaze u tablici prijatelj_brat.
select	a.haljina, a.lipa 
from	prijatelj a left join prijatelj_brat b on a.sifra = b.prijatelj 
where	b.prijatelj is null; 