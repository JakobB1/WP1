use master;
drop database if exists samoupravawp1;
go
create database samoupravawp1;
go
use samoupravawp1;

create table zupan(
	sifra int not null primary key identity(1,1),
	ime varchar(50),
	prezime varchar(50)
);

create table zupanija(
	sifra int not null primary key identity(1,1),
	naziv varchar(50),
	zupan int
);

create table opcina(
	sifra int not null primary key identity(1,1),
	zupanija int,
	naziv varchar(50)
);

create table mjesto(
	sifra int not null primary key identity(1,1),
	opcina int,
	naziv varchar(50)
);

alter table zupanija add foreign key (zupan) references zupan(sifra);
alter table opcina add foreign key (zupanija) references zupanija(sifra);
alter table mjesto add foreign key (opcina) references opcina(sifra);


select * from zupan;
insert into zupan(ime,prezime)
values ('Pero','Perić'),
	   ('Marko','Marković'),
	   ('Ivo','Ivić');


select * from zupanija;
insert into zupanija(naziv,zupan)
values ('Zupanija1',1),
	   ('Zupanija2',2),
	   ('Zupanija3',3);


select * from opcina;
insert into opcina(zupanija,naziv)
values (1,'Opcina1'),
	   (1,'Opcina2'),
	   (2,'Opcina3'),
	   (2,'Opcina4'),
	   (3,'Opcina5'),
	   (3,'Opcina6');

select * from mjesto;
insert into mjesto(opcina,naziv)
values (1,'Mjesto1'),
	   (1,'Mjesto2'),
	   (1,'Mjesto3'),
	   (1,'Mjesto4'),
	   (2,'Mjesto5'),
	   (2,'Mjesto6'),
	   (2,'Mjesto7'),
	   (2,'Mjesto8'),
	   (3,'Mjesto9'),
	   (3,'Mjesto10'),
	   (3,'Mjesto11'),
	   (3,'Mjesto12');