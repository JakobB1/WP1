-- izlistajte sve grupe smjera 
-- Web programiranje

select * from smjer where naziv='Web programiranje';
select * from grupa where smjer=1;

select a.naziv as smjer, b.naziv
from smjer a inner join grupa b
on b.smjer=a.sifra
where
a.naziv='Web programiranje';

-- Dodajte novu grupu na smjer 
-- Web programiranje

insert into grupa(smjer,naziv)
values (1,'WP2');


select a.naziv as smjer, b.naziv
from smjer a left join grupa b
on b.smjer=a.sifra
order by 1;

select a.naziv as smjer, b.naziv
from smjer a right join grupa b
on b.smjer=a.sifra
order by 1;

-- Izlistati imena i prezimena
-- polaznika koji su na smjer
-- Web programiranje

select b.naziv, d.ime, d.prezime
from smjer a inner join grupa b
on a.sifra=b.smjer
inner join clan c
on b.sifra=c.grupa
inner join polaznik d
on c.polaznik=d.sifra
where a.naziv='Web programiranje';

-- alternative
--
--
--
--
--
--
--
--
--
--
--
--

-- baza knjiznica
-- Izlistajte sve knjige koje je izdala Ivana Brkić Mažuranić
select b.naslov
from autor a inner join katalog b
on b.autor=a.sifra
where a.ime='Ivana' and a.prezime='Brlić Mažuranić';

select * from katalog;

select a.sifra, concat(b.ime, ' ',b.prezime) as autor,
a.naslov, c.naziv as izdavac, a.mjesto
from katalog a inner join autor b on a.autor=b.sifra
inner join izdavac c on a.izdavac=c.sifra;






select a.sifra, concat(b.ime, ' ',b.prezime) as autor,
a.naslov, c.naziv as izdavac,d.naziv as mjesto
from katalog a inner join autor b on a.autor=b.sifra
inner join izdavac c on a.izdavac=c.sifra
inner join mjesto d on a.mjesto=d.sifra;

-- U kojim mjestima je August Šenoa izdao svoje knjige?
select distinct a.naziv
from mjesto a inner join katalog b on a.sifra=b.mjesto
inner join autor c on b.autor=c.sifra
where c.ime='August' and c.prezime='Šenoa';


-- Izlistajte sve naslove koje su izdali 
-- izdavači čiji naziv počinje s slovom E
select  b.naslov, a.naziv
from izdavac a inner join katalog b on a.sifra=b.izdavac
where a.naziv like 'E%' order by 2;


-- Koji autori nisu izdali niti jednu knjigu
select a.ime, a.prezime, b.sifra
from autor a left join katalog b on a.sifra=b.autor
where b.sifra is null;

-- Koja su jedinstevena imena autora koji nisu izdali niti jednu knjigu
select distinct a.ime
from autor a left join katalog b on a.sifra=b.autor
where b.sifra is null;

-- baza svastara
-- izlistati sve nazive mjesta u Osječko baranjskoj županiji

select a.naziv, c.naziv
from zupanije a inner join opcine b on a.sifra=b.zupanija
inner join mjesta c on b.sifra=c.opcina
where a.naziv like 'Osje%';

-- izlistajte sve nazive dobavljača iz mjest Osijek

select a.naziv
from dobavljaci a inner join mjesta b on a.mjesto=b.sifra
where b.naziv='Osijek';

-- U kojim mjestima postoje dobavljači
select b.naziv
from dobavljaci a inner join mjesta b on a.mjesto=b.sifra;

select a.naziv
from dobavljaci a inner join mjesta b on a.mjesto=b.sifra
where b.naziv='Antolovec';

-- Koje je sve jedinstvene nazive artikle dobavio dobavljač
-- Kovalos d.o.o

select distinct d.kratkiNaziv
from dobavljaci a inner join 
Primke b on b.dobavljac=a.sifra
inner join ArtikliNaPrimci c on 
c.primka=b.sifra
inner join Artikli d on 
c.artikl=d.sifra
where a.naziv='Kovalos d.o.o'
order by 1;

-- Izlistajte sve kupce iz mjesta Antolovec

select top 10 * from kupci;

select distinct a.ime,a.prezime
from kupci a inner join mjesta b
on a.mjesto=b.sifra
where b.naziv='Antolovec';