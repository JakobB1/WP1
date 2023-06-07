select * from smjer;

select ime from polaznik order by ime; -- ne mora se pisati asc

select ime from polaznik order by ime desc;

select ime, prezime from polaznik order by 2;

select distinct ime from polaznik order by ime;

select top 10 ime from polaznik order by ime desc; -- prvih 10

select top 10 percent ime from polaznik order by ime desc; -- prvih 10 %


-- dodavanje kolone tablici
alter table smjer add iznos decimal(18,2);

select rand();

update smjer set iznos=rand()*1000;

--zabraniti nepoznavanje dodatka
alter table smjer alter column iznos decimal(18,2) not null ;

-- povećati iznos za 10%
update smjer set iznos=iznos*1.1;

select * from smjer;

-- smanjiti za 10 %
update smjer set iznos=iznos*0.9;

-- kreiranje tablice na osnovu select naredbe
select * into nova from smjer;

select * from nova;
delete from nova where sifra=2;

drop table nova;

-- Obriši sve članove na smjeru JAVA programiranje
delete c
from smjer a
inner join grupa b on a.sifra =b.smjer 
inner join clan c on b.sifra =c.grupa 
where a.naziv='Web programiranje';

-- Svim polaznicima na Web programiranju
-- imenu dodaj slovo W
update a 
set
a.ime = concat(a.ime,'W')
from polaznik a
inner join clan b on a.sifra =b.polaznik 
inner join grupa c on b.grupa =c.sifra 
inner join smjer d on c.smjer =d.sifra 
where d.naziv = 'Web programiranje';

select * from polaznik;


-- priprema za podupit
delete from clan where 
grupa=1 and polaznik =1;

-- naći polaznike koji nisu član niti jedne grupe
select * from 
polaznik where sifra not in 
(select polaznik from clan);


select a.ime, a.prezime
from polaznik a
left join clan b on a.sifra =b.polaznik
where b.grupa is null;


-- funkcije

--funkcije
--now() ne prima niti jedan parametar
--left(X) - prima jedan parametar
--funkcije primaju više parametara odvojenih zarezom
--concat nadoljepljuje stringove (y,y,y,y,y)
select getdate(),ime, left(ime,1),
left('Osijek',2)from polaznik;

select getdate();

select 1;

select 
concat(
	left(lower(ime),1),
	lower(prezime)
)
from polaznik;

select upper(ime) from polaznik;

-- ispisati imena prvo slovo malo, sva ostala velika

select concat(lower(left(ime,1)),upper(right(ime,len(ime)-1))) from polaznik;

alter table smjer add tip varchar(50);

update smjer set tip='Prvi' where sifra<2;
update smjer set tip='Drugi' where sifra =2;

select tip, sum(cijena), min(cijena),max(cijena),
avg(cijena),count(cijena) from smjer group by tip;


CREATE FUNCTION email(
	@ime varchar(50), @prezime varchar(50)
	)
RETURNS varchar(150) AS
BEGIN
    return concat(left(lower(@ime),1),'.', lower(
			replace(
			replace(
			replace(
			replace(
			replace(replace(upper(@prezime),' ',''),'Č','C')
			,'Š','S')
			,'Đ','D')
			,'Ć','C')
			,'Ž','Z')
			), '@edunova.hr');
END;
    
DROP FUNCTION email;



select dbo.email(ime,prezime) as email from polaznik;

-- datumske funkcije
-- koji je datum za 90 dana
select dateadd(day,90,getdate());

-- koji je datum bio prije 90 dana
select dateadd(day,-90,getdate());

-- Broj otkucaja srca
select datediff(day, '1980-12-07',getdate()) * 24 * 60 * 70;









-- okidači (trigger)


create table logiranje(
tko varchar(255),
sto varchar(255),
kada datetime default getdate()
);

select * from logiranje;

CREATE TRIGGER polaznik_unos
ON polaznik
AFTER INSERT
AS
BEGIN
	insert into logiranje (tko,sto) 
	select 'Unos nove osobe', concat(ime, ' ', prezime) from inserted;

END


insert into polaznik (ime,prezime,email) 
values ('Pero','Perić','email');

select * from logiranje;

CREATE TRIGGER polaznik_promjena
ON polaznik
AFTER Update
AS
BEGIN
	insert into logiranje (tko,sto) 
	SELECT 'Promjena imena osobe', concat(a.ime, ' - ', b.ime)
      FROM Inserted a
      INNER JOIN Deleted b ON a.sifra = b.sifra;
END;


update polaznik set ime='Perica' where sifra=1;

select * from logiranje;


CREATE TRIGGER polaznik_brisanje
ON polaznik
AFTER delete
AS
BEGIN
	insert into logiranje (tko,sto) 
	SELECT 'Brisanje osobe', concat(ime, ' - ', ime) FROM Deleted;
END;

delete from clan where polaznik=1;

delete from polaznik where sifra=1;


select * from logiranje;



-- procedure

CREATE PROCEDURE brisismjer @sifrasmjera int
AS
	delete from clan where grupa in (select sifra from grupa where smjer=@sifrasmjera);

	delete from grupa where smjer = @sifrasmjera;

	delete from smjer where sifra=@sifrasmjera;
GO


select * from smjer;
delete from smjer where sifra=1;
exec brisismjer 1;

select * from smjer;

