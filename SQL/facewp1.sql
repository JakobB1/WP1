use master;
drop database if exists facewp1;
go
create database facewp1;
go
use facewp1;

create table osoba(
	sifra int not null primary key identity(1,1),
	ime varchar(25) not null,
	prezime varchar(25) not null,
	datum_rodenja datetime,
	email varchar(50) not null,
	lozinka varchar(60) not null,
	broj_tel int,
	slika varchar(100),
	administrator bit not null,
	stanje bit not null,
	aktivan bit not null,
	uniqueid varchar(255)
);

create table svidamise(
	sifra int not null primary key identity(1,1),
	vrijeme_svidanja datetime not null,
	objava int,
	osoba int
);

create table svidamise_komentar(
	sifra int not null primary key identity(1,1),
	osoba int,
	komentar int
);

create table objava(
	sifra int not null primary key identity(1,1),
	naslov varchar(50) not null,
	upis varchar(250) not null,
	vrijeme_izrade datetime not null,
	ipadres varchar(20),
	osoba int
);

create table komentar(
	sifra int not null primary key identity(1,1),
	vrijeme_komentiranja datetime not null,
	opis varchar(250),
	objava int,
	osoba int
);



alter table svidamise add foreign key(objava) references objava(sifra);
alter table komentar add foreign key(objava) references objava(sifra);
alter table svidamise_komentar add foreign key(komentar) references komentar(sifra);
alter table objava add foreign key(osoba) references osoba(sifra);


select * from osoba;
insert into osoba(ime,prezime,email,lozinka,administrator,stanje,aktivan)
values	('Ime01','Prezime01','ime01@mail.com','12345',1,1,1),
		('Ime02','Prezime02','ime02@mail.com','45678',0,0,0);