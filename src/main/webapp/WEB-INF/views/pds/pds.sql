show tables;

create table pds2 (
	idx int not null auto_increment,/* 자료실 고유번호 */
	mid varchar(20) not null,		/* 작성자 아이디 */
	nickName varchar(20) not null,	/* 작성자 닉네임 */
	fName varchar(200) not null,	/* 업로드 시 파일명 */
	fSName varchar(200) not null,	/* 서버에 저장되는 파일명 */
	fSize int not null,				/* 업로드 되는 파일의 총 사이즈 */
	title varchar(100) not null,	/* 업로드파일의 간단 제목 */
	part varchar(20) not null,		/* 파일 분류(카테고리) */
	fDate datetime default now(),	/* 작성 시간 */
	downNum int default 0,			/* 자료를 다운받은 횟수 */
	openSw char(3) default '공개',	/* 자료 공개여부 */
	/* pwd varchar(100),		파일 비공개시 암호 sha256 */
	hostIp varchar(30) not null,	/* 작성자 아이피 */
	content text, 					/* 업로드파일의 상세 내용 */
	primary key(idx),
	foreign key(mid) references member2(mid)
);

desc pds;