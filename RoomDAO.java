package com.yujongu.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.yujongu.Models.Room;

public class RoomDAO {
	private String url = "jdbc:mysql://localhost:3306/MusicTDB?characterEncoding=UTF-8&serverTimezone=UTC";
	private String username = "root";
	private String password = "Password1";

	private String getPasscodeSQL = "SELECT passcode FROM room WHERE RoomID=?;";
	private String createPListSQL = "INSERT INTO room (UserID, RoomName, CreatedDate, isPrivate, passcode, MusicList) VALUES "
			+ "(?, ?, curdate(), ?, ?, \"\");";
	private String retrieveRoomSQL = "SELECT * FROM room WHERE RoomID=?;";
	private String insertMusicSQL = "UPDATE room SET MusicList = CONCAT(MusicList, ?) WHERE RoomID = ?;";

	UserDAO userDAO;

	public boolean checkPasscode(String rid, String passcode) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, username, password);

			PreparedStatement st = con.prepareStatement(getPasscodeSQL);
			st.setNString(1, rid);

			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				if (passcode.length() < 4) {
					int len = passcode.length();
					for (int i = 0; i < 4 - len; i++) {
						passcode = "0" + passcode;
					}
				}
				String pcode = rs.getNString("passcode");
				if (pcode.equals(passcode)) {
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

	public void createRoom(String owner, String rName, String passcode) {
		userDAO = new UserDAO();

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, username, password);

			PreparedStatement st = con.prepareStatement(createPListSQL);

			st.setInt(1, userDAO.getUserID(owner)); // UserID

			st.setNString(2, rName); // RoomName

			if (passcode.length() < 1) { // isPrivate
				st.setBoolean(3, false);
			} else {
				int len = passcode.length();
				for (int i = 0; i < 4 - len; i++) {
					passcode = "0" + passcode;
				}
				st.setBoolean(3, true);
			}

			st.setNString(4, passcode); // passcode

			st.executeUpdate();

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public Room retrieveRoom(String roomid) {
		UserDAO userDAO;
		Room room;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, username, password);

			PreparedStatement st = con.prepareStatement(retrieveRoomSQL);
			st.setNString(1, roomid);

			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				userDAO = new UserDAO();
				room = new Room(rs.getNString("RoomName"), userDAO.getUserName(rs.getInt("UserID")),
						rs.getDate("CreatedDate"), rs.getNString("MusicList"));
				return room;
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public void insertMusic(String vid, int rid) {
		vid = vid + ",";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, username, password);

			PreparedStatement st = con.prepareStatement(insertMusicSQL);
			st.setNString(1, vid);
			st.setInt(2, rid);

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
