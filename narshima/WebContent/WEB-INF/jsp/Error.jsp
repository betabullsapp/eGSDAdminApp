<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="../css/materialize.css">
<link rel="stylesheet" href="../css/materialize.min.css">
<link rel="stylesheet" href="../css/style.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<title>Login Page | eGSD Admin Template</title>


<!-- CORE CSS-->

<link href="../css/materialize.css" type="text/css" rel="stylesheet"
	media="screen,projection">
<link href="../css/style.css" type="text/css" rel="stylesheet"
	media="screen,projection">
<link href="../css/page-center.css" type="text/css" rel="stylesheet"
	media="screen,projection">

<!-- INCLUDED PLUGIN CSS ON THIS PAGE -->
<link href="../css/prism.css" type="text/css" rel="stylesheet"
	media="screen,projection">
<link href="../css/perfect-scrollbar.css" type="text/css"
	rel="stylesheet" media="screen,projection">

</head>

<body class="cyan loaded">

	<div id="login-page" class="row">
		<div class="col s12 z-depth-4 card-panel">
			<form class="login-form" action="login" method="post">
				<div class="row">
					<div class="input-field col s12 center">
						<img src="../img/logo1.png" alt=""
							style="width: 22%; height: 83px !important"
							class="circle responsive-img valign profile-image-login">
						<p class="center login-form-text"
							style="font-size: 25px; font-weight: 400;">eGSD Admin</p>
					</div>
				</div>
				<font color="red" style="margin: 0 0 0 110px"> <c:out
						value="${errorMsg }" />
				</font>
				
				<div class="row margin">
					<div class="input-field col s12">
						<!--             <i class="mdi-social-person-outline prefix"></i> -->
						<input id="username" type="text" name="username" required
							style="padding: 0 10px 0 10px"> <label for="username"
							class="center-align active">User Name</label>
					</div>
				</div>
				<div class="row margin">
					<div class="input-field col s12">
						<!--             <i class="mdi-action-lock-outline prefix"></i> -->
						<input id="password" type="password" name="password" required
							style="padding: 0 10px 0 10px"> <label for="password"
							class="active">Password</label>
					</div>
				</div>
				<!-- <div class="row">
					<div class="input-field col s12 m12 l12  login-text">
						<input type="checkbox" id="remember-me" /> <label
							for="remember-me">Remember me</label>
					</div>
				</div> -->
				<div class="row">
					<div class="input-field col s12">
						<button class="btn waves-effect waves-light col s12">Login</button>
					</div>
				</div>
				<div class="row">

					<div class="input-field">
						<p class="margin right-align medium-small center">
							<a href="../forgot.jsp">Forgot password?</a>
						</p>
					</div>
				</div>

			</form>
		</div>
	</div>

	<!-- ================================================
    Scripts
    ================================================ -->

	<!-- jQuery Library -->
	<script type="text/javascript" src="../js/jquery-1.11.2.min.js"></script>
	<!--materialize js-->
	<script type="text/javascript" src="../js/materialize.js"></script>
	<!--prism-->
	<script type="text/javascript" src="../js/prism.js"></script>
	<!--scrollbar-->
	<script type="text/javascript" src="../js/perfect-scrollbar.min.js"></script>

	<!--plugins.js - Some Specific JS codes for Plugin Settings-->
	<script type="text/javascript" src="../js/plugins.js"></script>

</body>

</html>