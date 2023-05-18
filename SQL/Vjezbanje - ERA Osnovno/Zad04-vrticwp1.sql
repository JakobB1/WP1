use master;
drop database if exists vrticwp1;
go 
create database vrticwp1;
go
use vrticwp1;

create table vrtic(
	sifra int not null primary key identity(1,1),
	naziv varchar(50),
	odgojnaSkupina int not null
);

create table odgojnaSkupina(
	sifra int not null primary key identity(1,1),
	naziv varchar(50),
	odgajateljica int not null,
	djeca int not null
);

create table odgajateljica(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	oib char(11),
	iban char(21),
	strucnaSprema int not null
);

create table djeca(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null
);

create table strucnaSprema(
	sifra int not null primary key identity(1,1),
	naziv varchar(50)
);



alter table vrtic add foreign key(odgojnaSkupina) references odgojnaSkupina(sifra);
alter table odgojnaSkupina add foreign key(djeca) references djeca(sifra);
alter table odgojnaSkupina add foreign key (odgajateljica) references odgajateljica(sifra);
alter table odgajateljica add foreign key (strucnaSprema) references strucnaSprema(sifra);



select * from strucnaSprema;
insert into strucnaSprema(naziv)
values ('Sprema01'),
       ('Sprema02'),
       ('Sprema03'),
       ('Sprema04'),
       ('Sprema05');


select * from djeca;
insert into djeca(ime,prezime)
values ('Ime01','Prezime01'),
       ('Ime02','Prezime02'),
	   ('Ime03','Prezime03'),
	   ('Ime04','Prezime04'),
	   ('Ime05','Prezime05');


select * from odgajateljica;
insert into odgajateljica(ime,prezime,strucnaSprema)
values ('Ime01','Prezime01',3),
       ('Ime02','Prezime02',2),
	   ('Ime03','Prezime03',4),
	   ('Ime04','Prezime04',5),
	   ('Ime05','Prezime05',1);


select * from odgojnaSkupina;
insert into odgojnaSkupina(naziv,odgajateljica,djeca)
values ('Skupina01',2,3),		
       ('Skupina02',3,2),
	   ('Skupina03',4,3),
	   ('Skupina04',5,5),
	   ('Skupina05',1,1);


select * from vrtic;
insert into vrtic(naziv,odgojnaSkupina)
values ('Vrtic01',4),
       ('Vrtic02',3),
	   ('Vrtic03',5),
	   ('Vrtic04',2),
	   ('Vrtic05',1);