<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.yujongu.DAO.RoomDAO, com.yujongu.DAO.VideoFetchAPI, 
	com.yujongu.Models.Room, com.yujongu.Models.Video, 
	java.sql.Date, java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
	integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
	crossorigin="anonymous"></script>

<title>Insert title here</title>
<style>
#bottom {
	position: absolute;
	bottom: 0;
	left: 0;
}

div.list-group {
	height: 80vh;
	overflow: hidden;
	overflow-y: scroll;
}
</style>
</head>
<body>
	<%
		String rid = request.getParameter("rID");
	RoomDAO roomDAO = new RoomDAO();
	Room room = roomDAO.retrieveRoom(rid);
	String playlistName = room.getName();
	String owner = room.getOwner();
	Date createdDate = room.getCreatedDate();
	ArrayList<String> musics = new ArrayList<String>(Arrays.asList(room.getMusicList().split(",")));
	VideoFetchAPI videoAPI = new VideoFetchAPI();
	ArrayList<Video> vidResult = videoAPI.getVideoInfo(musics);
	%>
	<div class=container-fluid>
		<h1>
			<span class="align-middle"><%=playlistName%></span>
		</h1>

		<div class=row>
			<div class=col-4>

				<h4>
					Created by
					<%=owner%></p>
					<h4>
						Created on
						<%=createdDate%></p>
						<h4>${fn:length(music)}
							videos
							</p>

							<br>
			</div>
			<div class=col-5>

				<div class="list-group list-group-horizontal-lg">
					<c:forEach items="<%=vidResult%>" var="video">
						<img class="list-group-item" src="${video.imgURL }" width="120" height="90" />
					</c:forEach>
				</div>



			</div>
			<div class=col-3>
				<form class="form-inline" action="VideoSearch" method="get">
					<div class="form-group mx-sm-3 mb-2">
						<c:if test="${not empty query }">
							<input type="text" class="form-control" id="inputKeyword"
								placeholder="Keyword" name="keyword" value="${query }">
						</c:if>
						<c:if test="${empty query }">
							<input type="text" class="form-control" id="inputKeyword"
								placeholder="Keyword" name="keyword">
						</c:if>
						<input type="hidden" name="rID" value=<%=rid%> />
					</div>
					<button type="submit" class="btn btn-primary mb-2">Search</button>
				</form>

				<div class="list-group">
					<!-- <form action="addMusic" method="post"> -->
					<c:forEach items="${videoList }" var="video">
						<button type="submit"
							class="list-group-item list-group-item-action" id="${video.vID }"
							onClick="listItemClick(this.id)">
							<img src="${video.imgURL }" width="280" height="157.5" />
							<p class="mb-1">${video.title }</p>
						</button>
						<input type="hidden" name="rID" value=<%=rid%> />
					</c:forEach>
					<!-- </form> -->

					<script type="text/javascript">
						function listItemClick(clicked_id) {
							window.location.replace("PlaylistPass.jsp?vID="
									+ clicked_id + "&rID=" +
					<%=rid%>
						);
						}
					</script>

					<c:set value="${videoList }" var="videoList" scope="session" />
					<form action="LoadMore" method="get">
						<input
							class="list-group-item list-group-item-action list-group-item-warning"
							type="submit" value="Load more..." /> <input type="hidden"
							name="rID" value=<%=rid%> />
					</form>

				</div>

			</div>
		</div>

		<div id="bottom">
			<iframe width="450" height="270"
				src="https://www.youtube.com/embed/jSxGUmPaIR8" frameborder="0"
				allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
				allowfullscreen></iframe>
		</div>
	</div>


</body>
</html>