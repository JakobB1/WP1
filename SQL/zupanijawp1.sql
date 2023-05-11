use master;
drop database if exists zupanijawp1;
go
create database zupanijawp1;
go
use zupanijawp1;

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