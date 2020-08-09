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
 * Servlet implementation class VideoSearchServlet
 */
@WebServlet("/VideoSearch")
public class VideoSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String rid = request.getParameter("rID");
		String query = request.getParameter("keyword");
		VideoFetchAPI api = new VideoFetchAPI();
		
		ArrayList<Video> vidList = new ArrayList<Video>();
		String nextPageTag = "";
		try {
			Pair<String, ArrayList<Video>> res = api.fetchResult(query);
			nextPageTag += res.getFirst();
			vidList = res.getSecond();
			session.setAttribute("query", query);
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
