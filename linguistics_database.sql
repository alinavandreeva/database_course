create database translation;
use translation;
create table words (
id int primary key not null,
words varchar(255),
pos varchar(255));

insert into words values
('1', 'house', 'noun'),
('2', 'build', 'verb'),
('3', 'big', 'adj'),
('4', 'and', 'conj'),
('5', 'beautiful', 'adj');
select * from words;
select * from translations;
alter table translations add primary key (id_ger);
alter table translations add foreign key (id_eng)
references words(id);

# создаю третью таблицу
create table fr_translation (
id_fr int primary key not null,
word varchar(255),
id_eng int);
# наполняю таблицу
insert into fr_translation values
('1', 'belle', '5'),
('2', 'et', '4'),
('3', 'grande', '3'),
('4', 'construire', '2'),
('5', 'maison', '1');
select * from fr_translation;
# добавляю внешний ключ
alter table fr_translation add foreign key (id_eng) references words(id);

# добавляю столбец и лишние строки
alter table fr_translation add column pos varchar(20);
alter table fr_translation drop primary key;
alter table fr_translation modify column id_fr
int not null unique auto_increment primary key;
insert into fr_translation (pos) values ('noun'), ('adverb');

# удаляю лишние строки
delete from fr_translation where pos is not null;

# добавляю информацию в столбец pos
update fr_translation set pos='adj' where id_fr in ('1', '3');
update fr_translation set pos='conj' where id_fr in ('2');
update fr_translation set pos='verb' where id_fr in ('4');
update fr_translation set pos='noun' where id_fr in ('5');

# запросы
select word from fr_translation where pos='noun';
select * from fr_translation where pos='adj' and word like '%le';
select word from translations where id_ger='3';