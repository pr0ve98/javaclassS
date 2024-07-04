show tables;

create table itGame (
	gameIdx int not null auto_increment primary key,
	gameTitle varchar(500) not null unique key,
	gameSubTitle varchar(500),
	jangre varchar(100),
	platform varchar(100),
	showDate date,
	price varchar(20),
	metascore double,
	steamscore varchar(20),
	developer varchar(50),
	gameImg text
);

drop table itGame;