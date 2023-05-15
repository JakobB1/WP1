--use edunovawp1;

select * from smjer;

-- najlošiji način
-- 1
insert into smjer 
values ('Web programiranje ŠĆ',250,1473.82,73,1);

--malo bolji način
-- 2
insert into smjer(naziv,trajanje)
values ('Java programiranje',130);

-- dobra praksa
-- 3
insert into smjer (naziv,trajanje,cijena,upisnina,verificiran)
values ('Serviser',150,null,null,0);