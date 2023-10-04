SELECT name, collation_name FROM sys.databases;
GO
ALTER DATABASE db_a9fbfc_gamestoreapp SET SINGLE_USER WITH
ROLLBACK IMMEDIATE;
GO
ALTER DATABASE db_a9fbfc_gamestoreapp COLLATE Croatian_CI_AS;
GO
ALTER DATABASE db_a9fbfc_gamestoreapp SET MULTI_USER;
GO
SELECT name, collation_name FROM sys.databases;
GO


create table izdavac(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	drzava varchar(50) not null,
	webStranica varchar(50) not null
);

create table igra(
	sifra int not null primary key identity(1,1),
	naziv varchar(50) not null,
	izdavac_id int not null,
	zanr varchar(50) not null,
	cijena decimal(18,2) not null,
	dobnaGranica int not null,
	datumIzlaska datetime not null,
	opis varchar(1000) not null
);

create table korisnik(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	oib char(11),
	email varchar(50) not null
);

create table narudzba(
	sifra int not null primary key identity(1,1),
	korisnik_id int not null,
	placanje varchar(50) not null,
	datumObracuna datetime not null
);

create table stavka(
	sifra int not null primary key identity(1,1),
	igra_id int not null,
	narudzba_id int not null,
	kolicina int not null
);



alter table igra add foreign key(izdavac_id) references izdavac(sifra);
alter table narudzba add foreign key(korisnik_id) references korisnik(sifra);
alter table stavka add foreign key(igra_id) references igra(sifra);
alter table stavka add foreign key(narudzba_id) references narudzba(sifra);

select * from izdavac;
insert into izdavac(naziv,drzava,webStranica)
values	('Valve','Bellevue, Washington','https://www.valvesoftware.com/en/'),
		('FromSoftware','Tokyo, Japan','https://www.fromsoftware.jp/ww/'),
		('CD Projekt Red','Łódź, Poland','https://www.cdprojektred.com/en'),
		('Capcom','Osaka, Japan','https://www.capcom.com/'),
		('id Software','Richardson, Texas, United States','https://www.idsoftware.com/'),
		('Santa Monica Studio','Los Angeles, California','https://sms.playstation.com/');



select * from igra;
insert into igra(naziv,izdavac_id,zanr,cijena,dobnaGranica,datumIzlaska,opis)
values ('Half-Life',1,'First Person Shooter',7.99,18,'1998-11-19 00:00:00',
		'Valves debut title blends action and adventure with award-winning technology 
		to create a frighteningly realistic world where players must think to survive'),

		('Dark Souls',2,'Action RPG',9.99,16,'2011-09-22 00:00:00',
		'The unique old-school action RPG experience captivated imaginations of gamers 
		worldwide with incredible challenge and intense emotional reward.'),

		('Cyberpunk 2077',3,'Action RPG',35.99,18,'2023-12-10 00:00:00',
		'Cyberpunk 2077 is an open-world, action-adventure RPG set in the megalopolis of Night City, 
		where you play as a cyberpunk mercenary wrapped up in a do-or-die fight for survival.'),

		('Devil May Cry 5',4,'Action Adventure Hack and Slash',29.99,18,'2019-03-08 00:00:00',
		'The Devil you know returns in this brand new entry in the 
		over-the-top action series available on the PC'),

		('Doom Eternal',5,'FPS',19.99,18,'2020-03-20 00:00:00',
		'Hell’s armies have invaded Earth. Become the Slayer in an epic single-player campaign 
		to conquer demons across dimensions and stop the final destruction of humanity.'),

		('God of War',6,'Action Adventure Hack and Slash',9.99,18,'2005-03-22 00:00:00',
		'The mad Kratos is guided by the gods to fight through hordes of 
		enemies from Greek mythology and overthrow the war god Ares.');


select * from korisnik;
insert into korisnik(ime,prezime,oib,email)
values ('Pero','Peric',12345678911,'pero@mail.com');

select * from narudzba;
insert into narudzba(korisnik_id,placanje,datumObracuna)
values (1,'Kartica','2023-10-10 00:00:00');

select * from stavka;
insert into stavka(igra_id,narudzba_id,kolicina)
values (1,1,1);