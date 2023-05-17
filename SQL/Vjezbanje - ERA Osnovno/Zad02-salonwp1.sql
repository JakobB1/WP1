use master;
drop database if exists salonwp1;
go
create database salonwp1;
go
use salonwp1;

create table salon(
	sifra int not null primary key identity(1,1),
	naziv varchar(50),
	djelatnica int not null
);

create table djelatnica(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50),
	iban char(21),
	korisnik int not null
);

create table korisnik(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	email varchar(50),
	usluga int not null
);

create table usluga(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	cijena decimal(18,2)
);



alter table salon add foreign key (djelatnica) references djelatnica(sifra);
alter table djelatnica add foreign key (korisnik) references korisnik(sifra);
alter table korisnik add foreign key (usluga) references usluga(sifra);



select * from usluga;
insert into usluga(naziv,cijena)
values ('Usluga01',99.99),
	   ('Usluga02',199.99),
	   ('Usluga03',299.99),
	   ('Usluga04',399.99),
	   ('Usluga05',499.99);


select * from korisnik;
insert into korisnik(ime,prezime,usluga)
values ('Ime01','Prezime01',3),
       ('Ime02','Prezime02',2),
	   ('Ime03','Prezime03',4),
	   ('Ime04','Prezime04',1),
	   ('Ime05','Prezime05',5);


select * from djelatnica;
insert into djelatnica(ime,korisnik)
values ('Ime01',4),
	   ('Ime02',3),
	   ('Ime03',5),
	   ('Ime04',1),
	   ('Ime05',2);


select * from salon;
insert into salon(naziv,djelatnica)
values ('Salon01',3),
	   ('Salon02',4),
	   ('Salon03',5),
	   ('Salon04',2),
	   ('Salon05',1);