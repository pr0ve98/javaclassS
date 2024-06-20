show tables;

create table crime (
	idx int not null auto_increment primary key,
	year int not null,			/* 강력범죄 발생년도 */
	police varchar(20) not null,/* 경찰서명 */
	murder int,					/* 살인사건 수 */
	robbery int,				/* 강도사건 수 */
	theft int,					/* 절도사건 수 */
	violence int				/* 폭력사건 수 */
);

desc crime;

select * from crime;