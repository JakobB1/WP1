use master;
drop database if exists kolokvij_vjezba_04;
go
create database kolokvij_vjezba_04;
go
use kolokvij_vjezba_04;

--0. Kreirajte tablice i veze između tablica
create table ostavljen(
	sifra int not null primary key identity(1,1),
	modelnaocala varchar(43),
	introvertno bit,
	kuna decimal(14,10)
);

create table punac(
	sifra int not null primary key identity(1,1),
	treciputa datetime,
	majica varchar(46),
	jmbag char(11) not null,
	novcica decimal(18,7) not null,
	maraka decimal(12,6) not null,
	ostavljen int not null
);

create table mladic(
	sifra int not null primary key identity(1,1),
	kuna decimal(15,9),
	lipa decimal(18,5),
	nausnica int,
	stilfrizura varchar(49),
	vesta varchar(34) not null
);

create table zena(
	sifra int not null primary key identity(1,1),
	suknja varchar(39) not null,
	lipa decimal(18,7),
	prstena int not null
);

create table zena_mladic(
	sifra int not null primary key identity(1,1),
	zena int not null,
	mladic int not null
);

create table snasa(
	sifra int not null primary key identity(1,1),
	introvertno bit,
	treciputa datetime,
	haljina varchar(44) not null,
	zena int not null
);

create table becar(
	sifra int not null primary key identity(1,1),
	novcica decimal(14,8),
	kratkamajica varchar(48) not null,
	bojaociju varchar(36) not null,
	snasa int not null
);

create table prijatelj(
	sifra int not null primary key identity(1,1),
	eura decimal(16,9),
	prstena int not null,
	gustoca decimal(16,5),
	jmbag char(11) not null,
	suknja varchar(47) not null,
	becar int not null
);

alter table punac add foreign key(ostavljen) references ostavljen(sifra);
alter table prijatelj add foreign key(becar) references becar(sifra);
alter table becar add foreign key(snasa) references snasa(sifra);
alter table snasa add foreign key(zena) references zena(sifra);
alter table zena_mladic add foreign key(zena) references zena(sifra);
alter table zena_mladic add foreign key(mladic) references mladic(sifra);

--1. U tablice becar, snasa i zena_mladic unesite po 3 retka.
select * from zena
insert into zena(suknja,prstena)
values  
('Zelena suknja',1),
('Plava suknja',2),
('Crna suknja',3)        
       
select * from snasa;
insert into snasa(haljina,zena)
values  
('Crna haljina',1),
('Plava haljina',2),
('Zelena haljina',3);

select * from becar
insert into becar(kratkamajica,bojaociju,snasa)    
values  
('Crna kratka','Crna',1),
('Plava kratka','Zelena',2),
('Zelena kratka','Plava',3);

select * from mladic;
insert into mladic(vesta)
values  
('Crna vesta'),
('Plava vesta'),
('Zelena vesta');
             
select * from zena_mladic;
insert into zena_mladic(zena,mladic)
values 
(1,3),
(2,2),
(3,1);

--2. U tablici punac postavite svim zapisima kolonu majica na vrijednost Osijek.
select * from ostavljen;
insert into ostavljen(modelnaocala)
values
('Naocale01');

select * from punac;
insert into punac(jmbag,novcica,maraka,ostavljen)
values
(11111111111,10.20,20.30,1),
(22222222222,140.20,50.30,1),
(22222222222,30.20,40.30,1);

update punac set majica='Osijek';

--3.U tablici prijatelj obrišite sve zapise čija je vrijednost kolone prstena veće od 17.
select * from prijatelj;
insert into prijatelj(prstena,jmbag ,suknja,becar)
values  
(21,23231321,'Kratka',1),
(15,11231223,'Duga',2),
(23,11231223,'Kratka',3);
        
delete from prijatelj where prstena > 17;

--4. Izlistajte haljina iz tablice snasa uz uvjet da vrijednost kolone treciputa nepoznate.
select * from snasa;
select haljina from snasa where treciputa is null;

--5. 
--Prikažite nausnica iz tablice mladic, jmbag iz tablice prijatelj te kratkamajica iz tablice becar 

--uz uvjet da su vrijednosti kolone treciputa iz tablice snasa poznate 
--te da su vrijednosti kolone lipa iz tablice zena različite od 29. 
--Podatke posložite po kratkamajica iz tablice becar silazno.
select a.nausnica , f.jmbag, e.kratkamajica 
from mladic a
inner join zena_mladic     b on a.sifra     = b.mladic
inner join zena            c on b.zena      = c.sifra
inner join snasa           d on c.sifra     = d.zena
inner join becar           e on d.sifra     = e.snasa
inner join prijatelj       f on e.sifra     = f.becar
where d.treciputa is not null and c.lipa != 29.00
order by e.kratkamajica desc;

--6. Prikažite kolone lipa i prstena iz tablice zena 
--čiji se primarni ključ ne nalaze u tablici zena_mladic.
select	a.lipa, a.prstena 
from	zena a left join zena_mladic b on a.sifra = b.zena
where	b.zena is null; 