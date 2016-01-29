CREATE TABLE HASHTAG(
	h_id int(10) PRIMARY KEY auto_increment,
	h_value VARCHAR(20),
	p_id int(10),
	cate_id int(10)
);
ALTER TABLE PROJECT DROP p_hash;
ALTER TABLE hashtag CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE MEMBER(	
  m_id int(10) PRIMARY KEY auto_increment,
  m_mail VARCHAR(100),
  m_pw VARCHAR(50),
  m_nickname VARCHAR(50),
  m_gender VARCHAR(10),
  m_studentID VARCHAR(10),
  m_interestingPart VARCHAR(1000),
  m_introduce VARCHAR(500),
  m_joindate DATE
);

CREATE TABLE MEMBER_ACTION(
  act_id int(10) PRIMARY KEY auto_increment,
  act_type VARCHAR(10),
  m_id int(10),
  act_target int(10)
);

CREATE TABLE PROJECT(	
  p_id int(10) PRIMARY KEY auto_increment,
  m_id int(10),
  p_title VARCHAR(300),
  cate_id int(5),
  p_date DATE,
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

CREATE TABLE CATEGORY(	
  cate_id int(5) PRIMARY KEY auto_increment,
  cate_name VARCHAR(30)
);

CREATE TABLE REPLY(	
  r_id int(10) PRIMARY KEY auto_increment,
  m_id int(10),
  r_text VARCHAR(1000),
  r_date DATE
);

CREATE TABLE MESSAGE(
  msg_id int(10) PRIMARY KEY auto_increment,
  msg_from int(10),
  msg_to int(10),
  msg_text VARCHAR(1000),
  msg_date DATE
);

ALTER TABLE category CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE content CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE member CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE member_action CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE message CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE project CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE reply CHARACTER SET utf8 COLLATE utf8_general_ci;
