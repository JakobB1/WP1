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

select * from prostorija;
insert into prostorija(dimenzije,maks_broj,mjesto)
values ('20x20x30',5,'Mjesto01'),
	   ('30x30x30',5,'Mjesto02'),
	   ('40x40x40',5,'Mjesto03');

select * from datum;
insert into datum(d_rodenja,d_dolaska,d_smrti)
values ('2023-04-26 17:00:00','2023-05-01 18:00:00','2024-01-01 21:00:00'),
	   ('2023-04-26 17:00:00','2023-05-01 18:00:00','2024-01-01 21:00:00'),
	   ('2023-04-26 17:00:00','2023-05-01 18:00:00','2024-01-01 21:00:00');

select * from djelatnik;
insert into djelatnik(ime,prezime,iban)
values ('Ime01','Prezime01',433534635345),
	   ('Ime02','Prezime02',356345345346),
	   ('Ime03','Prezime03',765756757567);

select * from zivotinja;
insert into zivotinja(vrsta,ime,djelatnik,prostorija,datum)
values ('Vrsta01','Ime01',1,2,3),
	   ('Vrsta02','Ime02',3,2,1),
	   ('Vrsta03','Ime03',1,3,2);