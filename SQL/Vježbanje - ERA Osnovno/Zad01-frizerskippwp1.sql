use master;
drop database if exists frizerskiwp1;
go
create database frizerskiwp1;
go
use frizerskiwp1;

create table salon (
    sifra int not null primary key identity(1,1),
    naziv varchar(50),
    djelatnica int not null
);

create table djelatnica (
    sifra int not null primary key identity(1,1),
    ime varchar(50) not null,
    iban varchar(32),
    korisnik int not null
);

create table korisnik (
    sifra int not null primary key identity(1,1),
    ime varchar(50) not null,
    email varchar(20),
    usluga int not null
);

create table usluga (
    sifra int not null primary key identity(1,1),
    naziv varchar(50) not null,
    cijena decimal(18,2)
);