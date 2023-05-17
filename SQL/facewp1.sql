use master;
drop database if exists facewp1;
go
create database facewp1;
go
use facewp1;

create table osoba(
	sifra int not null primary key identity(1,1),
	ime varchar(25),
	prezime varchar(25),
	datum_rodenja datetime not null,
	email varchar(50),
	lozinka varchar(60),
	broj_tel int not null,
	slika varchar(100) not null,
	administrator bit,
	stanje bit,
	aktivan bit,
	uniqueid varchar(255)
);

create table svidamise(
	sifra int not null primary key identity(1,1),
	vrijeme_svidanja datetime,
	objava int not null,
	osoba int not null
);

create table svidamise_komentar(
	sifra int not null primary key identity(1,1),
	osoba int not null,
	komentar int not null
);

create table objava(
	sifra int not null primary key identity(1,1),
	naslov varchar(50),
	upis varchar(250),
	vrijeme_izrade datetime,
	ipadres varchar(20) not null,
	osoba int not null
);

create table komentar(
	sifra int not null primary key identity(1,1),
	vrijeme_komentiranja datetime,
	opis varchar(250) not null,
	objava int not null,
	osoba int not null
);