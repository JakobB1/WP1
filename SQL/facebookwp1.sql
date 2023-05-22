use master;
drop database if exists facebookwp1;
go
create database facebookwp1;
go
use facebookwp1;

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



select * from svidamise;
--Insert
insert into svidamise(vrijeme_svidanja)
values ('2023-06-22 11:10:30'),
	   ('2023-06-22 12:10:30'),
	   ('2023-10-22 13:20:30'),
	   ('2023-07-22 14:30:35'),
	   ('2023-08-22 15:40:30'),
	   ('2023-06-22 16:50:30');
--Update
update svidamise set vrijeme_svidanja='2024-06-22 11:10:30'
where sifra=1;
update svidamise set vrijeme_svidanja='2024-06-22 12:10:30'
where sifra=2;
update svidamise set vrijeme_svidanja='2024-10-22 13:20:30'
where sifra=3;
--Delete
delete from svidamise where sifra=4;
delete from svidamise where sifra=5;
delete from svidamise where sifra=6;



select * from osoba;
-- Insert
insert into osoba(ime,prezime,email,lozinka,administrator,stanje,aktivan)
values	('Ime01','Prezime01','ime01@mail.com','02942',1,1,1),
        ('Ime02','Prezime02','ime02@mail.com','39521',0,0,0),
		('Ime03','Prezime03','ime03@mail.com','48923',1,1,1),
		('Ime04','Prezime04','ime04@mail.com','43263',0,1,1),
		('Ime05','Prezime05','ime05@mail.com','85454',0,0,0),
		('Ime06','Prezime06','ime06@mail.com','12420',0,1,1);
--Update
update osoba set ime='NovoIme01'
where sifra=1;
update osoba set ime='NovoIme02'
where sifra=2;
update osoba set ime='NovoIme03'
where sifra=3;
--Delete
delete from osoba where sifra=4;
delete from osoba where sifra=5;
delete from osoba where sifra=6;



select * from objava;
--Insert
insert into objava(naslov,upis,vrijeme_izrade)
values ('Naslov01','Upis01','2023-05-22 15:40:30'),
	   ('Naslov02','Upis02','2023-05-21 13:30:00'),
	   ('Naslov03','Upis03','2023-05-20 14:00:25');
--Update
update objava set
naslov='NoviNaslov01',
upis='Noviupis01',
vrijeme_izrade='2023-05-20 14:00:25'
where sifra=1;


select * from komentar;
insert into komentar(vrijeme_komentiranja,opis)
values ('2023-07-22 23:40:30','Opis01'),
	   ('2023-07-22 21:40:30','Opis02'),
	   ('2023-07-22 22:40:30','Opis03');