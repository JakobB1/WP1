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
    iban char(11),
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



alter table salon add foreign key (djelatnica) references djelatnica (sifra);

alter table djelatnica add foreign key (korisnik) references korisnik (sifra);

alter table korisnik add foreign key (usluga) references usluga (sifra);



select * from usluga;
insert into usluga(naziv,cijena)
values ('Usluga01',99.99),
       ('Usluga02',199.99),
       ('Usluga03',299.99),
       ('Usluga04',399.99),
       ('Usluga05',499.99);

select * from korisnik;
insert into korisnik(ime,email,usluga)
values ('Korisnik01','mail01@mail.com',4),
       ('Korisnik02','mail02@mail.com',2),
       ('Korisnik03','mail03@mail.com',5),
       ('Korisnik04','mail04@mail.com',2),
       ('Korisnik05','mail05@mail.com',1);


select * from djelatnica;
insert into djelatnica(ime,korisnik)
values ('Djelatnica01',3),
       ('Djelatnica02',1),
       ('Djelatnica03',2),
       ('Djelatnica04',5),
       ('Djelatnica05',4);


select * from salon;
insert into salon(naziv,djelatnica)
values ('Salon01',5),
       ('Salon02',3),
       ('Salon03',1),
       ('Salon04',2),
       ('Salon05',4);