package com.yujongu.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.yujongu.Models.User;

public class UserDAO {

	private String url = "jdbc:mysql://localhost:3306/MusicTDB?characterEncoding=UTF-8&serverTimezone=UTC";
	private String username = "root";
	private String password = "Password1";

	private String selectUserSQL = "SELECT * FROM user WHERE uname=? and pword=?;";
	private String selectUsernameSQL = "SELECT uname FROM user WHERE uname=?;";
	private String createUserSQL = "INSERT INTO user (uname, pword) VALUES (?, ?);";
	

	public boolean checkCred(User user) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, username, password);

			PreparedStatement st = con.prepareStatement(selectUserSQL);
			st.setNString(1, user.getUname());
			st.setNString(2, user.getPword());

			ResultSet rs = st.executeQuery();

			if (rs.next()) {
				return true;
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public boolean checkUsername(String uname) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, username, password);

			PreparedStatement st = con.prepareStatement(selectUsernameSQL);
			st.setNString(1, uname);

			ResultSet rs = st.executeQuery();

			if (rs.next()) {
				return true;
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public void addUser(User user) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, username, password);

			PreparedStatement st = con.prepareStatement(createUserSQL);
			st.setNString(1, user.getUname());
			st.setNString(2, user.getPword());
			
			st.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
