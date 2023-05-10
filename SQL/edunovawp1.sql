-- ovo je komentar i neće se izvesti
use master;
drop database if exists edunovawp1;
go
create database edunovawp1;
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