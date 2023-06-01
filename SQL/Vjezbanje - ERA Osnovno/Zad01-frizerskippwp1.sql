use master;
drop database if exists frizerskiwp1;
go
create database frizerskiwp1;
go
use frizerskiwp1;


--CREATE TABLE
create table djelatnica(
    sifra int not null primary key identity(1,1),
    ime varchar(50) not null,
	prezime varchar(50),
    kontakt varchar(50) not null
);

create table korisnik(
    sifra int not null primary key identity(1,1),
    ime varchar(50) not null,
	prezime varchar(50) not null
);

create table usluga(
    sifra int not null primary key identity(1,1),
    naziv varchar(50) not null,
    cijena decimal(18,2)
);

create table termin(
	sifra int not null primary key identity(1,1),
	djelatnica int not null,
	korisnik int not null,
	usluga int not null
);


--ALTER TABLE
alter table termin add foreign key(djelatnica) references djelatnica(sifra);
alter table termin add foreign key(korisnik) references korisnik(sifra);
alter table termin add foreign key(usluga) references usluga(sifra);


--DJELATNICA
select * from djelatnica;
--Insert
insert into djelatnica(ime,prezime,kontakt)
values	
('Ime01','Prezime01','091 000 0000'),
('Ime02','Prezime02','092 000 0000'),
('Ime03','Prezime03','093 000 0000'),
('Ime04','Prezime04','094 000 0000'),
('Ime05','Prezime05','095 000 0000'),
('Ime06','Prezime06','096 000 0000');
--Update 
update djelatnica set 
ime='NovoIme01',
prezime='NovoPrezime01',
kontakt='091 111 1111'
where sifra=1;

update djelatnica set 
ime='NovoIme02',
prezime='NovoPrezime02',
kontakt='091 222 2222'
where sifra=2;

update djelatnica set 
ime='NovoIme03',
prezime='NovoPrezime03',
kontakt='091 333 3333'
where sifra=3;
--Delete 
delete from djelatnica where ime like '%Ime04%';
delete from djelatnica where prezime='Prezime05';
delete from djelatnica where sifra=6;