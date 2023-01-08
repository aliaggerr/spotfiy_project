

select * from spotify

--Populerlik indeksi dinlenme sayisi,listede kaldigi gun sayisi ve kac kere peak yaptigi parametreleriyle olusturarak
--en populer 10 sarkiyi listeledim 
SELECT top 10 Artist, Title, 
       round(0.4 * Total + 0.3 * Days + 0.3 * (How_many_PK+1),0) AS popularity_index
FROM spotify
order by 3 desc

--Gecen haftaya göre  siralamasi en cok artan
select Pos_change,Artist,Title,
day_7 as pre_week,round(day_7+day_7_change,0) as cur_weak 
from spotify
where pos_change>0
ORDER BY Pos_change DESC



--Sanatcilari grupladim ve hangi sanatcinin listede kac tane sarkisi oldugunu ve toplam kac kere dinlendigini gosterdim 
select Artist,COUNT(Artist)as song_count,sum(total) as total from spotify
group by Artist
order by 3 desc

--En cok birinci olan sarkilari buldum ve peak olma oranini cikardim 
select Artist,Title,round(How_many_Pk/Days,2) as ratio,Days,How_many_Pk from spotify
where Pk=1
order by ratio desc

--Listedeki sarkicilarin en cok dinlenen sarkilarini sorguladim.
with cte_table as
(select distinct  Artist,max(Total) as total from spotify
group by Artist)
select c.Artist,s.Title,c.total from cte_table as c join 
(select Title,Artist,Total from spotify) as s
on c.Artist=s.Artist and c.total=s.Total
order by 3 desc


--Hangi sanatci kac gün zirvede kaldi
with cte_temple as
(
select Artist,Title,Count(Pk) as count_pk from spotify
where Pk=1
group by Artist,Title
)
select c.Artist,sum(c.count_pk*How_many_pk) as How_Many_Day 
from cte_temple as c left join spotify as s
on c.Artist=s.Artist and c.Title=s.Title
group by c.Artist






