package com.mediolio.vo;

/*
 *  DB I/O에 사용 - 데이터를 담는 객체 class
 * */

public class FriendVO {

	private int m_id, m_interesting1, m_interesting2;
	private String m_studentID, m_name, m_introduce, m_interestingText1, m_interestingText2, projects, skills;
	
	public String getProjects() {
		return projects;
	}
	public void setProjects(String projects) {
		this.projects = projects;
	}
	public int getM_id() {
		return m_id;
	}
	public void setM_id(int m_id) {
		this.m_id = m_id;
	}
	public String getM_studentID() {
		return m_studentID;
	}
	public void setM_studentID(String m_studentID) {
		this.m_studentID = m_studentID;
	}
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public String getM_introduce() {
		return m_introduce;
	}
	public void setM_introduce(String m_introduce) {
		this.m_introduce = m_introduce;
	}
	public String getM_interestingText1() {
		return m_interestingText1;
	}
	public void setM_interestingText1(String m_interestingText1) {
		this.m_interestingText1 = m_interestingText1;
	}
	public String getM_interestingText2() {
		return m_interestingText2;
	}
	public void setM_interestingText2(String m_interestingText2) {
		this.m_interestingText2 = m_interestingText2;
	}
	public int getM_interesting1() {
		return m_interesting1;
	}
	public void setM_interesting1(int m_interesting1) {
		this.m_interesting1 = m_interesting1;
	}
	public int getM_interesting2() {
		return m_interesting2;
	}
	public void setM_interesting2(int m_interesting2) {
		this.m_interesting2 = m_interesting2;
	}
	public String getSkills() {
		return skills;
	}
	public void setSkills(String skills) {
		this.skills = skills;
	}

}
