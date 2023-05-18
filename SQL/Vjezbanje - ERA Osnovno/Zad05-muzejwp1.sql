use master;
drop database if exists muzejwp1;
go 
create database muzejwp1;
go
use muzejwp1;

create table muzej(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	izlozba int not null
);

create table izlozba(
	sifra int not null primary key identity(1,1),
	naziv varchar(50),
	djela int not null,
	sponzor int not null
);

create table djela(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null
);

create table kustos(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	oib char(11),
	izlozba int not null
);

create table sponzor(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null
);



alter table muzej add foreign key(izlozba) references izlozba(sifra);
alter table izlozba add foreign key(djela) references djela(sifra);
alter table kustos add foreign key(izlozba) references izlozba(sifra);
alter table izlozba add foreign key(sponzor) references sponzor(sifra);