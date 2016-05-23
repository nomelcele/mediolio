package com.mediolio.vo;

public class TeamMemberVO {
	int tm_id, p_id, m_id;
	String tm_role, tm_detail, m_studentID, m_name;
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
	public int getTm_id() {
		return tm_id;
	}
	public void setTm_id(int tm_id) {
		this.tm_id = tm_id;
	}
	public int getP_id() {
		return p_id;
	}
	public void setP_id(int p_id) {
		this.p_id = p_id;
	}
	public int getM_id() {
		return m_id;
	}
	public void setM_id(int m_id) {
		this.m_id = m_id;
	}
	
	public String getTm_detail() {
		return tm_detail;
	}
	public void setTm_detail(String tm_detail) {
		this.tm_detail = tm_detail;
	}
	public String getTm_role() {
		return tm_role;
	}
	public void setTm_role(String tm_role) {
		this.tm_role = tm_role;
	}
	
	
}
