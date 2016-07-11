
<!DOCTYPE html>
<html lang="en">

<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="../css/materialize.css">
<link rel="stylesheet" href="../css/materialize.min.css">
<link rel="stylesheet" href="../css/style.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<title>Forgot Password Page | eGSD Admin Template</title>


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
			<form class="login-form" action="forgotPassword" method="post" enctype="multipart/form-data">
				<div class="row">
					<div class="input-field col s12 center">
						<img src="../img/logo1.png" alt="" style="width: 22%;height: 83px !important"
							class="circle responsive-img valign profile-image-login">
						<p class="center login-form-text"
							style="font-size: 25px; font-weight: 400;">eGSD Admin</p>
					</div>
				</div>
				<c:out value="${mailId }"></c:out>
						<c:out value=" "></c:out>
						<br>

						<c:out value="   Is not a valid EmailId"></c:out>

						<p class="center">We don't find this email is associated with any user. Please re-enter correct email id</p>
				<div class="row margin">
					<div class="input-field col s12">
						<!--             <i class="mdi-social-person-outline prefix"></i> -->
						<input id="email" type="text" name="email" required style="padding: 0 10px 0 10px">
						<label for="email" class="center-align">Email</label>
					</div>
				</div>
				
				<div class="row">
					<div class="input-field col s12">
						<button class="btn waves-effect waves-light col s12">Reset Password</button>
					</div>
				</div>
				<div class="row">
					
					<div class="input-field">
						<p class="margin right-align medium-small center">
							<a href="/egsdAdminApp">Back to Login</a>
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