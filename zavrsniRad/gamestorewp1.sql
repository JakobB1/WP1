use master;
drop database if exists gamestorewp1;
go
create database gamestorewp1;
go
use gamestorewp1;

create table izdavac(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	drzava varchar(50) not null,
	web_stranica varchar(50) not null
);

create table igra(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	izdavac_id int not null,
	zanr varchar(50) not null,
	cijena decimal(18,2) not null,
	dobna_granica int not null,
	datum_izlaska datetime not null,
	opis varchar(50) not null
);

create table korisnik(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	oib char(11),
	email varchar(50) not null
);

create table narudzba(
	sifra int not null primary key identity(1,1),
	korisnik_id int not null,
	placanje varchar(50) not null,
	datum datetime not null
);

create table narudzba_igra(
	sifra int not null primary key identity(1,1),
	igra_id int not null,
	narudzba_id int not null,
	kolicina int not null
);



alter table igra add foreign key(izdavac_id) references izdavac(sifra);
alter table narudzba add foreign key(korisnik_id) references korisnik(sifra);
alter table narudzba_igra add foreign key(igra_id) references igra(sifra);
alter table narudzba_igra add foreign key(narudzba_id) references narudzba(sifra);