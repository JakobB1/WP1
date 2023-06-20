use master;
drop database if exists kolokvij_vjezba_18;
go
create database kolokvij_vjezba_18;
go
use kolokvij_vjezba_18;

--0. Kreirajte tablice i veze između tablica
create table ostavljena(
	sifra int not null primary key identity(1,1),
	novcica decimal(18,9),
	drugiputa datetime not null,
	dukserica varchar(35),
	kratkamajica varchar(34),
	djevojka int not null
);

create table djevojka(
	sifra int not null primary key identity(1,1),
	bojaociju varchar(43) not null,
	treciputa datetime not null,
	carape varchar(32) not null
);

create table prijatelj(
	sifra int not null primary key identity(1,1),
	novcica decimal(15,9),
	ekstrovertno bit not null,
	bojakose varchar(30) not null,
	haljina varchar(37),
	narukvica int
);

create table muskarac(
	sifra int not null primary key identity(1,1),
	treciputa datetime,
	nausnica int not null,
	drugiputa datetime not null,
	prstena int not null,
	modelnaocala varchar(34)
);

create table muskarac_prijatelj(
	sifra int not null primary key identity(1,1),
	muskarac int not null,
	prijatelj int not null
);

create table mladic(
	sifra int not null primary key identity(1,1),
	carape varchar(50) not null,
	jmbag char(11),
	hlace varchar(50) not null,
	treciputa datetime,
	drugiputa datetime not null,
	muskarac int
);

create table sestra(
	sifra int not null primary key identity(1,1),
	eura decimal(14,10),
	indiferentno bit,
	maraka decimal(13,8),
	ogrlica int,
	haljina varchar(31) not null,
	introvertno bit,
	mladic int
);

create table zarucnica(
	sifra int not null primary key identity(1,1),
	carape varchar(43),
	treciputa datetime not null,
	eura decimal(16,8),
	sestra int
);

alter table ostavljena add foreign key(djevojka) references djevojka(sifra);
alter table zarucnica add foreign key(sestra) references sestra(sifra);
alter table sestra add foreign key(mladic) references mladic(sifra);
alter table mladic add foreign key(muskarac) references muskarac(sifra);
alter table muskarac_prijatelj add foreign key(muskarac) references muskarac(sifra);
alter table muskarac_prijatelj add foreign key(prijatelj) references prijatelj(sifra);

--1. U tablice sestra, mladic i muskarac_prijatelj unesite po 3 retka.
select * from muskarac;
insert into muskarac(nausnica,drugiputa,prstena)
values  
(3,'2021-03-01',9),
(6,'2021-02-11',3),
(8,'2021-01-21',7);

select * from mladic;
insert into mladic(carape,hlace,drugiputa)
values  
('Plave','Zelene','2019-04-11'),
('Zelene','Plave','2019-03-21'),
('Zute','Crvene','2019-06-01');

select * from sestra;
insert into sestra(haljina)
values  
('Plava'),
('Zuta'),
('Zelena');

select * from prijatelj;
insert into prijatelj(ekstrovertno,bojakose)
values
(0,'Plava'),
(1,'Zelena'),
(1,'Zuta');

select * from muskarac_prijatelj;
insert into muskarac_prijatelj(muskarac,prijatelj)
values  
(1,3),
(2,2),
(3,1);

--2. U tablici ostavljena postavite svim zapisima kolonu drugiputa na vrijednost 7. travnja 2016.
update ostavljena set drugiputa = '2016-04-07';

--3. U tablici zarucnica obrišite sve zapise čija je vrijednost kolone treciputa 18. travnja 2015.
delete from zarucnica where treciputa='2015-04-18';

--4. Izlistajte hlace iz tablice mladic uz uvjet da vrijednost kolone jmbag nepoznate.
select hlace from mladic where jmbag is null;

--5.
--Prikažite bojakose iz tablice prijatelj, sestra iz tablice zarucnica te indiferentno iz tablice sestra 

--uz uvjet da su vrijednosti kolone jmbag iz tablice mladic poznate 
--te da su vrijednosti kolone nausnica iz tablice muskarac jednake broju 213. 
--Podatke posložite po indiferentno iz tablice sestra silazno.
select a.bojakose , f.sestra , e.indiferentno
from prijatelj a
inner join muskarac_prijatelj   b on a.sifra      = b.prijatelj 
inner join muskarac             c on b.muskarac   = c.sifra
inner join mladic               d on c.sifra      = d.muskarac 
inner join sestra               e on d.sifra      = e.mladic
inner join zarucnica            f on e.sifra      = f.sestra
where d.jmbag is null  and c.nausnica = 213
order by e.indiferentno desc;

--6. Prikažite kolone nausnica i drugiputa iz tablice muskarac 
--čiji se primarni ključ ne nalaze u tablici muskarac_prijatelj.
select	a.nausnica , a.drugiputa 
from	muskarac a left join muskarac_prijatelj b on b.muskarac = a.sifra
where	b.muskarac is null;