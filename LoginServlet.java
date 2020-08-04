package com.yujongu.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yujongu.DAO.UserDAO;
import com.yujongu.Models.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/Login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO loginDAO;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		loginDAO = new UserDAO();

		User user = new User(request.getParameter("username"), request.getParameter("password"));

		if (loginDAO.checkCred(user)) {
			session.setAttribute("username", user.getUname());
		} else {
			session.setAttribute("loginFailed", "* Your username or password is incorrect.");
		}
		response.sendRedirect("MusicTogether.jsp");

	}

}
