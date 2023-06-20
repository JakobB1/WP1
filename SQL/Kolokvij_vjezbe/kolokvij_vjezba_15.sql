use master;
drop database if exists kolokvij_vjezba_15;
go
create database kolokvij_vjezba_15;
go
use kolokvij_vjezba_15;

--0. Kreirajte tablice i veze između tablica
create table brat(
	sifra int not null primary key identity(1,1),
	bojakose varchar(49) not null,
	majica varchar(36),
	maraka decimal(17,9),
	vesta varchar(30) not null
);

create table prijateljica(
	sifra int not null primary key identity(1,1),
	kratkamajica varchar(30) not null,
	bojakose varchar(45),
	asocijalno bit not null,
	treciputa datetime not null,
	jmbag char(11) not null,
	vesta varchar(42) not null,
	brat int
);

create table ostavljena(
	sifra int not null primary key identity(1,1),
	gustoca decimal(16,7),
	stilfrizura varchar(31) not null,
	ogrlica int,
	maraka decimal(15,10)
);

create table zarucnik(
	sifra int not null primary key identity(1,1),
	kratkamajica varchar(30) not null,
	jmbag char(11) not null,
	dukserica varchar(45) not null,
	indiferentno bit,
	treciputa datetime not null
);

create table zarucnik_ostavljena(
	sifra int not null primary key identity(1,1),
	zarucnik int not null,
	ostavljena int not null
);

create table zarucnica(
	sifra int not null primary key identity(1,1),
	prviputa datetime not null,
	bojaociju varchar(31) not null,
	modelnaocala varchar(40),
	zarucnik int
);

create table prijatelj(
	sifra int not null primary key identity(1,1),
	majica varchar(41) not null,
	vesta varchar(30),
	narukvica int not null,
	zarucnica int
);

create table decko(
	sifra int not null primary key identity(1,1),
	vesta varchar(37) not null,
	bojakose varchar(45),
	gustoca decimal(18,7),
	prijatelj int not null
);

alter table prijateljica add foreign key(brat) references brat(sifra);
alter table decko add foreign key(prijatelj) references prijatelj(sifra);
alter table prijatelj add foreign key(zarucnica) references zarucnica(sifra);
alter table zarucnica add foreign key(zarucnik) references zarucnik(sifra);
alter table zarucnik_ostavljena add foreign key(zarucnik) references zarucnik(sifra);
alter table zarucnik_ostavljena add foreign key(ostavljena) references ostavljena(sifra);

--1. U tablice prijatelj, zarucnica i zarucnik_ostavljena unesite po 3 retka
select * from ostavljena;
insert into ostavljena(stilfrizura)
values 
('Kratka'),
('Duga'),
('Srednja');

select * from zarucnik;
insert into zarucnik(kratkamajica,jmbag,dukserica,treciputa)
values 
('Crna',11111111111,'Plava','2022-04-23'),
('Plava',22222222222,'Crna','2023-04-23'),
('Crna',33333333333,'Plava','2021-04-23');

select * from zarucnik_ostavljena;
insert into zarucnik_ostavljena(zarucnik,ostavljena)
values 
(1,3),
(2,2),
(3,1);

select * from zarucnica;
insert into zarucnica(prviputa,bojaociju)
values
('2021-05-21','Plava'),
('2022-05-21','Smeda'),
('2023-05-21','Zelena');

select * from prijatelj;
insert into prijatelj(majica,narukvica)
values
('Plava',2),
('Crvena',4),
('Zelena',5);

--2. U tablici prijateljica postavite svim zapisima kolonu bojakose na vrijednost Osijek.
update prijateljica set bojakose ='Osijek';

--3. U tablici decko obrišite sve zapise čija je vrijednost kolone bojakose jednako AB.
delete from decko where bojakose ='AB';

--4. Izlistajte modelnaocala iz tablice zarucnica uz uvjet da vrijednost kolone bojaociju sadrže slova ana.
select modelnaocala from zarucnica where bojaociju like '%ana%';

--5.
--Prikažite ogrlica iz tablice ostavljena, prijatelj iz tablice decko te vesta iz tablice prijatelj 

--uz uvjet da su vrijednosti kolone bojaociju iz tablice zarucnica počinju slovom a 
--te da su vrijednosti kolone jmbag iz tablice zarucnik poznate. 
--Podatke posložite po vesta iz tablice prijatelj silazno.
select a.ogrlica , f.prijatelj , e.vesta 
from ostavljena a 
inner join zarucnik_ostavljena	b on a.sifra		=b.ostavljena 
inner join zarucnik				c on b.zarucnik		=c.sifra 
inner join zarucnica			d on c.sifra		=d.zarucnik 
inner join prijatelj			e on d.sifra		=e.zarucnica 
inner join decko				f on e.sifra		=f.sifra
where d.bojaociju like 'a%' and e.vesta is not null
order by e.vesta desc;

--6. Prikažite kolone jmbag i dukserica iz tablice zarucnik 
--čiji se primarni ključ ne nalaze u tablici zarucnik_ostavljena.
select	a.jmbag , a.dukserica
from	zarucnik a left join zarucnik_ostavljena b on b.zarucnik=a.sifra 
where	b.zarucnik = null;