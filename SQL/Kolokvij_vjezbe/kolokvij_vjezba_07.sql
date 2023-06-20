use master;
drop database if exists kolokvij_vjezba_07;
go
create database kolokvij_vjezba_07;
go
use kolokvij_vjezba_07;

--0. Kreirajte tablice i veze između tablica
create table cura(
	sifra int not null primary key identity(1,1),
	lipa decimal(12,9) not null,
	introvertno bit,
	modelnaocala varchar(40),
	narukvica int,
	treciputa datetime,
	kuna decimal(14,9)
);

create table punica(
	sifra int not null primary key identity(1,1),
	majica varchar(40),
	eura decimal(12,6) not null,
	prstena int,
	cura int not null
);

create table mladic(
	sifra int not null primary key identity(1,1),
	prstena int,
	lipa decimal(14,5) not null,
	narukvica int not null,
	drugiputa datetime not null
);

create table zarucnik(
	sifra int not null primary key identity(1,1),
	vesta varchar(34),
	asocijalno bit not null,
	modelnaocala varchar(43),
	narukvica int not null,
	novcica decimal(15,5) not null
);

create table zarucnik_mladic(
	sifra int not null primary key identity(1,1),
	zarucnik int not null,
	mladic int not null
);

create table ostavljen(
	sifra int not null primary key identity(1,1),
	lipa decimal(14,6),
	introvertno bit not null,
	kratkamajica varchar(38) not null,
	prstena int not null,
	zarucnik int
);

create table prijateljica(
	sifra int not null primary key identity(1,1),
	haljina varchar(45),
	gustoca decimal(15,10) not null,
	ogrlica int,
	novcica decimal(12,5),
	ostavljen int
);

create table sestra(
	sifra int not null primary key identity(1,1),
	bojakose varchar(34) not null,
	hlace varchar(36) not null,
	lipa decimal(15,6),
	stilfrizura varchar(40) not null,
	maraka decimal(12,8) not null,
	prijateljica int 
);

alter table punica add foreign key(cura) references cura(sifra);
alter table sestra add foreign key(prijateljica) references prijateljica(sifra);
alter table prijateljica add foreign key(ostavljen) references ostavljen(sifra);
alter table ostavljen add foreign key(zarucnik) references zarucnik(sifra);
alter table zarucnik_mladic add foreign key(zarucnik) references zarucnik(sifra);
alter table zarucnik_mladic add foreign key(mladic) references mladic(sifra);

--1. U tablice prijateljica, ostavljen i zarucnik_mladic unesite po 3 retka.
select * from zarucnik;
insert into zarucnik(asocijalno,narukvica,novcica)
values  
(1,6,20.99),
(0,3,40.99),
(1,9,50.99);
              
select * from ostavljen;
insert into ostavljen(introvertno,kratkamajica,prstena)
values  
(0,'Plava kratka',7),
(1,'Zelena kratka',3),
(1,'Crna kratka',11);
              
select * from prijateljica;
insert into prijateljica(gustoca,ostavljen)
values  
(11.33,1),
(22.44,2),
(33.55,3);
              
select * from mladic;
insert into mladic(lipa,narukvica,drugiputa)
values  
(10.11,4,'2013-11-05'),
(32.53,8,'2013-11-05'),
(13.74,2,'2013-11-05');
              
select * from zarucnik_mladic;
insert into zarucnik_mladic(zarucnik,mladic)
values  
(1,3),
(2,2),
(3,1);

--2. U tablici punica postavite svim zapisima kolonu eura na vrijednost 15,77.
select * from cura;
insert into cura(lipa)
values  
(33.33),
(32.22),
(44.44);

select * from punica;
insert into punica(eura,cura)
values  
(55.44,1),
(13.55,2),
(23.55,3);
        
update punica set eura=15.77;

--3. U tablici sestra obrišite sve zapise čija je vrijednost kolone hlace manje od AB.
select * from sestra;
insert into sestra(bojakose,hlace,stilfrizura,maraka,prijateljica)
values  ('Plava','Crne','Duga',22.22,1),
        ('Zelena','Plave','Kratka',33.22,2),
        ('Crna','Duge','Kratka',222.12,2);
       
delete from sestra where  hlace<'AB';

--4. Izlistajte kratkamajica iz tablice ostavljen uz uvjet da vrijednost kolone introvertno nepoznate.
select kratkamajica from ostavljen where introvertno is null;

--5.
--Prikažite narukvica iz tablice mladic, stilfrizura iz tablice sestra te gustoca iz tablice prijateljica 

--uz uvjet da su vrijednosti kolone introvertno iz tablice ostavljen poznate 
--te da su vrijednosti kolone asocijalno iz tablice zarucnik poznate. 
--Podatke posložite po gustoca iz tablice prijateljica silazno.
select a.narukvica , f.stilfrizura , e.gustoca 
from mladic a
inner join zarucnik_mladic b on a.sifra      = b.mladic 
inner join zarucnik        c on b.zarucnik   = c.sifra
inner join ostavljen       d on c.sifra      = d.zarucnik 
inner join prijateljica    e on d.sifra      = e.ostavljen
inner join sestra          f on e.sifra      = f.prijateljica 
where d.introvertno is not null and c.asocijalno is not null
order by e.gustoca desc;

--6. Prikažite kolone asocijalno i modelnaocala iz tablice zarucnik 
--čiji se primarni ključ ne nalaze u tablici zarucnik_mladic.
select	a.asocijalno , a.modelnaocala 
from	zarucnik a left join zarucnik_mladic b on b.zarucnik = a.sifra 
where	b.zarucnik is null;