package com.yujongu.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RoomDAO {
	private String url = "jdbc:mysql://localhost:3306/MusicTDB?characterEncoding=UTF-8&serverTimezone=UTC";
	private String username = "root";
	private String password = "Password1";

	private String getPasscodeSQL = "SELECT passcode FROM room WHERE RoomID=?;";
	
	public boolean checkPasscode(String rid, String passcode) {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, username, password);

			PreparedStatement st = con.prepareStatement(getPasscodeSQL);
			st.setNString(1, rid);

			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				if(passcode.length() < 4) {
					int len = passcode.length();
					for(int i = 0; i < 4 - len; i++) {
						passcode = "0" + passcode;
					}
				}
				String pcode = rs.getNString("passcode");
				if(pcode.equals(passcode)) {
					return true;
				} else {
					return false;
				}
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
}
