use master;
drop database if exists kolokvij_vjezba_15;
go
create database kolokvij_vjezba_15;
go
use kolokvij_vjezba_15;

--0. Kreirajte tablice i veze između tablica
create table brat(
	sifra int not null primary key identity(1,1),
	bojakose varchar(49) not null,
	majica varchar(36),
	maraka decimal(17,9),
	vesta varchar(30) not null
);

create table prijateljica(
	sifra int not null primary key identity(1,1),
	kratkamajica varchar(30) not null,
	bojakose varchar(45),
	asocijalno bit not null,
	treciputa datetime not null,
	jmbag char(11) not null,
	vesta varchar(42) not null,
	brat int
);

create table ostavljena(
	sifra int not null primary key identity(1,1),
	gustoca decimal(16,7),
	stilfrizura varchar(31) not null,
	ogrlica int,
	maraka decimal(15,10)
);

create table zarucnik(
	sifra int not null primary key identity(1,1),
	kratkamajica varchar(30) not null,
	jmbag char(11) not null,
	dukserica varchar(45) not null,
	indiferentno bit,
	treciputa datetime not null
);

create table zarucnik_ostavljena(
	sifra int not null primary key identity(1,1),
	zarucnik int not null,
	ostavljena int not null
);

create table zarucnica(
	sifra int not null primary key identity(1,1),
	prviputa datetime not null,
	bojaociju varchar(31) not null,
	modelnaocala varchar(40),
	zarucnik int
);

create table prijatelj(
	sifra int not null primary key identity(1,1),
	majica varchar(41) not null,
	vesta varchar(30),
	narukvica int not null,
	zarucnica int
);

create table decko(
	sifra int not null primary key identity(1,1),
	vesta varchar(37) not null,
	bojakose varchar(45),
	gustoca decimal(18,7),
	prijatelj int not null
);

alter table prijateljica add foreign key(brat) references brat(sifra);
alter table decko add foreign key(prijatelj) references prijatelj(sifra);
alter table prijatelj add foreign key(zarucnica) references zarucnica(sifra);
alter table zarucnica add foreign key(zarucnik) references zarucnik(sifra);
alter table zarucnik_ostavljena add foreign key(zarucnik) references zarucnik(sifra);
alter table zarucnik_ostavljena add foreign key(ostavljena) references ostavljena(sifra);