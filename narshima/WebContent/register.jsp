
<!DOCTYPE html>
<html lang="en">


<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="msapplication-tap-highlight" content="no">
  <meta name="description" content="Materialize is a Material Design Admin Template,It's modern, responsive and based on Material Design by Google. ">
  <meta name="keywords" content="materialize, admin template, dashboard template, flat admin template, responsive admin template,">
  <title>Register Page | eGSD Admin Template</title>

  <!-- Favicons-->
  <link rel="icon" href="images/favicon/favicon-32x32.png" sizes="32x32">
  <!-- Favicons-->
  <link rel="apple-touch-icon-precomposed" href="images/favicon/apple-touch-icon-152x152.png">
  <!-- For iPhone -->
  <meta name="msapplication-TileColor" content="#00bcd4">
  <meta name="msapplication-TileImage" content="images/favicon/mstile-144x144.png">
  <!-- For Windows Phone -->


  <!-- CORE CSS-->
  
  <link href="css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection">
  <link href="css/style.css" type="text/css" rel="stylesheet" media="screen,projection">
  <link href="css/page-center.css" type="text/css" rel="stylesheet" media="screen,projection">

  <!-- INCLUDED PLUGIN CSS ON THIS PAGE -->
  <link href="css/prism.css" type="text/css" rel="stylesheet" media="screen,projection">
  <link href="css/perfect-scrollbar.css" type="text/css" rel="stylesheet" media="screen,projection">
  
</head>

<body class="cyan loaded">
  <!-- Start Page Loading -->
  <div id="loader-wrapper">
      <div id="loader"></div>        
      <div class="loader-section section-left"></div>
      <div class="loader-section section-right"></div>
  </div>
  <!-- End Page Loading -->



  <div id="login-page" class="row">
    <div class="col s12 z-depth-4 card-panel">
      <form class="login-form" >
        <div class="row">
          <div class="input-field col s12 center">
           		<img src="img/logo.png" alt="" style="width: 22%;height: 83px !important" class="circle responsive-img valign profile-image-login">
				<p class="center login-form-text" style="font-size: 25px; font-weight: 400;">eGSD Admin</p>
          </div>
        </div>
        <div class="row margin">
          <div class="input-field col s12">
<!--             <i class="mdi-social-person-outline prefix"></i> -->
            <input id="firstname" type="text" required>
            <label for="firstname" class="center-align">Firstname</label>
          </div>
        </div>
        
        <div class="row margin">
          <div class="input-field col s12">
<!--             <i class="mdi-social-person-outline prefix"></i> -->
            <input id="lastname" type="text">
            <label for="lastname" class="center-align">Lastname</label>
          </div>
        </div>
        
        <div class="row margin">
          <div class="input-field col s12">
<!--             <i class="mdi-social-person-outline prefix"></i> -->
            <input id="username" type="text" required>
            <label for="username" class="center-align">Username</label>
          </div>
        </div>
        
        <div class="row margin">
          <div class="input-field col s12">
<!--             <i class="mdi-communication-email prefix"></i> -->
            <input id="email" type="email" required>
            <label for="email" class="center-align">Email</label>
          </div>
        </div>
        
        <!-- <div class="row margin">
          <div class="input-field col s12">
            <i class="mdi-action-lock-outline prefix"></i>
            <input id="password" type="password">
            <label for="password">Password</label>
          </div>
        </div> -->
        
        <div class="row margin">
            <div class="input-field col s12 ">
<!--                 <label>Materialize Select</label> -->
                <select required>
                   <option value="" disabled selected>Choose your option</option>
                   <option value="1">Option 1</option>
                   <option value="2">Option 2</option>
                   <option value="3">Option 3</option>
                </select>
             </div>
                
        </div>
        
        <div class="row">
          <div class="input-field col s12">
            <button type="submit" class="btn waves-effect waves-light col s12">Register Now</button>
          </div>
          <div class="input-field col s12">
            <p class="margin center medium-small sign-up">Already have an account? <a href="login.html">Login</a></p>
          </div>
        </div>
      </form>
    </div>
  </div>



  <!-- ================================================
    Scripts
    ================================================ -->

  <!-- jQuery Library -->
  <script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
  <!--materialize js-->
  <script type="text/javascript" src="js/materialize.js"></script>
  <!--prism-->
  <script type="text/javascript" src="js/prism.js"></script>
  <!--scrollbar-->
  <script type="text/javascript" src="js/perfect-scrollbar.min.js"></script>

  <!--plugins.js - Some Specific JS codes for Plugin Settings-->
  <script type="text/javascript" src="js/plugins.js"></script>

</body>

</html>