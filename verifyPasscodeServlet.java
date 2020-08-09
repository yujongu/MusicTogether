package com.yujongu.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yujongu.DAO.RoomDAO;

/**
 * Servlet implementation class verifyPasscodeServlet
 */
@WebServlet("/verifyPasscode")
public class verifyPasscodeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private RoomDAO roomDAO;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		roomDAO = new RoomDAO();
		
		String rid = request.getParameter("rid");
		String pcode = request.getParameter("passcode");
		
		if(roomDAO.checkPasscode(rid, pcode)) {
			response.sendRedirect("Playlist.jsp?rID=" + rid);
		} else {
			session.setAttribute("InvalidPasscode", "Passcode for the playlist was invalid.");
			response.sendRedirect("MusicTogether.jsp");
		}
		

	}

}
