-- ovo je komentar i neće se izvesti
use master;
drop database if exists edunovawp1Home;
go
create database edunovawp1Home;
go
use edunovawp1Home;

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





-- INSERT
-- najlošiji način
-- 1
insert into smjer
values ('Web programiranje ŠČ',250,1473.82,73,1);

-- malo bolji način
-- 2
insert into smjer (naziv,trajanje)
values ('Java programiranje',130);

-- dobra praksa
-- 3
insert into smjer (naziv,trajanje,cijena,upisnina,verificiran)
values ('Serviser',150,null,null,0);


-- 1
insert into grupa (naziv,smjer,datumpocetka)
values ('WP1',1,'2023-04-26 17:00:00');
-- 2
insert into grupa (naziv,smjer,datumpocetka)
values ('JP28',2,'2023-04-26 19:00:00');


-- 1 do 25
insert into polaznik(ime,prezime,oib,email)
values 
('Luka','Bušić',null,'busic.luka1@gmail.com'),
('Domagoj','Marković',null,'markovicdomagoj1995@gmail.com'),
('Andrija','Kruhoberec',null,'akruhoberec1@outlook.com'),
('Vedran','Džanko',null,'vedran.dzanko@gmail.com'),
('Antonio','Majić', null, 'antonio.majich@gmail.com'),
('Lana','Jelenić',null,'lana.jelenic@gmail.com'),
('Jasenka','Augustinović',null,'jaugustinovic85@gmail.com'),
('Domagoj','Ljubičić',null,'dljubicic2@gmail.com'),
('Leo','Lovenjak',null,'leo.lovenjak107@gmail.com'),
('Leon','Bičak',null,'lbicak96@gmail.com'),
('Katarina','Pavličević',null,'katarina.pavlicevic5@gmail.com'),
('Darko','Kučan',null,'dkucan61@gmail.com'),
('Patrik','Gomerčić',null,'patrik.gomercic3@gmail.com'),
('Antonio','Šubarić',null,'antonio.subaric98@gmail.com'),
('Srđan','Filipović',null,'srdjanfilipovic991@gmail.com'),
('Jakob','Brkić',null,'jakobbrkic97@gmail.com'),
('Alen','Oroz',null,'alen.oroz1@gmail.com'),
('Ivor','Ćelić',null,'ivorcelic@gmail.com'),
('Anja','Andonovski',null,'andonovski.anja@gmail.com'),
('Bruno','Bušić',null,'brunobusic20@gmail.com'),
('Karlo','Perić',null,'karlocar25@gmail.com'),
('Kristijan','Beriša',null,'k_berisa@hotmail.com'),
('Valentin','Mijatović',null,'mijatovic.valentin123@gmail.com'),
('Ivan','Angebrandt',null,'ivan.angebrandt@gmail.com'),
('Luka','Mrđa',null,'luka.mrda@yahoo.com');



insert into clan(grupa,polaznik)
values (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),
(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),
(1,15),(1,16),(1,17),(1,18),(1,19),(1,20),
(1,21),(1,22),(1,23),(1,24),(1,25);





-- vježbanje:
-- 1. Unijeti smjer PHP programiranje
-- 2. Na PHP pregoramiranje definirati dvije grupe (PP17 i PP18)
-- 3. Na PP18 postaviti 3 polaznika (koje ste prethodno unijeli)

-- 1.
select * from smjer;

insert into smjer(naziv,trajanje)
values ('PHP programiranje',180);
-- 2.
select * from grupa;

insert into grupa(naziv,smjer,datumpocetka)
values ('PP17',4,'2023-06-30 17:00:00'),
       ('PP18',4,'2023-12-30 17:00:00');
-- 3.
select * from clan;
insert into clan(grupa,polaznik)
values (4,5),
       (4,10),
	   (4,15);





-- Domaća zadaća:
-- U sve baze koje ste kreirali na osnovu zadatka ERA osnovno unijeti u svaku tablicu po 3 - 5 redova

-- +Rješeno (Folder WP1/SQL/Vjezbanje - ERA Osnovno)





-- PROMJENA PODATAKA

-- ne izvoditi update bez where dijela update naredbe

select * from smjer;
update smjer set naziv='Web programiranje'
where sifra=1;


-- promjeni cijenu serviseru na 1200 EUR i upisninu na 50 EUR
update smjer set
cijena=1200,
upisnina=50
where sifra=3;


-- Vjezba sa nastave
-- select * from grupa;
-- update grupa set smjer=11 where sifra=1;



-- zadatak

-- Ivor Ćelić se udao. Uzeo je ženinno prezime Herc
-- Provedite promjenu u bazi
select * from polaznik;

update polaznik set prezime='Herc' where sifra=18;

-- Leon Bićak ima 
-- novu email adresu: lbicak@ht.hr i njegov oib je 25698545854
select * from polaznik;

update polaznik set email='lbicak@ht.hr' where sifra=10;





-- BRISANJE PODATAKA

-- select * from clan;
-- DELETE naredbe su zakomentirane da nam ne pobrišu podatke
-- delete from clan where grupa=1;

-- delete from grupa where smjer=1;

-- delete from smjer where sifra=1;



-- moguće je promjena i brisanje kroz više tablica
-- ali o tome nakon spajanja tablica

-- Domaća zadaća: Za ponedjeljak (22. 05.) na svoj github postaviti 
-- prvu verziju ER dijagrama završnog rada kao sliku s papira. 

-- +Rješeno (Folder WP1/SQL/Vjezbanje - ERA Osnovno)