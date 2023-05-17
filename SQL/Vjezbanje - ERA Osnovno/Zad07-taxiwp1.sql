use master;
drop database if exists taxiwp1;
go 
create database taxiwp1;
go
use taxiwp1;

create table tvrtka (
    sifra int not null primary key identity(1,1),
    naziv varchar(50) not null,
    vozilo int not null
);

create table vozilo (
    sifra int not null primary key identity(1,1),
    naziv varchar(50) not null,
    vozac int not null
);

create table vozac ( 
    sifra int not null primary key identity(1,1),
    ime varchar(50) not null,
    prezime varchar(50) not null,
    putnik int not null
);

create table putnik ( 
    sifra int not null primary key identity(1,1),
    ime varchar(50) not null,
    prezime varchar(50) not null,
    voznja int not null 
);

create table voznja (
    sifra int not null primary key identity(1,1),
    vrijemeVoznje datetime,
    cijenaVoznje decimal(18,2)
);