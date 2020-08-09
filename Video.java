package com.yujongu.Models;

public class Video {
	String title;
	String vID;
	String imgURL;
	
	
	public Video(String title, String vID, String imgURL) {
		this.title = title;
		this.vID = vID;
		this.imgURL = imgURL;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getvID() {
		return vID;
	}
	public void setvID(String vID) {
		this.vID = vID;
	}
	public String getImgURL() {
		return imgURL;
	}
	public void setImgURL(String imgURL) {
		this.imgURL = imgURL;
	}
	
	
	

}
