use master;
drop database if exists kolokvij_vjezba_20;
go
create database kolokvij_vjezba_20;
go
use kolokvij_vjezba_20;

--0. Kreirajte tablice i veze između tablica
create table zena(
	sifra int not null primary key identity(1,1),
	asocijalno bit not null,
	nausnica int,
	jmbag char(11) not null,
	bojaociju varchar(41),
	kratkamajica varchar(30)
);

create table neprijateljica(
	sifra int not null primary key identity(1,1),
	introvertno bit not null,
	nausnica int,
	gustoca decimal(17,8),
	lipa decimal(17,8),
	jmbag char(11) not null,
	zena int
);

create table zarucnik(
	sifra int not null primary key identity(1,1),
	suknja varchar(31),
	prstena int not null,
	modelnaocala varchar(46) not null,
	novcica decimal(17,5) not null,
	gustoca decimal(17,8)
);

create table mladic(
	sifra int not null primary key identity(1,1),
	hlace varchar(47),
	suknja varchar(50),
	haljina varchar(50) not null,
	prstena int not null,
	treciputa datetime not null,
	introvertno bit not null
);

create table mladic_zarucnik(
	sifra int not null primary key identity(1,1),
	mladic int not null,
	zarucnik int not null
);

create table punica(
	sifra int not null primary key identity(1,1),
	ogrlica int,
	prviputa datetime,
	drugiputa datetime not null,
	introvertno bit,
	treciputa datetime,
	mladic int not null
);

create table decko(
	sifra int not null primary key identity(1,1),
	kuna decimal(14,5),
	novcica decimal(15,7),
	indiferentno bit not null,
	maraka decimal(16,9) not null,
	punica int not null
);

create table zarucnica(
	sifra int not null primary key identity(1,1),
	modelnaocala varchar(50),
	suknja varchar(49) not null,
	prviputa datetime,
	treciputa datetime,
	decko int
);

alter table neprijateljica add foreign key(zena) references zena(sifra);
alter table zarucnica add foreign key(decko) references decko(sifra);
alter table decko add foreign key(punica) references punica(sifra);
alter table punica add foreign key(mladic) references mladic(sifra);
alter table mladic_zarucnik add foreign key(mladic) references mladic(sifra);
alter table mladic_zarucnik add foreign key(zarucnik) references zarucnik(sifra);

--1. U tablice decko, punica i mladic_zarucnik unesite po 3 retka.
select * from mladic;
insert into mladic(haljina,prstena,treciputa,introvertno)
values  
('Plava',2,'2013-12-03',0),
('Crvena',3,'2014-12-10',0),
('Zelena',4,'2015-12-23',1);

        

select * from punica;
insert into punica(drugiputa,mladic)
values  
('2020-11-11',1),
('2020-11-21',2),
('2020-11-15',3);

select * from decko;
insert into decko(indiferentno,maraka,punica)
values 
(0,10.20,1),
(1,20.20,2),
(0,30.20,3);

select * from zarucnik;
insert into zarucnik(prstena,modelnaocala,novcica)
values  
(3,'Suncane',20.10),
(6,'Dioptrijske',30.10),
(8,'RayBan',40.10);

select * from mladic_zarucnik;
insert into mladic_zarucnik(mladic,zarucnik)
values  
(1,3),
(2,2),
(3,1);

--2. U tablici neprijateljica postavite svim zapisima kolonu nausnica na vrijednost 10.
update neprijateljica set nausnica = 10;

--3. U tablici zarucnica obrišite sve zapise čija je vrijednost kolone suknja manje od AB.
delete from zarucnica where  suknja <'AB';      

--4. Izlistajte drugiputa iz tablice punica uz uvjet da vrijednost kolone prviputa nepoznate.
select drugiputa from punica where prviputa is null;

--5.
--Prikažite modelnaocala iz tablice zarucnik, treciputa iz tablice zarucnica te novcica iz tablice decko

--uz uvjet da su vrijednosti kolone prviputa iz tablice punica poznate 
--te da su vrijednosti kolone suknja iz tablice mladic sadrže niz znakova ba. 
--Podatke posložite po novcica iz tablice decko silazno
select a.modelnaocala , f.treciputa , e.novcica 
from zarucnik a
inner join mladic_zarucnik       b on a.sifra      = b.zarucnik 
inner join mladic                c on b.mladic     = c.sifra
inner join punica                d on c.sifra      = d.mladic 
inner join decko                 e on d.sifra      = e.punica
inner join zarucnica             f on e.sifra      = f.decko
where d.prviputa is null and c.suknja like '%ba%'
order by e.novcica desc;

--6. Prikažite kolone suknja i haljina iz tablice mladic 
--čiji se primarni ključ ne nalaze u tablici mladic_zarucnik.
select	a.suknja , a.haljina 
from	mladic a left join mladic_zarucnik b on b.mladic = a.sifra
where	b.mladic is null;  