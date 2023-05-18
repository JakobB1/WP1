use master;
drop database if exists samostanwp1;
go 
create database samostanwp1;
go
use samostanwp1;
--nije dobro
create table samostan(
    sifra int not null primary key identity(1,1),
    naziv varchar(50) not null,
    svecenici int not null
);

create table svecenici(
    sifra int not null primary key identity(1,1),
    ime varchar(50) not null,
    prezime varchar(50) not null,
    poslovi int not null,
    nadredeni int not null
);

create table poslovi(
    sifra int not null primary key identity(1,1),
    naziv varchar(50) not null,
    svecenici int not null
);

create table nadredeni(
    sifra int not null primary key identity(1,1),
    ime varchar(50) not null,
    prezime varchar(50) not null
);



alter table samostan add foreign key(svecenici) references svecenici(sifra);
alter table svecenici add foreign key(poslovi) references poslovi(sifra);
alter table poslovi add foreign key(svecenici) references svecenici(sifra);
alter table svecenici add foreign key(nadredeni) references nadredeni(sifra);