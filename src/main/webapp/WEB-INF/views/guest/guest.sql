show tables;

create table guest2 (
	idx int not null auto_increment primary key, /* 방명록 고유번호 */
	name varchar(20) not null, /* 방명록 작성자 성명 */
	content text not null, /* 방명록 내용 */
	email varchar(60), /* 메일 주소 */
	homePage varchar(60), /* 홈페이지(블로그) */
	visitDate datetime default now(), /* 방문 일자와 시간 */
	hostIp varchar(30) not null /* 방문자의 접속 아이피 */
);

desc guest2;

insert into guest2 values (default, '관리자', '방명록 서비스를 시작합니다.', 'sejun9891@naver.com', 'www.homepage.com', default, '192.168.50.66');

select * from guest2;