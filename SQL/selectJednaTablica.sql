-- do sada smo vidjeli ovu naredbu

select * from smjer;

-- minimalni dio select naredbe
select 1;

-- filtriranjem kolona
select sifra, naziv from smjer; -- sifra, naziv su select lista

SELECT SIFRA,NAZIV,SIFRA FROM SMJER;

select *,naziv, * from smjer;

-- u select listi se može nalaziti
-- *, naziv kolone
-- konstanta
select naziv, 'Osijek', 2 from smjer;

-- kolone mogu imati zamjenska imena

select naziv as nazivsmjera, 'Osijek' as grad from smjer;

-- izraz (funkcija)

select naziv, getdate() from smjer;

select upper(naziv) as smjer, getdate() as datum from smjer;

-- ispišite imena i prezimena polaznika
select ime, prezime from polaznik;


-- filtriranje redova
select * from polaznik;

-- od prošli puta
select * from polaznik where sifra=2;

-- u where dijelu se nalaze operatori
-- Operatori uspoređivanja
-- = != (<>) < > <= >=
select * from polaznik where sifra<>2;
select * from polaznik where sifra>2;
select * from polaznik where sifra<=2;
select * from polaznik where ime='Luka';

-- logički operatori -> čitati: https://i.ytimg.com/vi/7dvqfpXEjdg/maxresdefault.jpg
-- and or not
select * from polaznik where sifra>2 and sifra<5;

select * from polaznik where sifra=2 or sifra=3;

select * from polaznik where not (sifra>3 and sifra<5);

select * from polaznik where
ime='Luka' and prezime='Bu�i�';

-- izlistajte sve polaznike koji se ne zovu Luka

-- operatori algebre
-- + - / *
update smjer set cijena = cijena * 1.1;

-- Ostali operatori
-- like, between, in, is null, is not null
select * from polaznik where ime like 'L%';
select * from polaznik where ime like 'L%A';

select * from polaznik where ime like '%nt%';

select * from polaznik where sifra between 2 and 4;

select * from polaznik where sifra in (1,7,9);

select * from smjer;

select * from smjer where cijena is null;

select * from smjer where cijena is not null;





-- baza knjižnica (malaBaza.sql)
use knjiznica;

-- koliko ima autora koji se zovu kao ja

select * from autor where ime='Tomislavac';

-- Cura ostavila dečka
-- Ovaj došao u knjižnicu i želi čitati o ljubavi
-- Što mu preporučate

select * from katalog where naslov like '%ljubav%'
and sifra in (2938,2680,2660);

-- Nađite autore rođene 1980 godine
-- i da su ženski autor
select * from autor where datumrodenja
between '1980-01-01' and '1980-12-31'
and ime like '%a';

-- Izlistajte prezimena autora za koje ne zma datum rođenja
select prezime from autor where datumrodenja is null;

-- Dodajte sebe kao autora

select * from autor;
insert into autor(sifra,ime,prezime,datumrodenja)
values (4,'Tomislav','Jakopec','1980-12-07');

select * from izdavac;
-- Obrišite izdavača Grad Osijek
delete from katalog where izdavac=390;
delete from izdavac where sifra=390;

create database northwind;
use northwind;
-- izvesti skriptu instnwnd.sql

-- Tko su glavni šefovi?
select * from Employees where ReportsTo is null;

select * from Employees where EmployeeID=1;

-- izlistajte sve proizvode koji su jeftiniji od 100 $

select * from Products where UnitPrice<100;

-- Baza svaštara
-- Ime u svatove i želim kupiti poklon
use svastara;

select * from Artikli where kratkiNaziv like '%lampa%';

--Cijena artikala je iskazana u kunama
-- prebacite cijenu na EUR

-- slaganje rezultata
select * from kupci
where prezime like 'AB%'
order by prezime, ime;


select * from kupci
where prezime like 'AB%'
order by 2 desc,3;


select top 10 * from kupci
where ime like '%nt%'
and prezime not like 'F%';

select top 10 percent * from kupci
where ime like '%nt%'
and prezime not like 'F%';


select ime, prezime from kupci
where mjesto=18031;

select 
concat(trim(ime),' ', trim(prezime)) as imeprezime,
'Osijek' as mjesto
from kupci
where mjesto=18031
union
select 
concat(trim(ime),' ', trim(prezime)) as imeprezime,
'Donji Miholjac' as mjesto
from kupci
where mjesto=2763;

-- Islistajte sve preilice suđa
select top 1 * from Artikli;

select * from Artikli where kratkiNaziv like '%perilica%'
and dugiNaziv like '%posu%';

select * from Artikli where
concat(kratkiNaziv,duginaziv) like '%perili%posu%';


-- koliko tablica ima redova
select count(*) from kupci;


select count(*) from ArtikliNaPrimci;

select top 10 * from ArtikliNaPrimci;

select distinct artikl from ArtikliNaPrimci
order by 1;

select count(*) from artikli;

-- pronaći artikle koje nismo nikada nabavili
select * from artikli where sifra not in
(select distinct artikl from ArtikliNaPrimci);

-- obrišite artikle koje nismo nikada nabavili
delete from Artikli where sifra in (79102,90661);

-- zadnja šifra kupca
select top 1 sifra from Kupci order by 1 desc;

-- Unesite sebe kao kupca


-- tablici kupci dodati kolonu oib
alter table kupci add  oib char(11);
select top 10 concat('>',oib,'<') from Kupci;
update kupci set oib=' ';
alter table kupci ALTER COLUMN oib char(11) not null;

-- koliko ima kupaca iz Osijeka?
select top 1 * from kupci;
select * from mjesta where naziv like '%osijek%';
select count(*) from kupci where mjesto=45691;


select top 10 primka, kolicina*cijena as iznos 
from ArtikliNaPrimci;

select sum(kolicina*cijena) from ArtikliNaPrimci
where primka=14;

select min(cijena) from artikli;

select * from Artikli where cijena=0.04;

select max(cijena) from artikli;

select *,cijena/7.5345 as EUR from Artikli where cijena=66890;

-- ukupni iznosi na svim primkama
select primka, sum(cijena*kolicina)as iznos from ArtikliNaPrimci
group by primka
having sum(cijena*kolicina)>10000000
order by 2 desc;

-- pronađite naziv dobavljača koji je dostavio najveći iznos
-- po jednoj primci
select * from Primke where sifra=15853;
select * from Dobavljaci where sifra=560;
select * from mjesta where sifra=42633;
select * from Opcine where sifra=5312;
select * from Zupanije where sifra=18;

-- U artikle dodajte svoj mobitel

select * from Usluge
-- tablici usluge dodajte kolonu jedinicamjere i svim uslugama
-- stavite vrijednost za jedinicu mjere sat

-- ispravite naziv usluge Cišcenje                                          

-- Koliko kupaca se zove kao Vi?
select count(*) from kupci where ime='Tomislav';

-- tablici kupci dodati kolonu spol bit
alter table kupci add spol bit;
--Svim kupcima kojima ime završava na slovo a staviti spol na 1
update kupci set spol=1 where trim(ime)  like '%a';
--Svim kupcima kojima ime ne završava na slovo a staviti spol na 0
update kupci set spol=0 where trim(ime) not like '%a';








