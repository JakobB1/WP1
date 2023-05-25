use master;
drop database if exists zoowp1;
go
create database zoowp1;
go
use zoowp1;

create table zivotinja(
	sifra int not null primary key identity(1,1),
	vrsta varchar(50) not null,
	ime varchar(50) not null,
	djelatnik int not null,
	prostorija int not null,
	datum int not null
);

create table djelatnik(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	iban varchar(50)
);

create table datum(
	sifra int not null primary key identity(1,1),
	d_rodenja datetime not null,
	d_dolaska datetime not null,
	d_smrti datetime not null
);

create table prostorija(
	sifra int not null primary key identity(1,1),
	dimenzije varchar(30) not null,
	maks_broj int not null,
	mjesto varchar(30) not null
);


alter table zivotinja add foreign key(djelatnik) references djelatnik(sifra);
alter table zivotinja add foreign key(prostorija) references prostorija(sifra);
alter table zivotinja add foreign key(datum) references datum(sifra);



-- PROSTORIJA
select * from prostorija;
-- Insert
insert into prostorija(dimenzije,maks_broj,mjesto)
values ('20x20x30',1,'Mjesto01'),
	   ('30x30x30',2,'Mjesto02'),
	   ('40x40x40',3,'Mjesto03'),
	   ('50x50x50',4,'Mjesto04'),
	   ('60x60x60',5,'Mjesto05'),
	   ('70x70x70',6,'Mjesto06');
-- Update
update prostorija set mjesto='NovoMjesto01' where sifra=1;
update prostorija set mjesto='NovoMjesto02' where sifra=2;
update prostorija set mjesto='NovoMjesto03' where sifra=3;
-- Delete
delete from prostorija where sifra=4;
delete from prostorija where sifra=5;
delete from prostorija where sifra=6;



-- DATUM
select * from datum;
-- Insert
insert into datum(d_rodenja,d_dolaska,d_smrti)
values ('2021-01-21 15:00:00','2022-02-02 13:00:00','2023-03-03 22:00:00'),
	   ('2022-02-22 16:00:00','2023-03-03 11:00:00','2024-04-04 15:00:00'),
	   ('2023-03-23 17:00:00','2024-04-04 12:00:00','2025-05-05 21:00:00'),
	   ('2024-04-24 18:00:00','2025-05-05 15:00:00','2026-06-06 21:00:00'),
	   ('2025-05-25 19:00:00','2026-06-06 16:00:00','2027-07-07 23:00:00'),
	   ('2026-06-26 20:00:00','2027-07-07 18:00:00','2028-08-08 22:00:00');
-- Update
update datum set d_rodenja='2001-01-21 15:00:00' where sifra=1;
update datum set d_dolaska='2002-01-21 15:00:00' where sifra=2;
update datum set d_smrti='2003-01-21 15:00:00' where sifra=3;
-- Delete
delete from datum where sifra=4;
delete from datum where sifra=5;
delete from datum where sifra=6;



-- DJELATNIK
select * from djelatnik;
-- Insert
insert into djelatnik(ime,prezime,iban)
values ('Ime01','Prezime01',433534635345),
	   ('Ime02','Prezime02',356345345346),
	   ('Ime03','Prezime03',765756757567),
	   ('Ime04','Prezime04',234236524234),
	   ('Ime05','Prezime05',756735687221),
	   ('Ime06','Prezime06',634634124444);
-- Update
update djelatnik set 
ime='NovoIme01',
prezime='NovoPrezime01',
iban=153534635345
where sifra=1;

update djelatnik set 
ime='NovoIme02',
prezime='NovoPrezime03',
iban=0535346353455
where sifra=2;

update djelatnik set 
ime='NovoIme03',
prezime='NovoPrezime03',
iban=953534635345
where sifra=3;
-- Delete
delete from djelatnik where sifra=4;
delete from djelatnik where sifra=5;
delete from djelatnik where sifra=6;

-- ZIVOTINJA
select * from zivotinja;
-- Insert 
insert into zivotinja(vrsta,ime,djelatnik,prostorija,datum)
values ('Vrsta01','Ime01',1,2,3),
	   ('Vrsta02','Ime02',3,2,1),
	   ('Vrsta03','Ime03',1,3,2),
	   ('Vrsta04','Ime04',2,1,3),
	   ('Vrsta05','Ime05',2,3,1),
	   ('Vrsta06','Ime06',3,3,3);

-- Update
update zivotinja set 
vrsta='NovaVrsta01',
ime='NovoIme01',
djelatnik=3,
prostorija=3,
datum=1
where sifra=1;

update zivotinja set 
vrsta='NovaVrsta02',
ime='NovoIme02',
djelatnik=2,
prostorija=2,
datum=2
where sifra=2;

update zivotinja set 
vrsta='NovaVrsta03',
ime='NovoIme03',
djelatnik=1,
prostorija=3,
datum=2
where sifra=3;
-- Delete
delete from zivotinja where sifra=4;
delete from zivotinja where sifra=5;
delete from zivotinja where sifra=6;