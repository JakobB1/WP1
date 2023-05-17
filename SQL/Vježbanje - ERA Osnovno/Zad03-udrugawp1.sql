use master;
drop database if exists udrugawp1;
go 
create database udrugawp1;
go
use udrugawp1;

create table udruga (
	sifra int not null primary key identity(1,1),
	naziv varchar(50),
	skrbnik int not null
);

create table skrbnik (
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	oib char(11),
	zivotinja int not null
);

create table zivotinja(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prostor int not null
);

create table prostor(
	sifra int not null primary key identity(1,1),
	naziv varchar(50)
);



alter table udruga add foreign key(skrbnik) references skrbnik(sifra);
alter table skrbnik add foreign key(zivotinja) references zivotinja(sifra);
alter table zivotinja add foreign key(prostor) references prostor(sifra);


select * from prostor;
insert into prostor(naziv)
values ('Prostor01'),
       ('Prostor02'),
	   ('Prostor03'),
	   ('Prostor04'),
	   ('Prostor05');


select * from zivotinja;
insert into zivotinja(ime,prostor)
values ('Ime01',3),
       ('Ime02',1),
	   ('Ime03',5),
	   ('Ime04',2),
	   ('Ime05',4);


select * from skrbnik;
insert into skrbnik(ime,prezime,oib,zivotinja)
values ('Ime01','Prezime01',12345678911,3),
       ('Ime02','Prezime02',12345678911,2),
	   ('Ime03','Prezime03',12345678911,1),
	   ('Ime04','Prezime04',12345678911,5),
	   ('Ime05','Prezime05',12345678911,4);


select * from udruga;
insert into udruga(naziv,skrbnik)
values ('Udruga01',1),
	   ('Udruga02',5),
	   ('Udruga03',3),
	   ('Udruga04',2),
	   ('Udruga05',4);
	   