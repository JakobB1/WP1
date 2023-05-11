use master;
drop database if exists hijerarhijawp1;
go
create database hijerarhijawp1;
go
use hijerarhijawp1;

create table zaposlenik(
	sifra int not null primary key identity(1,1),
	ime varchar(50),
	prezime varchar(50),
	placa decimal(18,2),
	nadredeni int
);

alter table zaposlenik add foreign key (nadredeni) references zaposlenik(sifra);