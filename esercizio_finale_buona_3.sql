#esercitazione finale - task 2: implementazione fisica
create database negozio_giocattoli;

use negozio_giocattoli;

create table Region (
region_key int auto_increment primary key,
region_name varchar (50)
);

create table State (
state_key varchar(2) primary key,
state_name varchar (50),
region_key int,
foreign key (region_key) references Region (region_key)
);


create table Category (
product_category_key int auto_increment primary key,
category_name varchar (50)
);

create table Product (
product_key int auto_increment primary key,
product_name varchar (50),
product_price decimal (10,2),
product_category_key int,
foreign key (product_category_key) references Category (product_category_key)
);

create table Sales (
sale_code int auto_increment primary key,
product_key int,
state_key varchar (2),
quantity int not null,
total_price decimal (10,2),
sale_date date,
foreign key (product_key) references Product (product_key),
foreign key (state_key) references State (state_key)
);

show tables;
describe category;
describe product;
describe sales;
describe state;
describe region;

#task 3: popola la tabella

insert into Region (region_key, region_name)
values 
(1, 'south_europe'),
(2, 'north_europe'),
(3, 'east_europe'),
(4, 'west_europe');

insert into State (state_key, state_name, region_key)
values
("IT", "italy",1),
("FR", "france", 4),
("BE", "belgium", 4),
("GR", "greece",1),
("GE", "germany",2),
("DK", "denmark", 2),
("PL", "poland", 3),
("RO", "romania", 3);
 
insert into Category (product_category_key, category_name)
values
(1, 'board_games'),
(2, 'card_games'),
(3, 'puzzles'),
(4, 'educational'),
(5, 'outdoor'),
(6, 'plush_toys');

insert into Product (product_name, product_price, product_category_key)
values 
('Catan', 45.00, 1),
('Monopoly', 35.00, 1),
('Uno', 12.00, 2),
('Exploding Kittens', 20.00, 2),
('Ravensburger Puzzle 1000pz', 18.00, 3),
('Rubik\'s Cube', 10.00, 3),
('Microscopio Junior', 30.00, 4),
('Kit di chimica', 28.00, 4),
('Frisbee', 8.00, 5),
('Pallone da calcio', 15.00, 5),
('Orsetto Teddy', 25.00, 6),
('Peluche dinosauro', 22.00, 6);
    
select * from Product;

insert into Sales (product_key, state_key, quantity, total_price, sale_date)
values 
(1, 'IT', 1, 44.36, '2025-01-03'),
(4, 'IT', 4, 69.40, '2023-03-23'),
(6, 'IT', 5, 209.10, '2022-05-18'),
(1, 'BE', 2, 71.16, '2022-05-14'),
(1, 'BE', 5, 162.80, '2023-11-30'),
(5, 'FR', 2, 26.18, '2024-04-14'),
(1, 'BE', 1, 31.03, '2022-08-26'),
(5, 'DK', 3, 108.90, '2023-01-03'),
(4, 'DK', 1, 13.27, '2022-11-08'),
(12, 'IT', 1, 34.80, '2024-08-24'),
(3, 'BE', 3, 117.15, '2025-03-16'),
(6, 'IT', 2, 78.20, '2022-12-12'),
(2, 'FR', 2, 37.60, '2023-07-09'),
(8, 'DK', 5, 182.50, '2022-10-30'),
(9, 'FR', 4, 123.60, '2024-05-06'),
(7, 'IT', 2, 72.60, '2023-02-11'),
(10, 'BE', 1, 18.40, '2025-06-02'),
(3, 'DK', 3, 98.70, '2024-09-15'),
(1, 'FR', 5, 159.50, '2023-11-04'),
(11, 'BE', 4, 92.80, '2022-04-22'),
(2, 'DK', 2, 48.60, '2023-08-10'),
(6, 'BE', 1, 33.40, '2024-07-12'),
(7, 'IT', 2, 78.00, '2022-03-28'),
(4, 'BE', 3, 47.10, '2024-01-18'),
(9, 'DK', 2, 66.60, '2022-02-15'),
(5, 'FR', 4, 98.40, '2023-10-22'),
(8, 'BE', 1, 33.70, '2024-02-11'),
(10, 'DK', 2, 38.00, '2023-03-05'),
(2, 'IT', 5, 101.25, '2022-06-27'),
(11, 'DK', 3, 71.85, '2024-11-09'),
(12, 'BE', 2, 73.60, '2022-12-01'),
(3, 'FR', 2, 76.20, '2023-06-18'),
(6, 'DK', 3, 120.30, '2024-04-25'),
(7, 'BE', 2, 74.40, '2025-05-03'),
(9, 'IT', 1, 31.20, '2022-01-19'),
(2, 'BE', 4, 97.20, '2023-12-14'),
(4, 'FR', 3, 49.80, '2024-08-06'),
(8, 'IT', 2, 70.00, '2025-02-26'),
(10, 'FR', 1, 19.20, '2022-09-03'),
(5, 'BE', 2, 44.80, '2023-05-25');

