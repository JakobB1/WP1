select * from kupci
where prezime like 'AB%'
order by prezime,ime;

select * from kupci
where prezime like 'AB%'
order by 2 desc,3;


select top 10 percent * from kupci
where ime like '%nt%'
and prezime not like 'F%';

select ime,prezime from kupci 
where mjesto=18031;

select 
concat(trim(ime),' ', trim (prezime)) as imeprezime,
'Osijek' as mjesto 
from kupci
where mjesto=18031
union
select 
concat(trim(ime),' ', trim (prezime)) as imeprezime,
'Donji Miholjac' as mjesto 
from kupci
where mjesto=2763;

-- Izlistajte sve perilica suđa
select top 1* from Artikli;

select * from Artikli where kratkiNaziv like '%perilica%'
and dugiNaziv like '%posu%';

select * from Artikli where 
concat(kratkiNaziv,dugiNaziv) like '%perili%posu%';


-- koliko tablica ima redova 
select count(*) from Kupci;


select count(*) from ArtikliNaPrimci;

select top 10 * from ArtikliNaPrimci;

select distinct artikl from ArtikliNaPrimci
order by 1;

select count(*) from artikli;

-- pronaći artikle koje nismo nikada nabavili
select * from Artikli where sifra not in 
(select distinct artikl from ArtikliNaPrimci);

-- obrišite artikle koje nismo nikada nabavili
delete from Artikli where sifra not in
(select distinct artikl from ArtikliNaPrimci);

-- delete from artikli where sifra in(79102,90661);

-- zadnja šifra kupca
select top 1 sifra from Kupci order by 1 desc;

-- Unesite sebe kao kupca
select * from Kupci;
insert into kupci(ime,jmbg,prezime,adresa,mjesto)
values ('Jakob',2911961370325,'Brkic','Adresa01',18031);

-- tablici kupci dodati kolonu oib
alter table kupci add oib char(11);
select top 10 concat('>',oib,'<') from kupci;
update kupci set oib=' ';
alter table kupci alter column oib char(11) not null;

-- koliko ima kupaca iz Osijeka?
select top 1 * from kupci;
select * from Mjesta where naziv like '%osijek%';
select count(*) from Kupci where mjesto=45691;


select top 10 primka, kolicina*cijena as iznos 
from ArtikliNaPrimci;

select sum (kolicina*cijena) from ArtikliNaPrimci
where primka=14;

select min(cijena) from Artikli;

select * from Artikli where cijena=0.04;

select max(cijena) from Artikli;

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
select * from Mjesta where sifra=42633;
select * from opcine where sifra=5312;
select * from Zupanije where sifra=18;

-- U artikle dodajte svoj mobitel
select * from Artikli;
insert into Artikli(barkod,kratkiNaziv,dugiNaziv,jedinicaMjere,cijena)
values(4831000200452,'kratkiNazivMobitel','dugiNazivMobitel','KOM',149.99)
select * from Artikli where sifra=105629;

select * from Usluge;
-- tablici usluge dodajte kolonu jedinicaMjere i svim uslugama 
-- stavite vrijednost za jedinicu mjere sat
select * from usluge;
alter table Usluge add jedinicaMjere varchar(50);
update Usluge set jedinicaMjere='sat';

-- ispravite naziv usluge Cišcenje
select * from usluge;
update Usluge set naziv='Ciscenje' where sifra=4;

-- Koliko kupaca se zove kao vi
select * from Kupci where ime like '%Jakob%';
select count(*) from kupci where ime='Jakob';

-- tablici kupci dodati kolonu spol, tip podatka bit
-- svim kupcima kojima ime zavrsava na slovo a staviti spol na 1 
-- svim kupcima kojima ime ne zavrsava na slovo a staviti spola na 0

select * from Kupci;
alter table Kupci add spol bit;
update kupci set spol=1 where trim(ime) like '%a';
update kupci set spol=0 where trim(ime) not like '%a';