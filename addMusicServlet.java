package com.yujongu.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yujongu.DAO.RoomDAO;

/**
 * Servlet implementation class addMusicServlet
 */
@WebServlet("/addMusic")
public class addMusicServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RoomDAO roomDAO;
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		doPost(req, resp);
		return;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int rID = Integer.parseInt(request.getParameter("rID"));
		String vID = request.getParameter("vID");

		roomDAO = new RoomDAO();
		roomDAO.insertMusic(vID, rID);
		
		response.sendRedirect("Playlist.jsp?rID=" + rID);
	}

}
