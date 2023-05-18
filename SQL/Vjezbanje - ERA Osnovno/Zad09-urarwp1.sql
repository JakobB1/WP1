use master;
drop database if exists urarwp1;
go 
create database urarwp1;
go
use urarwp1;

create table urar(
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
	sat int not null
);

create table sat(
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



alter table urar add foreign key(popravak) references popravak(sifra);
alter table korisnik add foreign key(sat) references sat(sifra);
alter table sat add foreign key(popravak) references popravak(sifra);
alter table urar add foreign key(segrt) references segrt(sifra);
alter table segrt add foreign key(popravak) references popravak(sifra);