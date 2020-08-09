package com.yujongu.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yujongu.DAO.RoomDAO;

/**
 * Servlet implementation class createPlayListServlet
 */
@WebServlet("/cPlayList")
public class createPlayListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	RoomDAO roomDAO;
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		roomDAO = new RoomDAO();
		
		String owner = request.getParameter("owner");
		String roomname = request.getParameter("pName");
		String passcode = request.getParameter("passcode");
		
		roomDAO.createRoom(owner, roomname, passcode);
		
		response.sendRedirect("MusicTogether.jsp");
	}

}
