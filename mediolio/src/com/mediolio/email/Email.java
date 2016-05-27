package com.mediolio.email;

/*
 * ***** 박성준 작성 class
 * ***** 임시비밀번호 메일 정보 저장
 */

public class Email {
	private String subject;
    private String content;
    private String receiver;
     
    public String getReceiver() {
        return receiver;
    }
    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }
	public String getSubject() {
		return subject;
	}
    public void setSubject(String subject) {
        this.subject = subject;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }



}
