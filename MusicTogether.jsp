<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script>
	$(function() {
		$('[data-toggle="popover"]').popover()
	})
</script>
<title>Music Together</title>
</head>
<body>

	<div class="container-fluid">
		<div class="row">
			<div class="col-3">
				<h1>Music Together</h1>
				<form action="CreatePlaylist.jsp">
					<c:if test="${not empty username }">
						<input type="submit" class="btn btn-outline-warning"
							value="Create a playlist" />
					</c:if>

					<c:if test="${empty username }">
						<a tabindex="0" class="btn btn-outline-warning" role="button"
							data-toggle="popover" data-trigger="focus" title="Login required"
							data-content="Please login to create your own playlist.">Create
							a playlist</a>
					</c:if>

				</form>
			</div>

			<div class="col-9">

				<c:if test="${not empty InvalidPasscode }">
					<div class="alert alert-warning alert-dismissible fade show"
						role="alert">
						<strong>Invalid Passcode</strong> ${InvalidPasscode }
						<button type="button" class="close" data-dismiss="alert"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<c:remove var="InvalidPasscode" scope="session" />
				</c:if>

			</div>
		</div>

		<br>

		<div class="row">
			<div class="col-3">
				<c:if test="${empty username }">

					<h3>Log In</h3>${loginFailed }
					<c:remove var="loginFailed" scope="session" />

					<form action="Login" method="get">
						<div class="form-group">
							<label for="inputUsername" class="col-sm-2 col-form-label">Username</label>
							<div class="col-sm-10">
								<input type="text" name="username" class="form-control"
									id="inputUsername" maxlength="20" required>

							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword" class="col-sm-2 col-form-label">Password</label>
							<div class="col-sm-10">
								<input type="password" name="password" class="form-control"
									id="inputPassword" maxlength="20" required>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-sm-10">
								<button type="submit" class="btn btn-primary">Login</button>
							</div>
						</div>
					</form>
					<br>
					<h3>Sign Up</h3>
					${SignupSuccess }
					<c:remove var="SignupSuccess" scope="session" />

					<form action="CreateAccount" method="post">
						<div class="form-group">
							<label for="inputNewUsername" class="col-sm col-form-label">New
								username</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="newUsername"
									id="inputNewUsername" maxlength="20" required>
								${usernameTaken }
								<c:remove var="usernameTaken" scope="session" />

							</div>
						</div>
						<div class="form-group">
							<label for="inputNewPassword1" class="col-sm col-form-label">New
								password</label>
							<div class="col-sm-10">
								<input type="password" name="password1" class="form-control"
									id="inputNewPassword1" maxlength="20" required>

							</div>
						</div>
						<div class="form-group">
							<label for="inputNewPassword2" class="col-sm col-form-label">Retype
								your new password</label>
							<div class="col-sm-10">
								<input type="password" name="password2" class="form-control"
									id="inputNewPassword2" maxlength="20" required>
								${pwordNotMatch }
								<c:remove var="pwordNotMatch" scope="session" />

							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-10">
								<button type="submit" class="btn btn-primary">SignUp</button>
							</div>
						</div>
					</form>


				</c:if>


				<c:if test="${not empty username }">
					<div class="jumbotron">
						<h1 class="display-4">Welcome,</h1>
						<h4>${username }</h4>
						<p class="lead">Now you can create your own playlist!</p>
						<hr class="my-4">
						<form action="Logout" method="get">
							<input type="submit" class="btn btn-secondary" value="Log Out" />
						</form>
					</div>
				</c:if>
			</div>

			<div class="col-9">
				<sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver"
					url="jdbc:mysql://localhost:3306/MusicTDB?characterEncoding=UTF-8&serverTimezone=UTC"
					user="root" password="Password1" />
				<sql:query var="rs" dataSource="${db }">SELECT * FROM room</sql:query>

				<table class="table">
					<thead>
						<tr class="table-warning">
							<th scope="col">Room ID</th>
							<th scope="col">Name</th>
							<th scope="col">Owner</th>
							<th scope="col">Is Private</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${rs.rows}" var="row">
							<tr>

								<td><c:out value="${row.RoomID}"></c:out></td>
								<c:set var="rid" value="${row.RoomID }" scope="session" />

								<c:if test="${row.isPrivate}">
									<td><a class="active" data-toggle="modal"
										href="#passcodeModal"
										onclick="document.getElementById('passcodeInput').value = ''">
											<c:out value="${row.RoomName }"></c:out> <c:set var="rid"
												value="${row.RoomID }" />
									</a></td>
								</c:if>
								<c:if test="${!row.isPrivate}">
									<td><a href="/MusicTogether/LoggedIn?rID=${row.RoomID }"
										onclick="document.getElementById('passcodeInput').value = ''">
											<c:out value="${row.RoomName }"></c:out>
									</a></td>
								</c:if>

								<sql:query var="user" dataSource="${db }">SELECT uname FROM user where UserID=?
								<sql:param value="${row.RoomID }" />
								</sql:query>

								<c:forEach items="${user.rows}" var="user">
									<td><c:out value="${user.uname }"></c:out></td>
								</c:forEach>

								<td><c:if test="${row.isPrivate}">
										Private
									</c:if> <c:if test="${!row.isPrivate}">
										Public
									</c:if></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="modal fade" id="passcodeModal" tabindex="-1" role="dialog"
			aria-labelledby="passcodeModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">This playlist
							is private</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<form action="verifyPasscode" method="get">
						<div class="modal-body">

							<div class="form-group">
								<label for="passcodeInput" class="col-form-label">Enter
									Passcode:</label> <input class="form-control form-control-lg"
									id="passcodeInput" type="number" name="passcode" max="9999"
									placeholder="####"> <input type="hidden" name="rid"
									value="${rid}">
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
							<input type="submit" class="btn btn-primary" value="Verify">
						</div>
					</form>
				</div>
			</div>
		</div>

	</div>
</body>
</html>