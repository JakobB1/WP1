use master;
drop database if exists doktorwp1;
go 
create database doktorwp1;
go
use doktorwp1;

create table doktor (
    sifra int not null primary key identity(1,1),
    ime varchar(50) not null,
    prezime varchar(50) not null,
    pacijent int not null,
    sestra int not null
);

create table pacijent (
    sifra int not null primary key identity(1,1),
    ime varchar(50) not null,
    prezime varchar(50) not null,
    lijecenje int not null
);

create table sestra (
    sifra int not null primary key identity(1,1),
    ime varchar(50) not null,
    prezime varchar(50) not null,
    doktor int not null
);

create table lijecenje (
    sifra int not null primary key identity(1,1),
    nazivTerapije varchar(50) not null
);