-- ovo je komentar i neće se izvesti
use master;
drop database if exists edunovawp1;
go
create database edunovawp1 collate Croatian_CI_AS;
go
use edunovawp1;
create table smjer(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	trajanje int not null,
	cijena decimal(18,2) null, --ako je null ne treba se pisati null
	upisnina decimal(18,2),
	verificiran bit
);

create table polaznik(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	oib char(11),
	email varchar(100)
);

create table grupa(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	smjer int not null, 
	datumpocetka datetime
);

create table clan(
	grupa int not null,
	polaznik int not null
);


-- veze između tablica

alter table grupa add foreign key (smjer) references smjer(sifra);
alter table clan add foreign key (grupa) references grupa(sifra);
alter table clan add foreign key (polaznik) references polaznik(sifra);
select * from smjer;
-- najlošiji način
-- 1
insert into smjer 
values ('Web programiranje ŠĆ',250,1473.82,73,1);

--malo bolji način
-- 2
insert into smjer(naziv,trajanje)
values ('Java programiranje',130);

-- dobra praksa
-- 3
insert into smjer (naziv,trajanje,cijena,upisnina,verificiran)
values ('Serviser',150,null,null,0);

select * from grupa;
-- 1
insert into grupa(naziv,smjer,datumpocetka)
values ('WP1',1,'2023-04-26 17:00:00');
-- 2
insert into grupa(naziv,smjer,datumpocetka)
values ('JP28',2,'2023-04-26 19:00:00');

select * from polaznik;

insert into polaznik(ime,prezime,oib,email)
values 
('Luka','Bušić',null,'busic.luka1@gmail.com'),
('Ivan','Angebrandt',null,'ivan.angebrandt@gmail.com'),
('Luka','Mrđa',null,'luka.mrda@yahoo.com');

select * from clan;

insert into clan(grupa,polaznik)
values (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),
(1,17),(1,18),(1,19),(1,20),
(1,21),(1,22),(1,23),(1,24),(1,25);




-- vjezbanje:
-- 1. Unijeti smjer PHP programiranje 
-- 2. Na PHP programiranje definirati dvije grupa (PP17 i PP17)
-- 3. Na PP18 postaviti 3 polaznika (koje ste prethodno unijeli)

-- 1. zadatak
select * from smjer;
insert into smjer (naziv,trajanje,cijena,upisnina,verificiran)
values ('PHP programiranje',160,1999.99,49.99,0);

-- 2.zadatak
select * from grupa;
insert into grupa(naziv,smjer,datumpocetka)
values ('PP17',4,'2023-04-27 17:00:00');
insert into grupa(naziv,smjer,datumpocetka)
values ('PP18',4,'2023-04-27 19:00:00');

-- 3.zadatak
select * from smjer;