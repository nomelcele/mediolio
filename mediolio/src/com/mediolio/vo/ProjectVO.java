package com.mediolio.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ProjectVO {
	private int p_id, m_id, cate_id, p_viewnum, p_likenum, p_type, cl_id, ht_id;
	private String p_title, p_hash, p_date, p_coverImg, hashtags, authorID, authorName, p_prjname, p_summary, p_workfrom, p_workto, cate_name;

	private List<MultipartFile> contents;
	private MultipartFile doc;
	
	public MultipartFile getDoc() {
		return doc;
	}
	public void setDoc(MultipartFile doc) {
		this.doc = doc;
	}
	public int getCl_id() {
		return cl_id;
	}
	public void setCl_id(int cl_id) {
		this.cl_id = cl_id;
	}
	public int getHt_id() {
		return ht_id;
	}
	public void setHt_id(int ht_id) {
		this.ht_id = ht_id;
	}
	public String getP_workfrom() {
		return p_workfrom;
	}
	public void setP_workfrom(String p_workfrom) {
		this.p_workfrom = p_workfrom;
	}
	public String getP_workto() {
		return p_workto;
	}
	public void setP_workto(String p_workto) {
		this.p_workto = p_workto;
	}
	public int getP_type() {
		return p_type;
	}
	public void setP_type(int p_type) {
		this.p_type = p_type;
	}
	public String getAuthorID() {
		return authorID;
	}
	public void setAuthorID(String authorID) {
		this.authorID = authorID;
	}
	public String getAuthorName() {
		return authorName;
	}
	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}
	public String getCate_name() {
		return cate_name;
	}
	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}
	public String getP_prjname() {
		return p_prjname;
	}
	public void setP_prjname(String p_prjname) {
		this.p_prjname = p_prjname;
	}
	public String getP_summary() {
		return p_summary;
	}
	public void setP_summary(String p_summary) {
		this.p_summary = p_summary;
	}
	public List<MultipartFile> getContents() {
		return contents;
	}
	public void setContents(List<MultipartFile> contents) {
		this.contents = contents;
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
	public int getCate_id() {
		return cate_id;
	}
	public void setCate_id(int cate_id) {
		this.cate_id = cate_id;
	}
	public int getP_viewnum() {
		return p_viewnum;
	}
	public void setP_viewnum(int p_viewnum) {
		this.p_viewnum = p_viewnum;
	}
	public String getP_title() {
		return p_title;
	}
	public void setP_title(String p_title) {
		this.p_title = p_title;
	}
	public String getP_hash() {
		return p_hash;
	}
	public void setP_hash(String p_hash) {
		this.p_hash = p_hash;
	}
	public String getP_date() {
		return p_date;
	}
	public void setP_date(String p_date) {
		this.p_date = p_date;
	}
	public String getP_coverImg() {
		return p_coverImg;
	}
	public void setP_coverImg(String p_coverImg) {
		this.p_coverImg = p_coverImg;
	}
	public String getHashtags() {
		return hashtags;
	}
	public void setHashtags(String hashtags) {
		this.hashtags = hashtags;
	}
	public int getP_likenum() {
		return p_likenum;
	}
	public void setP_likenum(int p_likenum) {
		this.p_likenum = p_likenum;
	}
	
	
}
