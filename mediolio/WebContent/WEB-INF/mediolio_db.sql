/*
 * 5.23 테이블 수정
 */
ALTER TABLE teammember ADD tm_detail VARCHAR(200);

/*
 * 5.7 보유기술 추가
 */
INSERT INTO `mediolio`.`skills` (`sk_id`, `sk_name`) VALUES ('32', 'R');
INSERT INTO `mediolio`.`skills` (`sk_id`, `sk_name`) VALUES ('33', '하둡');
INSERT INTO `mediolio`.`skills` (`sk_id`, `sk_name`) VALUES ('34', '루비');
INSERT INTO `mediolio`.`skills` (`sk_id`, `sk_name`) VALUES ('35', 'node.js');

/* 4월 8일 
 * history 테이블 m_id, ht_public 컬럼 추가
 * ht_color 컬럼 삭제 */
alter table history add m_id int(10); -- 히스토리 작성자
alter table history add ht_public int(2); -- 히스토리 공개 여부
alter table history drop ht_color;

DROP TABLE member;
DROP TABLE member_action;
DROP TABLE category;
DROP TABLE subcategory;
DROP TABLE project;
DROP TABLE content;
DROP TABLE reply;
DROP TABLE hashtag;
DROP TABLE message;

CREATE TABLE MEMBER(
  m_id int(10) PRIMARY KEY auto_increment,
  m_mail VARCHAR(50),
  m_pw VARCHAR(50),
  m_name VARCHAR(30),
  m_gender VARCHAR(10),
  m_studentID VARCHAR(10),
  m_interesting1 int(10),
  m_interesting2 int(10),
  m_introduce VARCHAR(500),
  m_joindate DATE
);

CREATE TABLE MEMBER_ACTION(
  act_id int(10) PRIMARY KEY auto_increment,
  act_type VARCHAR(10),
  act_from int(10),
  act_to int(10),
  act_what int(10),
  act_date datetime,
  act_read int(2)
);

CREATE TABLE PROJECT(
  p_id int(10) PRIMARY KEY auto_increment,
  m_id int(10),
  p_title VARCHAR(300),
  p_type int(2),
  p_prjname VARCHAR(50),
  p_summary VARCHAR(2000),
  p_workfrom DATE,
  p_workto DATE,
  cl_id int(3),
  ht_id int(10),
  cate_id int(5),
  p_date datetime,
  p_viewnum int(10),
  p_coverImg VARCHAR(500)
);

CREATE TABLE CONTENT(
  c_id int(5) PRIMARY KEY auto_increment,
  p_id int(10),
  c_type VARCHAR(10),
  c_value VARCHAR(1500),
  c_order int(5)
);

CREATE TABLE TEAMMEMBER(
	tm_id int(10) PRIMARY KEY auto_increment,
	p_id int(10),
	m_id int(10),
	tm_role VARCHAR(10),
	tm_detail VARCHAR(200)
);

CREATE TABLE HASHTAG(
	h_id int(10) PRIMARY KEY auto_increment,
	h_value VARCHAR(30),
	p_id int(10)
);

CREATE TABLE REPLY(
  r_id int(10) PRIMARY KEY auto_increment,
  m_id int(10),
  p_id int(10),
  r_text VARCHAR(1000),
  r_date datetime
);

CREATE TABLE CATEGORY(	
  cate_id int(5) PRIMARY KEY auto_increment,
  cate_name VARCHAR(30)
);

CREATE TABLE CLASS(
	cl_id int(3) PRIMARY KEY auto_increment,
	cl_name VARCHAR(30)
);

CREATE TABLE MEMBERSKILL(
	m_id int(10),
	sk_id int(3),
	PRIMARY KEY (m_id, sk_id),
	UNIQUE INDEX (m_id, sk_id)
);

CREATE TABLE SKILLS(
	sk_id int(3) PRIMARY KEY auto_increment,
	sk_name VARCHAR(15)
);

