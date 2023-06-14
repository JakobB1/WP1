use master;
drop database if exists kolokvij_vjezba_20;
go
create database kolokvij_vjezba_20;
go
use kolokvij_vjezba_20;

--0. Kreirajte tablice i veze između tablica
create table zena(
	sifra int not null primary key identity(1,1),
	asocijalno bit not null,
	nausnica int,
	jmbag char(11) not null,
	bojaociju varchar(41),
	kratkamajica varchar(30)
);

create table neprijateljica(
	sifra int not null primary key identity(1,1),
	introvertno bit not null,
	nausnica int,
	gustoca decimal(17,8),
	lipa decimal(17,8),
	jmbag char(11) not null,
	zena int
);

create table zarucnik(
	sifra int not null primary key identity(1,1),
	suknja varchar(31),
	prstena int not null,
	modelnaocala varchar(46) not null,
	novcica decimal(17,5) not null,
	gustoca decimal(17,8)
);

create table mladic(
	sifra int not null primary key identity(1,1),
	hlace varchar(47),
	suknja varchar(50),
	haljina varchar(50) not null,
	prstena int not null,
	treciputa datetime not null,
	introvertno bit not null
);

create table mladic_zarucnik(
	sifra int not null primary key identity(1,1),
	mladic int not null,
	zarucnik int not null
);

create table punica(
	sifra int not null primary key identity(1,1),
	ogrlica int,
	prviputa datetime,
	drugiputa datetime not null,
	introvertno bit,
	treciputa datetime,
	mladic int not null
);

create table decko(
	sifra int not null primary key identity(1,1),
	kuna decimal(14,5),
	novcica decimal(15,7),
	indiferentno bit not null,
	maraka decimal(16,9) not null,
	punica int not null
);

create table zarucnica(
	sifra int not null primary key identity(1,1),
	modelnaocala varchar(50),
	suknja varchar(49) not null,
	prviputa datetime,
	treciputa datetime,
	decko int
);

alter table neprijateljica add foreign key(zena) references zena(sifra);
alter table zarucnica add foreign key(decko) references decko(sifra);
alter table decko add foreign key(punica) references punica(sifra);
alter table punica add foreign key(mladic) references mladic(sifra);
alter table mladic_zarucnik add foreign key(mladic) references mladic(sifra);
alter table mladic_zarucnik add foreign key(zarucnik) references zarucnik(sifra);