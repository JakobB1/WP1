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
-- Operatori usporeðivanja
-- = != (<>) < > <= >=
select * from polaznik where sifra<>2;
select * from polaznik where sifra>2;
select * from polaznik where sifra<=2;
select * from polaznik where ime='Luka';

-- logièki operatori -> èitati: https://i.ytimg.com/vi/7dvqfpXEjdg/maxresdefault.jpg
-- and or not
select * from polaznik where sifra>2 and sifra<5;

select * from polaznik where sifra=2 or sifra=3;

select * from polaznik where not (sifra>3 and sifra<5);

select * from polaznik where
ime='Luka' and prezime='Bušiæ';

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







