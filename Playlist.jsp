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

<title>Playlist</title>
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
	String musicListString = room.getMusicList();
	ArrayList<String> musics = new ArrayList<String>(Arrays.asList(musicListString.split(",")));
	VideoFetchAPI videoAPI = new VideoFetchAPI();
	int musicCount = 0;
	ArrayList<Video> vidResult = new ArrayList<Video>();
	if (musics.get(0).length() > 0) {
		vidResult = videoAPI.getVideoInfo(musics);
		musicCount = musics.size();
	}
	%>
	<div class="container-fluid">
		<h1>
			<span class="align-middle"><%=playlistName%></span>
		</h1>

		<div class="row">
			<div class="col-4">

				<h4>
					Created by
					<%=owner%></p>
					<h4>
						Created on
						<%=createdDate%></p>
						<h4><%=musicCount%>
							videos
							</p>

							<br>
			</div>

			<%
				int rowCount = 0;
			if (musicCount > 0) {
				rowCount = (musicCount - 1) / 4;
			}
			%>

			<div class="col-5">
				<div class="row row-cols-4">
					<c:forEach items="<%=vidResult%>" var="video">
						<img class="col" src="${video.imgURL }" width="120" height="90" />
					</c:forEach>
				</div>
			</div>
			<div class="col-3">
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
			<input type="hidden" id="musicListString"
				value="<%=musicListString%>" />

			<div id="player"></div>
			<script>
				// 2. This code loads the IFrame Player API code asynchronously.
				var mlist = document.getElementById("musicListString").value;
				mlist = mlist.split(",");
				var mCount = 0;
				if(mlist[0].length > 0){
					mCount = mlist.length - 1;
				}
				
				var tag = document.createElement('script');

				tag.src = "https://www.youtube.com/iframe_api";
				var firstScriptTag = document.getElementsByTagName('script')[0];
				firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

				// 3. This function creates an <iframe> (and YouTube player)
				//    after the API code downloads.
				var player;
				var currInd = 0;
				function onYouTubeIframeAPIReady() {
					player = new YT.Player('player', {
						height : '270',
						width : '450',
						videoId : mlist[currInd],
						events : {
							'onReady' : onPlayerReady,
							'onStateChange' : onPlayerStateChange,
							'onError' : onPlayerError
						}
					});
				}

				// 4. The API will call this function when the video player is ready.
				function onPlayerReady(event) {
					if (currInd > 0) {
						event.target.playVideo();
					}
				}

				// 5. The API calls this function when the player's state changes.
				//    The function indicates that when playing a video (state=1),
				//    the player should play for six seconds and then stop.
				var done = false;
				function onPlayerStateChange(event) {
					if (event.data == YT.PlayerState.PLAYING && !done) {
						if(mCount == 0){
							alert("Please add some music");
						}
					}
					if (event.data == YT.PlayerState.ENDED) {
						currInd++;
						if(currInd >= mCount){
							alert("Returning to the beginning");
							currInd = 0;
						}
						player.loadVideoById(mlist[currInd], 0, "large");
					}
					
					
				}
				
				function onPlayerError(event){
					if(mCount < 1){
						alert("Please add some music into the playlist");
						return;
					}
				}
				function stopVideo() {
					player.stopVideo();
				}
			</script>
		</div>
	</div>


</body>
</html>