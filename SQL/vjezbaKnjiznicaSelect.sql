
use knjiznica;

-- koliko ima autora koji se zovu kao ja

select * from autor where ime='Jakob';

-- Cura ostavila dečka
-- Ovaj došao u knjižnicu i želi čitat o ljubavi
-- Što mu preporučate

select * from katalog where naslov like '%ljubav%' 
and sifra in(2938,2680,2660);

-- Nađite autore rođene 1980.god
-- i da su ženski autor
select * from autor where datumrodenja
between '1980-01-01' and '1980-12-31'
and ime like '%a';

-- Izlistajte prezimena autora az koje ne znam datum rođenja
select prezime from autor where datumrodenja is null;

-- Dodajte sebe kao autora
select * from autor;
insert into autor(sifra,ime,prezime,datumrodenja)
values (4,'Jakob','Brkić','1997-06-26 00:00:00');

-- Obrisite izdravača Grad Osijek
delete from katalog where izdavac=390;
delete from izdavac where sifra=390;





create database northwind;
use northwind;
-- izvesti skriptu

-- Tko su glavni šefovi
select * from Employees where ReportsTo is null;

select * from Employees where EmployeeID=1;

-- Izistajte sve proizvode koji su jeftiniji od 100$
select * from Products;
select * from Products where UnitPrice between 0 and 100;

use svastara;
select * from Kupci;
select * from Artikli;
select * from Artikli where kratkiNaziv like '%lampa%';

update Artikli set cijena = cijena * 1.1;