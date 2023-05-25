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



-- ZUPAN
select * from zupan;
-- Insert
select * from zupan;
insert into zupan(ime,prezime)
values ('Pero','Perić'),
	   ('Marko','Marković'),
	   ('Ivo','Ivić');



-- ZUPANIJA
select * from zupanija;
-- Insert
insert into zupanija(naziv,zupan)
values ('Zupanija01',1),
	   ('Zupanija02',2),
	   ('Zupanija03',3);



-- OPCINA
select * from opcina;
-- Insert
insert into opcina(zupanija,naziv)
values (1,'Opcina01'),
	   (1,'Opcina02'),
	   (2,'Opcina03'),
	   (2,'Opcina04'),
	   (3,'Opcina05'),
	   (3,'Opcina06');
-- Delete
delete from opcina where sifra=4;
delete from opcina where sifra=2;



-- MJESTO
select * from mjesto;
-- Insert
insert into mjesto(opcina,naziv)
values (1,'Mjesto01'),
	   (1,'Mjesto02'),
	   (1,'Mjesto03'),
	   (1,'Mjesto04'),
	   (3,'Mjesto05'),
	   (1,'Mjesto06'),
	   (1,'Mjesto07'),
	   (3,'Mjesto08'),
	   (3,'Mjesto09'),
	   (3,'Mjesto10'),
	   (3,'Mjesto11'),
	   (3,'Mjesto12');
-- Update
update mjesto set naziv='NovoMjesto01' where sifra=1;
update mjesto set naziv='NovoMjesto04' where sifra=4;
update mjesto set naziv='NovoMjesto06' where sifra=6;
update mjesto set naziv='NovoMjesto010' where sifra=10;
update mjesto set naziv='NovoMjesto03' where sifra=3;