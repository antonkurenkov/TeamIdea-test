--Задача: Используя схему БД автомобильного салона с таблицами Brand – марки автомобилей, 
-- доступные для покупки автомобили, составить запрос для поиска количества и 
--общей стоимости автомобилей каждой марки (в определенный момент времени в салоне может 
--не быть автомобилей конкретной марки):

select 
	"Brand"."BrandName" as "Brand", 
	sum("Price") as "Summary per brand",
	count("AutoModel") as "Units"
from "Auto" 
join "Brand" 
on ("Brand"."BrandId" = "Auto"."BrandId") 
group by "Brand"."BrandId";

-- Задача: для приведенной в Задаче 1 схемы данных составить запросы для определения:

-- Марки автомобиля с самой высокой средней стоимостью автомобилей этой марки

select "Brand"."BrandName" as "Brand having biggest average price"
from "Auto" 
join "Brand" 
on ("Brand"."BrandId" = "Auto"."BrandId") 
group by "Brand"."BrandName" 
order by avg("Auto"."Price") desc limit 1;

-- Количества немецких автомобилей

select count("Auto"."AutoModel") as "German cars amount"
from "Auto" 
join "Brand" 
on ("Brand"."BrandId" = "Auto"."BrandId") 
where "Brand"."BrandCountry" = 'Germany';

-- Списка самых дорогих моделей автомобилей каждого бренда

select distinct
	"Brand"."BrandName" as "Brand",
	"Auto"."AutoModel" as "Model",
	temp_.mp as "Price"
from (
	select 
		max("Auto"."Price") as mp, 
		"Auto"."BrandId" as bi
	from "Auto" 
	group by bi) as temp_
join "Brand" on (temp_.bi = "Brand"."BrandId") 
join "Auto" on (temp_.mp = "Auto"."Price") 
order by "Price" desc;



