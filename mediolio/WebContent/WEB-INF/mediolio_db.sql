CREATE TABLE MEMBER(	
  m_id int(10) PRIMARY KEY,
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
  act_id int(10) PRIMARY KEY,
  act_type VARCHAR(10),
  m_id int(10),
  act_target int(10)
);

CREATE TABLE PROJECT(	
  p_id int(10) PRIMARY KEY,
  m_id int(10),
  p_title VARCHAR(300),
  cate_id int(5),
  p_hash VARCHAR(500),
  p_date DATE,
  p_viewnum int(10),
  p_coverImg VARCHAR(100)
);

CREATE TABLE CONTENT(	
  c_id int(5) PRIMARY KEY,
  p_id int(10),
  c_type VARCHAR(10),
  c_value VARCHAR(1000),
  c_order int(5)
);

CREATE TABLE CATEGORY(	
  cate_id int(5) PRIMARY KEY,
  cate_name VARCHAR(30)
);

CREATE TABLE REPLY(	
  r_id int(10) PRIMARY KEY,
  m_id int(10),
  r_text VARCHAR(1000),
  r_date DATE
);

CREATE TABLE MESSAGE(
  msg_id int(10) PRIMARY KEY,
  msg_from int(10),
  msg_to int(10),
  msg_text VARCHAR(1000),
  msg_date DATE
);

CREATE SEQUENCE m_id_seq;
CREATE SEQUENCE act_id_seq;
CREATE SEQUENCE p_id_seq;
CREATE SEQUENCE c_id_seq;
CREATE SEQUENCE cate_id_seq;
CREATE SEQUENCE r_id_seq;
CREATE SEQUENCE msg_id_seq;