select * from Sales;

#Task 4: 
#1)	Verificare che i campi definiti come PK siano univoci. In altre parole, scrivi una query per determinare l’univocità dei valori di ciascuna PK (una query per tabella implementata).
show tables;
describe product;
select count(*) from product where product_key is null;
describe category;
select count(*) from category where category_name is null;

describe sales;
select * from sales; 
select count(*) from sales where sale_code is null;

#2)	Esporre l’elenco delle transazioni indicando nel result set il codice documento, la data, il nome del prodotto, la categoria del prodotto, il nome dello stato, il nome della regione di vendita e un campo booleano valorizzato in base alla condizione che siano passati più di 180 giorni dalla data vendita o meno (>180 -> True, <= 180 -> False) 

select s.sale_code, s.sale_date, p.product_name, c.category_name, st.state_name, r.region_name,
if (datediff(now(),s.sale_date)>180, "si", "no") as giorni_passati_maggiori_di_180
from sales s
join product p on p.product_key = s.product_key
join category c on c.product_category_key = p.product_category_key
join state st on st.state_key = s.state_key
join region r on r.region_key = st.region_key
order by s.sale_code asc;

#3)	Esporre l’elenco dei prodotti che hanno venduto, in totale, una quantità maggiore della media delle vendite realizzate nell’ultimo anno censito. (ogni valore della condizione deve risultare da una query e non deve essere inserito a mano). Nel result set devono comparire solo il codice prodotto e il totale venduto.
#scopongo il problema iniziando dal cercare l'ultimo anno censito, cioè il più recente
select max(year(sale_date)) as ultimo_anno_censito from sales;
#ed è il 2025 , ora calcolo la media delle quantità vendute in quell anno unendo la subquery
select avg(quantity) as avg_quantita_venduta
from sales
where year(sale_date) = (select max(year(sale_date)) as ultimo_anno_censito from sales);

#ora le metto insieme calcolando la somma totale per prodotto ma solo se hanno più della media del 2025 e siccome voglio metterci il nome per rendere la tabella più chiara faccio anche una join

select s.product_key, p. product_name as ProdottiPiùVenduti2025, sum(s.quantity) as totale_quantity
from sales s
join product p on p.product_key = s.product_key
group by s.product_key
having sum(s.quantity)> (select avg(s.quantity) as avg_quantita_venduta
from sales s
where year(s.sale_date) = (select max(year(s.sale_date)) as ultimo_anno_censito from sales s))
order by totale_quantity desc;

#catan è il mio preferito infatti

#4)	Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno. 
select year (s.sale_date) as anno, sum(s.total_price) as totale_fatturato_annuo, p.product_name
from sales s
join product p on p.product_key = s.product_key
group by p.product_name, year (s.sale_date); 

describe state;
#5)	Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente.
select  st.state_name, sum(s.total_price) as totale_fatturato_annuo, year (s.sale_date) as anno
from sales s
join product p on p.product_key = s.product_key
join state st on st.state_key = s.state_key
group by st.state_name, year (s.sale_date)
order by anno, totale_fatturato_annuo desc;

#6)	Rispondere alla seguente domanda: qual è la categoria di articoli maggiormente richiesta dal mercato?
#in questo caso dobbiamo usare limit 1 per prendere solo la riga con il massimo totale dopo aver ordinato per totale quantity dal più alto al più basso

select c.category_name, sum(quantity) as totale_quantity
from sales s
join product p on p.product_key = s.product_key
join category c on c.product_category_key = p.product_category_key
group by c.category_name
order by totale_quantity desc
limit 1; 

#7)	Rispondere alla seguente domanda: quali sono i prodotti invenduti? Proponi due approcci risolutivi differenti.
#per vedere i prodotti invenduti divido il mio problema in sottoproblemi, cioè prima vedo quali sono i prodotti venduti
select distinct product_key from sales;
#ora uso not in per vedere quelli non venduti tra quelli venduti con una subquery

select * from product
where product_key not in (select distinct product_key from sales);
#non ci sono

#nel secondo approccio faccio una left join tra tutti i prodotti (product) e quelli venduti (sales) e filtro per quelli che in sales sono nulli
select *
from product p
left join sales s on p.product_key = s.product_key
where s.product_key is null;
#stesso risultato

#8)	Creare una vista sui prodotti in modo tale da esporre una “versione denormalizzata” delle informazioni utili (codice prodotto, nome prodotto, nome categoria)
create view versione_denormalizzata as 
select p.product_key, p.product_name, c.category_name 
from product p
join category c on p.product_category_key = c.product_category_key; 

select * from versione_denormalizzata;

#9)	Creare una vista per le informazioni geografiche
create view info_geo as 
select st.state_key, st.state_name, r.region_key, r.region_name 
from state st 
join region r on st.region_key= r.region_key;

select * from info_geo;