CREATE TABLE MESSAGE(
  msg_id int(10) PRIMARY KEY auto_increment,
  msg_from int(10),
  msg_to int(10),
  msg_text VARCHAR(1000),
  msg_date datetime,
  msg_from_status VARCHAR(10),
  msg_to_status VARCHAR(10)
);

CREATE TABLE HISTORY(
  ht_id int(10) PRIMARY KEY auto_increment,
  ht_title VARCHAR(100),
  ht_introduce VARCHAR(500),
  cl_id int(3),
  ht_lastedit datetime,
  ht_createdate datetime,
  m_id int(10),
  ht_public int(2)
);

CREATE TABLE BRANCH(
  br_id int(10) PRIMARY KEY auto_increment,
  ht_id int(10),
  br_title VARCHAR(100),
  br_img1 VARCHAR(500),
  br_img2 VARCHAR(500),
  br_img3 VARCHAR(500),
  br_text VARCHAR(1000),
  br_date datetime,
  br_public int(2)
);

ALTER TABLE member CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE member_action CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE class CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE skills CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE memberskill CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE category CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE content CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE project CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE teammember CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE reply CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE hashtag CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE message CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE history CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE branch CHARACTER SET utf8 COLLATE utf8_general_ci;

INSERT into CATEGORY (cate_name) values ('게임');
INSERT into CATEGORY (cate_name) values ('웹&앱');
INSERT into CATEGORY (cate_name) values ('영상&사운드');
INSERT into CATEGORY (cate_name) values ('3D');
INSERT into CATEGORY (cate_name) values ('디자인');
INSERT into CATEGORY (cate_name) values ('기타');

INSERT INTO CLASS (cl_name) values 
 ('디자인기초'),('미디어통계'), ('정보디자인'), ('시각정보그래픽스'), ('인터랙션디자인'), ('인터페이스디자인'), ('크로키'), ('디지털타이포그래피'), 
 ('피지컬인터랙션디자인'), ('창의적콘텐츠디자인1'), ('창의적콘텐츠디자인2'), ('뉴미디어와모션그래픽스'), ('UX디자인'), ('그래픽디자인'), 
 ('게임기획개론'), ('게임디자인'),('게임프로그래밍1'), ('게임프로그래밍2'), ('게임애니메이션'), ('게임상호작용디자인'), ('게임스토리텔링'), 
 ('컴퓨터프로그래밍'), ('자료구조'), ('알고리즘'), ('운영체제'), ('모바일프로그래밍1'), ('모바일프로그래밍2'), ('컴퓨터그래픽스'), 
 ('객체지향프로그래밍'), ('웹앱프로그래밍'), ('앱프로젝트'), ('데이터베이스'), ('데이터시각화'), 
 ('컴퓨터애니메이션'), ('리얼타임애니메이션1'), ('리얼타임애니메이션2'), ('애니메이션이론'),
 ('애니메이션미학'), ('영상미학'), ('영상연출'), ('영상합성'), ('디지털사운드기초'), ('스마트콘텐츠사운드제작'), ('영상사운드제작'), ('영상편집론'), 
 ('미디어와창업'), ('창업실습'), ('창업현장실습'), ('미디어프로젝트1'), ('미디어프로젝트2'), ('이머징미디어특론'), ('인터내셔널세미나'), ('해외인턴쉽'), 
 ('미디어현장실습'), ('미디어집중교육'), ('인지과학응용');								
									
INSERT INTO SKILLS (sk_name) values
('C'), ('C#'), ('C++'), ('Unity'), ('COCOS-2D'), ('게임샐러드'), ('언리얼엔진4'), ('DirectX'), ('OpenGL'),
('JAVA'), ('Javascript'), ('python'), ('PHP'), ('JSP'), ('Android'), ('iOS'), ('MySQL'), ('Oracle'), ('MS-SQL'),
('아두이노'), ('라즈베리파이'),
('Premiere'), ('After Effect'), ('NUKE'), ('촬영'), ('PROTOOLS'), ('MAYA'), ('3DMAX'),
('포토샵'), ('일러스트레이터'), ('인디자인'), ('R'), ('하둡'), ('루비'), ('node.js');



