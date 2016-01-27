CREATE TABLE MEMBER(	
  m_id NUMBER(10) PRIMARY KEY,
  m_mail VARCHAR2(100),
  m_pw VARCHAR2(50),
  m_nickname VARCHAR2(50),
  m_gender VARCHAR2(10),
  m_studentID VARCHAR2(10),
  m_interestingPart VARCHAR2(1000),
  m_introduce VARCHAR2(500),
  m_joindate DATE
);

CREATE TABLE MEMBER_ACTION(
  act_id NUMBER(10) PRIMARY KEY,
  act_type VARCHAR2(10),
  m_id NUMBER(10),
  act_target NUMBER(10)
);

CREATE TABLE PROJECT(	
  p_id NUMBER(10) PRIMARY KEY,
  m_id NUMBER(10),
  p_title VARCHAR2(300),
  cate_id NUMBER(5),
  p_hash VARCHAR2(500),
  p_date DATE,
  p_viewnum NUMBER(10),
  p_goodnum NUMBER(10),
  p_replynum NUMBER(10),
  p_coverImg VARCHAR2(100)
);

CREATE TABLE CONTENT(	
  c_id NUMBER(10) PRIMARY KEY,
  p_id NUMBER(10),
  c_type VARCHAR2(10),
  c_value VARCHAR2(1000),
  c_order NUMBER(5)
);

CREATE TABLE CATEGORY(	
  cate_id NUMBER(5) PRIMARY KEY,
  cate_groupID NUMBER(5),
  cate_groupName VARCHAR2(30),
  cate_name VARCHAR2(30)
);

CREATE TABLE REPLY(	
  r_id NUMBER(10) PRIMARY KEY,
  m_id NUMBER(10),
  r_text VARCHAR2(1000),
  r_date DATE
);

CREATE TABLE MESSAGE(
  msg_id NUMBER(10) PRIMARY KEY,
  msg_from NUMBER(10),
  msg_to NUMBER(10),
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