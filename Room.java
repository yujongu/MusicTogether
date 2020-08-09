package com.yujongu.Models;

import java.sql.Date;

public class Room {
	String name;
	String owner;
	Date createdDate;
	String musicList;

	public Room(String name, String owner, Date createdDate, String musicList) {
		this.name = name;
		this.owner = owner;
		this.createdDate = createdDate;
		this.musicList = musicList;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public String getMusicList() {
		return musicList;
	}

	public void setMusicList(String musicList) {
		this.musicList = musicList;
	}

}
