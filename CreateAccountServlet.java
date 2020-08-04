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
 * Servlet implementation class CreateAccountServlet
 */
@WebServlet("/CreateAccount")
public class CreateAccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserDAO userDAO;
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		userDAO = new UserDAO();
		HttpSession session = request.getSession();
		String username = request.getParameter("newUsername");
		String password = request.getParameter("password1");
		if (!password.equals(request.getParameter("password2"))) {
			session.setAttribute("pwordNotMatch", "* passwords do not match");
			response.sendRedirect("MusicTogether.jsp");
		} else if (userDAO.checkUsername(username)) {
			session.setAttribute("usernameTaken",
					"* Username \"" + username + "\" has been taken. Please use a different username.");
			response.sendRedirect("MusicTogether.jsp");
		} else {
			User user = new User(username, password);
			userDAO.addUser(user);
			session.setAttribute("SignupSuccess", "* You have Successfully Signed Up!");
			response.sendRedirect("MusicTogether.jsp");
		}
	}

}
