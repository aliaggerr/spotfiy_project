select * from spotify

select Streams+Streams_change from spotify

--ArtistandTitle sutunundaki sarkicilar ve sarkilari ayirarak iki ayri sutuna ekledim
select substring(ArtistandTitle,1,charindex('-',ArtistandTitle)-1), substring(ArtistandTitle,charindex('-',ArtistandTitle)+1,len(ArtistandTitle)) 
from spotify

alter table spotify
add Artist varchar(33)

alter table spotify
add Title varchar(33)

update spotify
set Artist=substring(ArtistandTitle,1,charindex('-',ArtistandTitle)-1)

alter table spotify
alter column Title varchar(100)
update spotify
set Title=substring(ArtistandTitle,charindex('-',ArtistandTitle)+1,len(ArtistandTitle))
--Sarkinin kac kere pink yaptigini gosteren sutunun numaralastirdim
select substring(How_many_Pk,3,len(How_many_Pk)-3) from spotify

update spotify
set How_many_Pk=substring(How_many_Pk,3,len(How_many_Pk)-3)


--Siralama degisikliginde ki '=' degisik olmadigi anlamina gelen esittir isaretini '0' yaptim
update spotify
set Pos_change=0
where Pos_change='='
--Pos _change sutununu int e cevirdim
update spotify
set Pos_change=cast(Pos_change as int) 

alter table spotify
alter column Pos_change int


SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'spotify'
--How_many_pk , 7day ve total sutunlarini float a cevir
alter table spotify
alter column How_many_Pk float
--7day sutununun ilk once adini degistir sonra virgulleri kaldir sonra float a cevir
EXEC sp_rename 'spotify.7day', 'day_7', 'COLUMN';

update spotify
set day_7=replace(day_7,',','')

alter table spotify
alter column day_7 float
--total sutununda ki virgulleri kaldir ve float a cevir
update spotify
set total=replace(day_7,',','')

alter table spotify
alter column total float

--7Day_change sutununun adini degistir 
EXEC sp_rename 'spotify.7Day_change', 'day_7_change', 'COLUMN';

--Son olarak How_many_pf sutunundaki null degerleri 0 a cevir
update spotify
set How_many_Pk=0
where How_many_Pk is null
--Verisetim analiz icin hazir.