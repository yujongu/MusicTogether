package com.yujongu.servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yujongu.DAO.VideoFetchAPI;
import com.yujongu.Models.Pair;
import com.yujongu.Models.Video;

/**
 * Servlet implementation class LoadMoreServlet
 */
@WebServlet("/LoadMore")
public class LoadMoreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		@SuppressWarnings("unchecked")
		ArrayList<Video> vidList = (ArrayList<Video>) session.getAttribute("videoList");
		String rid = request.getParameter("rID");
		String nextPageTag = (String) session.getAttribute("nextPage");
		String query = (String) session.getAttribute("query");
		
		VideoFetchAPI api = new VideoFetchAPI();
		try {
			Pair<String, ArrayList<Video>> pair = api.fetchMore(query, nextPageTag);
			vidList.addAll(pair.getSecond());
			nextPageTag = pair.getFirst();
			session.setAttribute("videoList", vidList);
			session.setAttribute("nextPage", nextPageTag);
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.sendRedirect("Playlist.jsp?rID=" + rid);
	}

}
