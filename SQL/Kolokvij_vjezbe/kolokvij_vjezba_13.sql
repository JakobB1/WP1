use master;
drop database if exists kolokvij_vjezba_13;
go
create database kolokvij_vjezba_13;
go
use kolokvij_vjezba_13;

--0. Kreirajte tablice i veze između tablica
create table muskarac(
	sifra int not null primary key identity(1,1),
	dukserica varchar(34),
	gustoca decimal(13,10),
	haljina varchar(42) not null,
	majica varchar(39),
	suknja varchar(50) not null,
	kuna decimal(17,9) not null
);

create table neprijatelj(
	sifra int not null primary key identity(1,1),
	bojakose varchar(32),
	novcica decimal(12,6) not null,
	prviputa datetime,
	indiferentno bit not null,
	suknja varchar(44),
	jmbag char(11),
	muskarac int not null
);

create table svekar(
	sifra int not null primary key identity(1,1),
	suknja varchar(40),
	stilfrizura varchar(34) not null,
	gustoca decimal(15,10) not null,
	carape varchar(35) not null
);

create table svekrva(
	sifra int not null primary key identity(1,1),
	hlace varchar(35),
	ogrlica int,
	ekstrovertno bit not null,
	narukvica int 
);

create table svekrva_svekar(
	sifra int not null primary key identity(1,1),
	svekrva int not null,
	svekar int not null
);

create table ostavljen(
	sifra int not null primary key identity(1,1),
	kratkamajica varchar(34),
	drugiputa datetime,
	asocijalno bit not null,
	stilfrizura varchar(40),
	svekrva int not null
);

create table mladic(
	sifra int not null primary key identity(1,1),
	drugiputa datetime not null,
	carape varchar(48) not null,
	ogrlica int,
	kratkamajica varchar(42) not null,
	introvertno bit not null,
	asocijalno bit not null,
	ostavljen int 
);

create table cura(
	sifra int not null primary key identity(1,1),
	ogrlica int,
	hlace varchar(42),
	vesta varchar(31) not null,
	majica varchar(50),
	mladic int
);

alter table neprijatelj add foreign key(muskarac) references muskarac(sifra);
alter table cura add foreign key(mladic) references mladic(sifra);
alter table mladic add foreign key(ostavljen) references ostavljen(sifra);
alter table ostavljen add foreign key(svekrva) references svekrva(sifra);
alter table svekrva_svekar add foreign key(svekrva) references svekrva(sifra);
alter table svekrva_svekar add foreign key(svekar) references svekar(sifra);

--1. U tablice mladic, ostavljen i svekrva_svekar unesite po 3 retka.
select * from svekrva;
insert into svekrva(ekstrovertno,narukvica)
values  
(1,3),
(0,7),
(0,2);
       
select * from ostavljen;
insert into ostavljen(asocijalno,svekrva)
values  
(0,1),
(1,2),
(0,3);
        
select * from mladic;
insert into mladic(drugiputa,carape,kratkamajica,introvertno,asocijalno,ostavljen)  
values  
('2013-04-12',5,4,1,0,1),
('2013-04-12',5,4,1,0,2),
('2013-04-12',5,4,1,0,3);
        
select * from svekar;
insert into svekar(stilfrizura,gustoca,carape)
values  
('Kratka',11,3),
('Kratka',12,2),
('Kratka',13,4);

select * from svekrva_svekar;
insert into svekrva_svekar(svekrva,svekar)
values  
(1,3),
(1,3),
(1,3);

--2. U tablici neprijatelj postavite svim zapisima kolonu novcica na vrijednost 13,77.
update neprijatelj set novcica=13.77;  

--3. U tablici cura obrišite sve zapise čija je vrijednost kolone hlace različito od AB.
delete from cura where hlace like '%AB%';

--4. Izlistajte asocijalno iz tablice ostavljen uz uvjet da vrijednost kolone drugiputa nepoznate.
select asocijalno from ostavljen where drugiputa is null;

--5.
--5. Prikažite gustoca iz tablice svekar, majica iz tablice cura te carape iz tablice mladic 

--uz uvjet da su vrijednosti kolone drugiputa iz tablice ostavljen poznate 
--te da su vrijednosti kolone ogrlica iz tablice svekrva jednake broju 193. 
--Podatke posložite po carape iz tablice mladic silazno.
select a.gustoca , f.majica , e.carape 
from svekar a
inner join svekrva_svekar b on a.sifra = b.svekar 
inner join svekrva c on b.svekrva = c.sifra 
inner join ostavljen d on c.sifra=d.svekrva 
inner join mladic e on d.sifra=e.ostavljen
inner join cura f on e.sifra= f.mladic
where d.drugiputa is not null and c.ogrlica =193
order by e.carape desc;

--6. Prikažite kolone ogrlica i ekstroventno iz tablice svekrva 
--čiji se primarni ključ ne nalaze u tablici svekrva_svekar.
select	a.ogrlica , a.ekstrovertno 
from	svekrva a left join svekrva_svekar b on a.sifra=b.svekrva
where	b.svekrva is null;