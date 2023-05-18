use master;
drop database if exists postolarwp1;
go 
create database postolarwp1;
go
use postolarwp1;

create table postolar(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	popravak int not null,
	segrt int not null
);

create table korisnik(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	obuca int not null
);

create table obuca(
	sifra int not null primary key identity(1,1),
	nazivMarke varchar(50) not null,
	popravak int not null
);

create table popravak(
	sifra int not null primary key identity(1,1),
	datumPopravka datetime not null
);

create table segrt(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	popravak int not null
);



alter table postolar add foreign key(popravak) references popravak(sifra);
alter table obuca add foreign key(popravak) references popravak(sifra);
alter table korisnik add foreign key(obuca) references obuca(sifra);
alter table segrt add foreign key(popravak) references popravak(sifra);
alter table postolar add foreign key(segrt) references segrt(sifra);