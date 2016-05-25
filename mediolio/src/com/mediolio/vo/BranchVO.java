package com.mediolio.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class BranchVO {
	private int br_id, ht_id, br_public;
	private String br_title, br_img1, br_img2, br_img3, br_text, br_date, historyTitle;
	private List<MultipartFile> imgFiles;
	
	public String getHistoryTitle() {
		return historyTitle;
	}
	public void setHistroyTitle(String historyTitle) {
		this.historyTitle = historyTitle;
	}
	public List<MultipartFile> getImgFiles() {
		return imgFiles;
	}
	public void setImgFiles(List<MultipartFile> imgFiles) {
		this.imgFiles = imgFiles;
	}
	public int getBr_id() {
		return br_id;
	}
	public void setBr_id(int br_id) {
		this.br_id = br_id;
	}
	public int getHt_id() {
		return ht_id;
	}
	public void setHt_id(int ht_id) {
		this.ht_id = ht_id;
	}
	public int getBr_public() {
		return br_public;
	}
	public void setBr_public(int br_public) {
		this.br_public = br_public;
	}
	public String getBr_title() {
		return br_title;
	}
	public void setBr_title(String br_title) {
		this.br_title = br_title;
	}
	public String getBr_img1() {
		return br_img1;
	}
	public void setBr_img1(String br_img1) {
		this.br_img1 = br_img1;
	}
	public String getBr_img2() {
		return br_img2;
	}
	public void setBr_img2(String br_img2) {
		this.br_img2 = br_img2;
	}
	public String getBr_img3() {
		return br_img3;
	}
	public void setBr_img3(String br_img3) {
		this.br_img3 = br_img3;
	}
	public String getBr_text() {
		return br_text;
	}
	public void setBr_text(String br_text) {
		this.br_text = br_text;
	}
	public String getBr_date() {
		return br_date;
	}
	public void setBr_date(String br_date) {
		this.br_date = br_date;
	}
	
	
}
