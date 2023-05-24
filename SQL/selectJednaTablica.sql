-- komentar
select * from smjer;


-- komentar
select 1;

-- komentar
select sifra,naziv from smjer; --komentar
 
select sifra,naziv,sifra from smjer;

select *,naziv, * from smjer;

--komentar
--komentar
--komentar
select naziv, 'Osijek', 2 from smjer;

--komentar

select naziv as nazivsmjera, 'Osijek' as grad from smjer;

--komentar

select naziv, getdate() from smjer;

select upper(naziv) as smjer, getdate() as datum from smjer;

-- ispisite imena i prezimena osoba
select * from polaznik;
select ime,prezime from polaznik;

-- komentar
select * from polaznik;

-- komentar
select * from polaznik where sifra=2;

-- komentar
-- komentar
-- komentar
select * from polaznik where sifra<>2;
select * from polaznik where sifra>2;
select * from polaznik where sifra<=2;
select * from polaznik where ime='Luka';

-- komentar
-- komentar
select * from polaznik where sifra>2 and sifra<5;

select * from polaznik where sifra=2 or sifra=3;

select * from polaznik where not (sifra>3 and sifra<5);

select * from polaznik where 
ime='Luka' and prezime='Bušic';

-- izlistajte sve polaznike koji se ne zovu luka
select * from polaznik where not ime='Luka';
-- komentar
-- komentar
update smjer set cijena = cijena * 1.1;

-- komentar
-- komentar
select * from polaznik where ime like 'L%' ;
select * from polaznik where ime like 'L%A' ;

select * from polaznik where ime like '%nt%';

select * from polaznik where sifra between 2 and 4;

select * from polaznik where sifra in (1,7,9);

select * from smjer;

select * from smjer where cijena is null;

select * from smjer where cijena is not null;