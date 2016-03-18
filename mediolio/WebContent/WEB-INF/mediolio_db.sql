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
  m_mail VARCHAR(100),
  m_pw VARCHAR(50),
  m_name VARCHAR(50),
  m_gender VARCHAR(10),
  m_studentID VARCHAR(10),
  m_interestingPart VARCHAR(10),
  m_introduce VARCHAR(500),
  m_joindate DATE
);

CREATE TABLE MEMBER_ACTION(
  act_id int(10) PRIMARY KEY auto_increment,
  act_type VARCHAR(10),
  act_from int(10),
  act_to int(10),
  act_target int(10),
  act_date datetime,
  act_read int(2)
);

CREATE TABLE PROJECT(	
  p_id int(10) PRIMARY KEY auto_increment,
  m_id int(10),
  p_title VARCHAR(300),
  p_summary VARCHAR(2000),
  p_workfrom DATE,
  p_workto DATE,
  p_relateclass VARCHAR(30),
  cate_id int(5),
  sc_id VARCHAR(10),
  p_date datetime,
  p_viewnum int(10),
  p_coverImg VARCHAR(100)
);

CREATE TABLE CONTENT(	
  c_id int(5) PRIMARY KEY auto_increment,
  p_id int(10),
  c_type VARCHAR(10),
  c_value VARCHAR(1000),
  c_order int(5)
);

CREATE TABLE TEAMMEMBER(
	tm_id int(10) PRIMARY KEY auto_increment,
	p_id int(10),
	m_id int(10),
	tm_role VARCHAR(100)
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

CREATE TABLE SUBCATEGORY(
  sc_id int(5) PRIMARY KEY auto_increment,
  sc_name VARCHAR(30),
  sc_parent int(5)
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

ALTER TABLE member CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE member_action CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE subcategory CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE category CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE content CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE project CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE teammember CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE reply CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE hashtag CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE message CHARACTER SET utf8 COLLATE utf8_general_ci;


INSERT into CATEGORY (cate_name) values ('게임');
INSERT into CATEGORY (cate_name) values ('웹&앱');
INSERT into CATEGORY (cate_name) values ('영상&사운드');
INSERT into CATEGORY (cate_name) values ('3D');
INSERT into CATEGORY (cate_name) values ('디자인');
INSERT into CATEGORY (cate_name) values ('기타');


INSERT into SUBCATEGORY (sc_name, sc_parent) values ('기획',1);
INSERT into SUBCATEGORY (sc_name, sc_parent) values ('개발',1);
INSERT into SUBCATEGORY (sc_name, sc_parent) values ('기획',2);
INSERT into SUBCATEGORY (sc_name, sc_parent) values ('개발',2);
INSERT into SUBCATEGORY (sc_name, sc_parent) values ('시나리오',3);
INSERT into SUBCATEGORY (sc_name, sc_parent) values ('연출',3);
INSERT into SUBCATEGORY (sc_name, sc_parent) values ('촬영',3);
INSERT into SUBCATEGORY (sc_name, sc_parent) values ('OAP',3);
INSERT into SUBCATEGORY (sc_name, sc_parent) values ('사운드',3);
INSERT into SUBCATEGORY (sc_name, sc_parent) values ('모델링',4);
INSERT into SUBCATEGORY (sc_name, sc_parent) values ('애니메이션',4);
INSERT into SUBCATEGORY (sc_name, sc_parent) values ('디자인',5);
INSERT into SUBCATEGORY (sc_name, sc_parent) values ('기타',6);




