<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="../css/materialize.css">
<link rel="stylesheet" href="../css/materialize.min.css">

<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<title>${userName } Page | eGSD Admin Template</title>


<!-- CORE CSS-->

<link rel="stylesheet" href="../dist/themes/proton/style.min.css" />

<script src="../dist/libs/jquery.js"></script>
<script src="../dist/jstree.min.js"></script>

<script src="../assets/jquery-1.10.2.min.js"></script>

<script src="../assets/dist/jstree.min.js"></script>

<link href="../css/prism.css" type="text/css" rel="stylesheet"
	media="screen,projection">
<link href="../css/perfect-scrollbar.css" type="text/css"
	rel="stylesheet" media="screen,projection">

<script type="text/javascript" src="../js/jscolor.js"></script>
<!-- $(function () {
  $("#plugins4").jstree({
    "plugins" : [ "search" ]
  });
  var to = false;
  $('#plugins4_q').keyup(function () {
    if(to) { clearTimeout(to); }
    to = setTimeout(function () {
      var v = $('#plugins4_q').val();
      $('#plugins4').jstree(true).search(v);
    }, 250);
  });
}); -->
<script>
	$(function() {
		$('#jstree-proton-1').jstree({
			
			"plugins" : [ "search" ],
			'core' : {
				'themes' : {
					'name' : 'proton',
					'responsive' : true
				}
			},

		});
		var to = false;
		  $('#plugins4_q').keyup(function () {
		    if(to) { clearTimeout(to); }
		    to = setTimeout(function () {
		      var v = $('#plugins4_q').val();
		      $('#jstree-proton-1').jstree(true).search(v);
		    }, 250);
		  });
	});
</script>

</head>
</head>

<a class="waves-effect waves-light btn modal-trigger onload" style="display:none" href="#onloadPopup">Modal</a>
  	  
  <!-- Modal Structure -->
  <div id="onloadPopup" class="modal" style="width:80%">
  	<center ><h5>Select Hotel</h5></center>
  
  	<nav style="width:50%;height:40px;margin:14px 0 0 23px;background-color:#00bcd4;line-height:45px !important">
	    <div class="nav-wrapper">
	      
	        <div class="input-field">
	          <input class="search" type="search" style="font-size:16px;padding:11px 9px 0 50px;color:#fff;background-color:#00bcd4">
	          <label for="search"><i class="material-icons" style="line-height:45px;color:#fff">search</i></label>
	          
	        </div>
	      
	    </div>
	  </nav>
	  <div class="preloader-wrapper small active mbody" style="display:none;margin:2% 0 0 50%">
		    <div class="spinner-layer spinner-green-only">
		      <div class="circle-clipper left">
		        <div class="circle"></div>
		      </div><div class="gap-patch">
		        <div class="circle"></div>
		      </div><div class="circle-clipper right">
		        <div class="circle"></div>
		      </div>
		    </div>
		  </div>
    <a href="#!" style="margin:-40px 3% 3% 3%;height:42px;line-height:39px"  class="skipSelection modal-action modal-close waves-effect waves-green btn right">Close</a>
	    <div class="modal-content" style="margin-top:6%">
	    <span class="noResults" style="margin-left:29%"></span>	
	      
	      		
				<table class="table bordered striped searchResults">
					<tbody class="tbody">
						<tr>
						<td style="padding:10px 0;"><b style="color:#337ab7;font-size:18px">Hotel Name</b></td>
						<td style="padding:10px 0"><b style="color:#337ab7;font-size:18px">Hotel Id</b></td>
						<td style="padding:10px 0"><b style="color:#337ab7;font-size:18px">Group Site ID</b></td>
						<td style="padding:10px 0"><b style="color:#337ab7;font-size:18px">Zip/Postal Code</b></td>
						<td style="padding:10px 0"><b style="color:#337ab7;font-size:18px">Group Name</b></td>
						</tr>	
						<c:forEach var="selectLocObj" items="${selectLocObj}">
							<tr>
								<td style="padding:10px 0;"> <a onclick='loading()' style="color:#337ab7" href="select?user=${user}&userName=${userName}&locId=${selectLocObj.directory}">
								${selectLocObj.name}
								</a>
								</td>
								<td style="padding:10px 0"> <a onclick='loading()'  href="select?user=${user}&userName=${userName}&locId=${selectLocObj.directory}" style="color:#337ab7">
								${selectLocObj.directory}
								</a>
								</td>
								<td style="padding:10px 0"> <a onclick='loading()' href="select?user=${user}&userName=${userName}&locId=${selectLocObj.directory}" style="color:#337ab7">
								${selectLocObj.siteId}
								</a>
								</td>
								<td style="padding:10px 0"> <a onclick='loading()' href="select?user=${user}&userName=${userName}&locId=${selectLocObj.directory}" style="color:#337ab7">
								${selectLocObj.zipcode}
								</a>
								</td>
								<td style="padding:10px 0"> <a onclick='loading()' href="select?user=${user}&userName=${userName}&locId=${selectLocObj.directory}" style="color:#337ab7">
								${selectLocObj.groupName}
								</a>
								</td>
							</tr> 
						</c:forEach>
					</tbody>
				</table>
	    </div>
    
  </div>

<body class="loaded" onload="bodyLoad()"
	style="font-family: 'Open Sans', sans-serif;">
	<a href="#updateAdmin" class="modal-trigger" id="updateAdminhref"
	    style="font-size: 1rem; display:none;padding: 0.5rem 0.5rem;">Edit Profile</a>
	    
	<a href="#changePassword" class="modal-trigger" id="changePasswordhref"
	    style="font-size: 1rem; display:none;padding: 0.5rem 0.5rem;">Change Password</a>
	    
	<a href="#superAdmin" class="modal-trigger" id="asAdminhref"
	    style="font-size: 1rem; display:none;padding: 0.5rem 0.5rem;">Add Super Admin</a>
	    
	 <a href="#csAdmin" class="modal-trigger" id="csAdminhref"
    	style="font-size: 1rem;display:none; padding: 0.5rem 0.5rem;">Add CS Admin</a>
    	
     <a href=".locationAdmin" class="modal-trigger " id="locationAdmin"
    	style="font-size: 1rem;display:none; padding: 0.5rem 0.5rem;">Add Location Admin</a>
    	
     <a href="#groupHotel" class="modal-trigger" id="grouphref"
		style="font-size: 1rem;display:none; padding: 0.5rem 0.5rem;">Add Group</a>
		
	 <a href="#addHotel" class="modal-trigger" id="hotelhref"
		style="font-size: 1rem;display:none; padding: 0.5rem 0.5rem;">Add Hotel</a>
		
	 <a href="#createTemplate" class="modal-trigger" id="templatehref"
		style="font-size: 1rem;display:none; padding: 0.5rem 0.5rem;">Create New Template</a>
	    
	<div class="navbar-fixed cyan">
		<ul id="dropdown1" class="dropdown-content">
		<li><a  id="updateAdminDetails"style="font-size: 1rem; padding: 0.5rem 0.5rem;">Manage My User Profile</a></li>
		<li><a  id="changePasswordDetails"style="font-size: 1rem; padding: 0.5rem 0.5rem;">Change My Password</a></li>
		<li><a href="#modal4" class="modal-trigger searchUsers"
				style="font-size: 1rem; padding: 0.5rem 0.5rem;">Manage Users</a></li>
				<!-- <li><a id="aiAdmin" style="font-size: 1rem; padding: 0.5rem 0.5rem;">Create IT Admin User</a></li>
			<li><a id="asAdmin" style="font-size: 1rem; padding: 0.5rem 0.5rem;">Create Super Admin User</a></li>    		
			<li><a  id="acAdmin" style="font-size: 1rem; padding: 0.5rem 0.5rem;">Create CS Admin User</a></li> -->
   			<li><a id="alAdmin"	style="font-size: 1rem; padding: 0.5rem 0.5rem;">Create Hotel Admin User</a></li>
   			
				<!-- <li> <a id="agroup"	style="font-size: 1rem; padding: 0.5rem 0.5rem;">Create Hotel Group/Brand</a></li>
   			<li><a href="#modal3" class="modal-trigger skipGroup"
				style="font-size: 1rem; padding: 0.5rem 0.5rem;">Manage Hotel Groups/Brands</a></li>
    		<li><a id="ctemplate" style="font-size: 1rem; padding: 0.5rem 0.5rem;">Create Directory Template</a></li>
    		<li><a href="#modal2" class="modal-trigger skipTemplate"
				style="font-size: 1rem; padding: 0.5rem 0.5rem;">Manage Directory Templates</a></li> -->
			<li><a id="ahotel"	style="font-size: 1rem; padding: 0.5rem 0.5rem;">Create Hotel Directory</a></li>
			<li><a style="font-size: 1rem; padding: 0.5rem 0.5rem;" class="modal-trigger skipSelection" 
				href="#modal1">Manage Hotel Directory(s)</a></li>
			
			
			
			
			
			
			<li class="divider"></li>
			<li><a href="/egsdAdminApp/"
				style="font-size: 1rem; padding: 0.5rem 0.5rem;">Logout</a></li>
		</ul>
		<nav class="cyan" style="padding:0 5% 0 4%">
		<div class="nav-wrapper">
			<!-- <a href="/egsdAdminApp/" class="brand-logo"><img
				src="../img/logo.png" style="width: 100%; padding-top: 7px;"></a> -->
				<span class="brand-logo"><img
				src="../img/logo.png" style="width: 100%; padding-top: 7px;"></span>
			<ul class="right hide-on-med-and-down">

				<li><a class="dropdown-button" href="#!"
					data-activates="dropdown1" style="width: 260px">${user} (${userName })<i
						class="material-icons right">arrow_drop_down</i></a></li>
			</ul>
		</div>
		</nav>
	</div>
	<br />
	
	
<!--  update Super admin popup -->

  
  <div id="updateAdmin" class="modal" style="overflow:auto">
  
  	
  
    <a href="#!" class=" modal-action modal-close right waves-effect waves-green btn-flat">Close</a>
       <div class="modal-content ubody">
       <center><h5 > </h5></center>
          <center><span class="userExisted" style="color:red;font-size:13px;"></span></center>
          <input type="hidden" id="updateHideEmail"/>
          <div class="row margin">
      <div class="input-field col s12">
       <input  type="text" name="editFirstName" class="customFont" id="updateFname"  style="padding: 0 10px 0 10px">
       <span id="updateFnameErr" style="color:red;font-size:12px"></span>
       <label  class="center-align active customFont">First Name</label>
      </div>
     </div>
        <div class="row margin">
      <div class="input-field col s12">
       <input  type="text" name="editLastName" id="UpdateLname" class="customFont" style="padding: 0 10px 0 10px">
       <span id="updateLnameErr" style="color:red;font-size:12px"></span>
       <label  class="center-align active customFont">Last Name</label>
      </div>
     </div>
      <div class="row margin">
      <div class="input-field col s12">
       <!--             <i class="mdi-social-person-outline prefix"></i> -->
       <input  type="text" name="editUserName" required id="updateUname" class="customFont" style="padding: 0 10px 0 10px" disabled>
       <span id="updateUnameErr" style="color:red;font-size:12px"></span>
       <label  class="center-align active customFont">User Name</label>
      </div>
     </div>
     <div class="row margin">
      <div class="input-field col s12">
       <input  type="email" name="editEmail" class="customFont" id="updateEmail" required style="padding: 0 10px 0 10px">
       <span id="updateEmailErr" style="color:red;font-size:12px"></span>
       <label  class="center-align active customFont">Email</label>
      </div>
     </div>
     <div class="row margin">
      <div class="input-field col s12">
       <input  type="text" name="editPhone" class="customFont" id="updatePhone" onkeypress="return isNumber(event)" required style="padding: 0 10px 0 10px">
       <span id="updatePhoneErr" style="color:red;font-size:12px"></span>
       <label  class="center-align active customFont">Phone Number</label>
      </div>
     </div>
     
    
     
           
           <div class="row">
             <div class="input-field col s12">
               
               <button type="submit" id="updateAdminUser" class="btn waves-effect waves-light col s12">Update Admin User</button>
             </div>
             
           </div>
          
       </div>
     
  </div>
 
 
<!--  end of the update Super admin popup -->
	
	
	<!-- start change hotel popup -->
	
	<div id="modal1" class="modal" style="width:90%">
	
		<a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat right">Close</a>
			<center ><h5>Select Hotel</h5></center>
			
		  <nav style="width:50%;height:40px;margin:14px 0 0 23px;line-height:45px !important;background-color:#00bcd4">
		    <div class="nav-wrapper">
		      
		        <div class="input-field">
		          <input class="search" type="search" style="font-size:16px;padding:11px 9px 0 50px;color:#fff;background-color:#00bcd4">
		          <label for="search"><i class="material-icons" style="line-height:45px;color:#fff">search</i></label>
		          
		        </div>
		      
		    </div>
		  </nav>
		  
		  <div class="preloader-wrapper small active mbody" style="display:none;margin:2% 0 0 50%">
		    <div class="spinner-layer spinner-green-only">
		      <div class="circle-clipper left">
		        <div class="circle"></div>
		      </div><div class="gap-patch">
		        <div class="circle"></div>
		      </div><div class="circle-clipper right">
		        <div class="circle"></div>
		      </div>
		    </div>
		  </div>
	  
			
		
	    <div class="modal-content">   		
	    
	      		
	      		<center><span class="noResults"></span></center>	
				<table class="table bordered striped searchResults" >
					<tbody class="tbody">
						<%-- <tr>
						<td style="padding: 6px 0px 0px 30px;"><b style="color:#337ab7;font-size:18px">Hotel Name</b></td>
						<td style="padding:10px 0"><b style="color:#337ab7;font-size:18px">Hotel Id</b></td>
						<td style="padding:10px 0"><b style="color:#337ab7;font-size:18px">Group Site ID</b></td>
						</tr>	
						<c:forEach var="selectLocObj" items="${selectLocObj}">
							<tr>
								<td style="padding: 6px 0px 0px 30px;"> <a style="color:#337ab7" href="select?user=${user}&userName=${userName}&locId=${selectLocObj.directory}">
								${selectLocObj.name}
								</a>
								</td>
								<td style="padding:10px 0"> <a  href="select?user=${user}&userName=${userName}&locId=${selectLocObj.directory}" style="color:#337ab7">
								${selectLocObj.directory}
								</a>
								</td>
								<td style="padding:10px 0"> <a  href="select?user=${user}&userName=${userName}&locId=${selectLocObj.directory}" style="color:#337ab7">
								${selectLocObj.siteId}
								</a>
								</td>
								
							</tr> 
						</c:forEach> --%>
					</tbody>
				</table>
	    </div>
	    
	 </div>
	
	<!-- end of the change hotel popup -->
	
	
	<!-- start change template popup -->
 
	 <div id="modal2" class="modal">
	 
	  <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat right">Close</a>
	     <div class="modal-content">
	       <center class="tspin"><h5>Select Template</h5></center>
	       
	      <nav style="width:50%;height:40px;line-height:45px !important;background-color:#00bcd4">
			    <div class="nav-wrapper">
			      
			        <div class="input-field">
			          <input id="templateSearch" type="search" required style="font-size:16px;padding:11px 9px 0 50px;color:#fff;background-color:#00bcd4">
			          <label for="search"><i class="material-icons" style="line-height:45px;color:#fff">search</i></label>
			          
			        </div>
			      
			    </div>
		   </nav>
	  	 <br/>
		  
	  	
	  	  <div class="preloader-wrapper small active templateSpin" style="display:none;margin:2% 0 0 50%">
		    <div class="spinner-layer spinner-green-only">
		      <div class="circle-clipper left">
		        <div class="circle"></div>
		      </div><div class="gap-patch">
		        <div class="circle"></div>
		      </div><div class="circle-clipper right">
		        <div class="circle"></div>
		      </div>
		    </div>
		  </div>
		  <span id="noTemplateResults" style="margin-left:40%"></span>
	       
	    <table class="table bordered striped" id="templateSearchResults">
	    	<tbody id="templateBody">
		    	<%-- <tr>
					<td style="padding: 6px 0px 0px 30px;"><b style="color:#337ab7;font-size:18px">Template Name</b></td>
					<td style="padding:10px 0"><b style="color:#337ab7;font-size:18px">Template Id</b></td>
				</tr>
			      <c:forEach var="listOfEgsdTemplateObjects" items="${listOfEgsdTemplateObjects}">
			      <tr>
			       <td style="padding: 6px 0px 0px 30px;"> <a style="color:#337ab7" href="viewTemplates?user=${user}&userName=${userName}&tempId=${listOfEgsdTemplateObjects.objectId}">
			       ${listOfEgsdTemplateObjects.name}
			       </a>
			       </td>
			       <td style="padding:10px 0"> <a  href="viewTemplates?user=${user}&userName=${userName}&tempId=${listOfEgsdTemplateObjects.objectId}" style="color:#337ab7">
			       ${listOfEgsdTemplateObjects.objectId}
			       </a>
			       </td>
			       
			      </tr> 
			     </c:forEach> --%>
			 </tbody> 
	    </table>
	     </div>
	     
	 </div>
	 
	 <!-- end of the change template popup -->
	 
	 
	 
	 <!-- start change group popup -->
 
	 <div id="modal3" class="modal">
	 
	  <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat right">Close</a>
	     <div class="modal-content">
	       <center class="tspin"><h5>Select Group</h5></center>
	       
	      <nav style="width:50%;height:40px;line-height:45px !important;background-color:#00bcd4">
			    <div class="nav-wrapper">
			      
			        <div class="input-field">
			          <input id="groupSearch" type="search" required style="font-size:16px;padding:11px 9px 0 50px;color:#fff;background-color:#00bcd4">
			          <label for="search"><i class="material-icons" style="line-height:45px;color:#fff">search</i></label>
			          
			        </div>
			      
			    </div>
		   </nav>
	  	 <br/>
		  
	  	
	  	  <div class="preloader-wrapper small active groupSpin" style="display:none;margin:2% 0 0 50%">
		    <div class="spinner-layer spinner-green-only">
		      <div class="circle-clipper left">
		        <div class="circle"></div>
		      </div><div class="gap-patch">
		        <div class="circle"></div>
		      </div><div class="circle-clipper right">
		        <div class="circle"></div>
		      </div>
		    </div>
		  </div>
		  <span id="noGroupResults" style="margin-left:40%"></span>
	       
	    <table class="table bordered striped" id="groupSearchResults">
	    	<tbody id="groupBody">
		    	<%-- <tr>
					<td style="padding: 6px 0px 0px 30px;"><b style="color:#337ab7;font-size:18px">Group Name</b></td>
					<td style="padding:10px 0"><b style="color:#337ab7;font-size:18px">Group Id</b></td>
				</tr>
			      <c:forEach var="listOfEgsdTemplateObjects" items="${listOfEgsdGroupObjects}">
			      <tr>
			       <td style="padding: 6px 0px 0px 30px;"> <a style="color:#337ab7" href="viewGroups?user=${user}&userName=${userName}&tempId=${listOfEgsdTemplateObjects.objectId}">
			       ${listOfEgsdTemplateObjects.name}
			       </a>
			       </td>
			       <td style="padding:10px 0"> <a  href="viewGroups?user=${user}&userName=${userName}&tempId=${listOfEgsdTemplateObjects.objectId}" style="color:#337ab7">
			       ${listOfEgsdTemplateObjects.objectId}
			       </a>
			       </td>
			       
			      </tr> 
			     </c:forEach> --%>
			 </tbody> 
	    </table>
	     </div>
	     
	 </div>
	 
	 <!-- end of the change group popup -->
	 
	 
	 
	 <!-- start managing users popup -->
	
	<div id="modal4" class="modal" style="width:80%">
	<a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat right">Close</a>
		<center style="margin-left:15%"><h5>Managing Users</h5></center>
	
	  <nav style="width:50%;height:40px;margin:14px 0 0 23px;line-height:45px !important;background-color:#00bcd4">
	    <div class="nav-wrapper">
	      
	        <div class="input-field">
	          <input id="userSearch" type="search" required style="font-size:16px;padding:11px 9px 0 50px;color:#fff;background-color:#00bcd4">
	          <label for="search"><i class="material-icons" style="line-height:45px;color:#fff">search</i></label>
	          
	        </div>
	      
	    </div>
	  </nav>
	  	
	  	
	  	  <div class="preloader-wrapper small active userSpin" style="display:none;margin:2% 0 0 50%">
		    <div class="spinner-layer spinner-green-only">
		      <div class="circle-clipper left">
		        <div class="circle"></div>
		      </div><div class="gap-patch">
		        <div class="circle"></div>
		      </div><div class="circle-clipper right">
		        <div class="circle"></div>
		      </div>
		    </div>
		  </div>
	  	
	  	
			
		
	    <div class="modal-content">   		
	    		<span id="noUserResults" style="margin-left:44%"></span>
	      		
	      		<center></center>	
				<table class="table bordered striped" id="userSearchResults">
					<tbody id="userbody">
						<%-- <tr>
						<!-- <td style="padding: 6px 0px 0px 30px;"><b style="color:#337ab7;font-size:18px">User Name</b></td> -->
						<td style="padding:10px 0 0 0px;text-align:center"><b style="color:#337ab7;font-size:18px">First Name</b></td>
						<td style="padding:10px 0;text-align:center"><b style="color:#337ab7;font-size:18px">Last Name</b></td>
						<td style="padding: 6px 0px 0px 0px;text-align:center"><b style="color:#337ab7;font-size:18px">Email</b></td>
						<td style="padding:10px 0;text-align:center"><b style="color:#337ab7;font-size:18px">Role</b></td>
						<td style="padding:10px 0;text-align:center"><b style="color:#337ab7;font-size:18px">Actions</b></td>
						</tr>	
						<c:forEach var="listOfAdmins" items="${listOfAdmins}">
							<tr>
								<td style="padding: 6px 0px 0px 30px;"> <a style="color:#337ab7" href="dfgdfg">
								${listOfAdmins.username}
								</a>
								</td>
								<td style="padding:10px 0 0 0px;text-align:center"> <span style="color:#337ab7">
								${listOfAdmins.firstname}
								</span>
								</td>
								<td style="padding:10px 0;text-align:center"> <span style="color:#337ab7">
								${listOfAdmins.lastname}
								</span>
								</td>
								<td style="padding: 6px 0px 0px 0px;text-align:center"> <span style="color:#337ab7" >
								${listOfAdmins.email}
								</span>
								</td>
								<td style="padding:10px 0;text-align:center"> <span style="color:#337ab7">
								${listOfAdmins.user}
								</span>
								</td>
								<td style="padding:10px 0;text-align:center"> <a  href="#" style="color:#337ab7">
								<span id="edit:${listOfAdmins.email}" onclick="editUser(this.id)">Edit </span > &nbsp <span id="delete:${listOfAdmins.objectId}" onclick="deleteUser(this.id)"> Delete </span>
								</a>
								</td>								
							</tr> 
						</c:forEach>  --%>
					</tbody>
				</table>
	    </div>
	    
	 </div>
	
	<!-- end of the managing users popup -->
	
	
	
	<!-- start delete user popup -->
	 
	 <a href="#modal5" class="modal-trigger" id="deleteAdmin"
    	style="font-size: 1rem;display:none; padding: 0.5rem 0.5rem;">Add CS Admin</a>
 
	 <div id="modal5" class="modal">
	  <!-- <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat right">Close</a> -->
	     <div class="modal-content deleteConfirmBody">
	     	 <center><h5>Delete Admin </h5></center>
	     	 <input type="hidden" id="deleteUserId"/>
	     	 <br/>
	         Are you sure to delete this user?
	         <br/>
	         <br/>
	         <button type="submit" id="deleteAdminDetails" class="btn">YES</button>
	         <a href="#!" class="btn modal-action modal-close waves-effect waves-green">NO</a>
		 </div>
	     
	 </div>
	 
	 <!-- end of the delete user popup -->
	 
	 
	 <a href="#deleteforAdmin" class="modal-trigger" id="deleteNotConfirmationAdmin" style="font-size: 1rem;display:none; padding: 0.5rem 0.5rem;">Add CS Admin</a>
 
	 <div id="deleteforAdmin" class="modal">
	  <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat right">Close</a>
	     <div class="modal-content">
	     	 
	        This user is assigned to one or more hotels. Cannot be deleted. Please contact support team.
	         <br/>
	         <br/>
	         
		 </div>
	     
	 </div>
	 
	
	
	<!-- start add hotel popup -->
	
	<div id="addHotel" class="modal">
	  <form:form action="addLocation" commandName="addLocation" name="addLocation"
							enctype="multipart/form-data">
	   <a href="#!" class=" modal-action modal-close right waves-effect waves-green btn-flat">Cancel</a>
	      <div class="modal-content">
	      	<div class="preloader-wrapper small active hspin" style="display:none;margin:2% 0 0 50%">
			    <div class="spinner-layer spinner-green-only">
			      <div class="circle-clipper left">
			        <div class="circle"></div>
			      </div><div class="gap-patch">
			        <div class="circle"></div>
			      </div><div class="circle-clipper right">
			        <div class="circle"></div>
			      </div>
			    </div>
			  </div>
	         <center><h5 > Create Hotel Directory</h5></center>
	        		<div style="margin: 1% 3% 0px 3%">
						

							<!--hidden fields  -->
							<input type="hidden" value="${userName}" name="userName">
							<input type="hidden" value="${user}" name="user">


							<div class="">
								<div class="input-field ">
									<input type="text" name="Name" required id="hotelName"
										style="font-size: 16px;padding-left:10px;margin-bottom:3px " > <label
										for="first_name2" style="font-size: 14px; font-weight: normal">Hotel Name
										</label>
										<span id="hotelNameErr" style="font-size:13px;color:red"></span>
										<span id="hotelExistErr" style="font-size:13px;color:red"></span>
								</div>
							</div>
							
							<div class="">
								<div class="input-field ">
									<input type="text" name="siteId" 
										style="font-size: 16px;padding-left:10px;margin-bottom:3px " id="groupId"> <label
										for="first_name2" style="font-size: 14px; font-weight: normal">Group Site ID
										</label>
								</div>
							</div>
							
							<div class="row">
								<div class="input-field col s6">
									<select  name="adminId" id="adminId" class="locAdmin browser-default">
								      <option value="" disabled selected>Choose Hotel Admin</option>
										<c:forEach var="listOfEmptyLocationAdmins"
											items="${listOfEmptyLocationAdmins }">
											<option value="${listOfEmptyLocationAdmins.objectId }">${listOfEmptyLocationAdmins.username} - ${listOfEmptyLocationAdmins.firstname} ${listOfEmptyLocationAdmins.lastname}  </option>
										</c:forEach>
										<option id="l2"></option>
								    </select>
								    <span id="hotelLocationAdminErr" style="font-size:13px;color:red"></span>
									<%-- <select  name="adminId" class="locAdmin">
										<option value="" disabled selected>Choose Location Admin</option>
										<c:forEach var="listOfEmptyLocationAdmins"
											items="${listOfEmptyLocationAdmins }">
											<option value="${listOfEmptyLocationAdmins.objectId }">${listOfEmptyLocationAdmins.username }</option>
										</c:forEach>
									</select> --%>
								</div>

							</div>
							
							<div class="row">
							
								<div class="input-field">
									<input type="checkbox" id="checkBox" onclick = "Check()" />
      								<label for="checkBox">Group Hotel</label>
								</div>
								
								<div class="input-field col s6" id="showGroups" style="display:none">
									<select name="groupId" id="groupObjectId" class="browser-default">
								      <option value="" selected disabled>Choose Group</option>
								       <c:forEach var="listOfEgsdGroupObjects"
								        items="${listOfEgsdGroupObjects }">
								        <option value="${listOfEgsdGroupObjects.objectId }">${listOfEgsdGroupObjects.name }</option>
								       </c:forEach>
								       
								    </select>
								     <span id="hotelGroupErr" style="font-size:13px;color:red"></span>
								</div>
								
							
								<div class="input-field col s6" >
									<select class="browser-default" id="showTemplates" name="groupId">
								        <option value="" selected disabled>Choose Template</option>
										<c:forEach var="listOfEgsdTemplateObjects"
											items="${listOfEgsdTemplateObjects }">
											<option value="${listOfEgsdTemplateObjects.objectId }">${listOfEgsdTemplateObjects.name }</option>
										</c:forEach>
										
								    </select>
								    <span id="hotelTemplateErr" style="font-size:13px;color:red"></span>
									<%-- <select  name="templateId">
										<option value="" disabled selected>Choose Template</option>
										<c:forEach var="listOfEgsdTemplateObjects"
											items="${listOfEgsdTemplateObjects }">
											<option value="${listOfEgsdTemplateObjects.objectId }">${listOfEgsdTemplateObjects.name }</option>
										</c:forEach>
									</select> --%>
								</div>
								<div class="input-field col s6" style="margin-top:4%">
									<span id="l1"></span>
								</div>

							</div>
							
							<div class="">
								<div class="input-field ">
									<input type="text" name="Address1" id="Address1"
										style="font-size: 16px;padding-left:10px;margin-bottom:3px "> <label
										for="first_name2" style="font-size: 14px; font-weight: normal">Address1</label>
									<span id="hotelAddressErr" style="font-size:13px;color:red"></span>
								</div>
							</div>
							<div class="">
								<div class="input-field ">
									<input type="text" name="Address2" id="Address2"
										style="font-size: 16px;padding-left:10px"> <label
										for="first_name2" style="font-size: 14px; font-weight: normal">Address2</label>
								</div>
							</div>
							<div class="">
								<div class="input-field ">
									<input type="text" name="Street" id="Street"
										style="font-size: 16px;padding-left:10px;margin-bottom:3px "> <label
										for="first_name2" style="font-size: 14px; font-weight: normal">City</label>
									<span id="hotelCityErr" style="font-size:13px;color:red"></span>
								</div>
							</div>
							<div class="">
								<div class="input-field ">
									<input type="text" name="Town" id="State"
										style="font-size: 16px;padding-left:10px;margin-bottom:3px "> <label
										for="first_name2" style="font-size: 14px; font-weight: normal">State/Province</label>
									<span id="hotelStateErr" style="font-size:13px;color:red"></span>
								</div>
							</div>
							<div class="">
								<div class="input-field ">
									<input type="text" id="zipcode" name="zipcode" onkeyup = "Validate(this)"
										style="font-size: 16px;padding-left:10px;margin-bottom:3px "> <label
										for="first_name2" style="font-size: 14px; font-weight: normal">Zip Code/Postal Code</label>
									<span id="hotelZipcodeErr" style="font-size:13px;color:red"></span>
								</div>
							</div>
							
							<div class="">
								<div class="input-field ">
									<input type="text" name="country" id="country"
										style="font-size: 16px;padding-left:10px;margin-bottom:3px "> <label
										for="first_name2" style="font-size: 14px; font-weight: normal">Country</label>
									<span id="hotelCountryErr" style="font-size:13px;color:red"></span>
								</div>
							</div>
							
							<div class="file-field input-field ">
								<div class="btn" style="padding: 0 10px 0 10px;">
									<span>Hotel Logo</span> <input type="file" name="hotelLogo" multiple>
								</div>
								<div class="file-path-wrapper" style="padding-left:70px">
									<input class="file-path" type="text"
										placeholder="Upload Hotel Logo"
										style="font-weight: normal; font-size: 14px;">
								</div>
							</div>
							
							<div class="">
								<div class="input-field ">
									<input type="text" name="longitude" id="addLongitude" onkeypress="return isNumber(event)"
										style="font-size: 16px;padding-left:10px;margin-bottom:3px " > <label
										for="first_name2" style="font-size: 14px; font-weight: normal">Longitude
										</label>
									
								</div>
							</div>
							
							<div class="">
								<div class="input-field ">
									<input type="text" name="latitude" id="addLatitude" onkeypress="return isNumber(event)"
										style="font-size: 16px;padding-left:10px;margin-bottom:3px " > <label
										for="first_name2" style="font-size: 14px; font-weight: normal">Latitude
										</label>
									
								</div>
							</div>

							
							

							<div class="file-field input-field ">
								<div class="btn" style="padding: 0 10px 0 10px;">
									<span>Hotel Image</span> <input type="file" name="logo" multiple>
								</div>
								<div class="file-path-wrapper" style="padding-left:70px">
									<input class="file-path" type="text"
										placeholder="Upload Hotel Image"
										style="font-weight: normal; font-size: 14px;">
								</div>
							</div>
														
														<div class="file-field input-field ">
								<div class="btn" style="padding: 0 10px 0 10px;">
									<span>Hotel Footer</span> <input type="file" name="hotelFooter" multiple>
								</div>
								<div class="file-path-wrapper" style="padding-left:70px">
									<input class="file-path" type="text"
										placeholder="Upload Hotel Footer"
										style="font-weight: normal; font-size: 14px;">
								</div>
							</div>

							
							<div class="">
								<div class="input-field ">
									<a href="javascript: hotelSubmitform()" class="btn ">Submit</a>
									<button type="reset" class="btn ">Clear</button>
									<br> <br> <br>
								</div>
							</div>
						
					</div>
	       
	      </div>
	 	</form:form>     
	</div>
	
	<!-- end of the add hotel popup -->
	
	
	<!--  create template popup -->
 
  <div id="createTemplate" class="modal" style="width:30%">
  <form:form action="addTemplate" method="post" name="addTemplate" >
   <a href="#!" class=" modal-action modal-close right waves-effect waves-green btn-flat">Close</a>
      <div class="modal-content">
      	<div class="preloader-wrapper small active tspin" style="display:none;margin:2% 0 0 50%">
		    <div class="spinner-layer spinner-green-only">
		      <div class="circle-clipper left">
		        <div class="circle"></div>
		      </div><div class="gap-patch">
		        <div class="circle"></div>
		      </div><div class="circle-clipper right">
		        <div class="circle"></div>
		      </div>
		    </div>
		  </div>
         <center><h5 > Create Template </h5></center>
         <div class="">
           <div class="input-field col s12">
          
             <input  type="text" class="validate" required id="templateName" name="templateName" style="padding:0px 0px 0px 0px;margin-bottom:3px">
             <label for="name" style="padding:0px 0px 0px 0px">Template Name</label>
             <span id="templateNameErr" style="color:red;font-size:13px"></span>             
             <span id="templateExistErr" style="color:red;font-size:13px"></span>
           </div>
         </div>
         
         <div class="">
			<div class="input-field ">
				<select class="browser-default" required id="templateId" name="templateId">
					<option value="" disabled selected>Choose Template</option>
					<c:forEach var="listOfEgsdTemplateObjects"
							items="${listOfEgsdTemplateObjects }">
					<option value="${listOfEgsdTemplateObjects.objectId }">${listOfEgsdTemplateObjects.name }</option>
					</c:forEach>
				</select>
				<span id="templateIdErr" style="color:red;font-size:13px"></span>
			</div>
		</div>
         
       	
       	<input type="hidden" value="${user }" name="user">
       	<input type="hidden" value="${userName }" name="userName">
       	
       <center style="margin-top:5%"><a href="javascript: submitform()" id="addNewTemplate"  class="waves-effect waves-light btn">Create Template</a></center>
       
      </div>
 	</form:form>     
  </div>
 
 <!-- end of the template popup -->
 
 
 <!--  create group hotel popup -->
 <div id="groupHotel" class="modal" style="min-height:200px;width:30%">
  <form:form action="addGroup" method="post" name="addGroup" >
   <a href="#!" class=" modal-action modal-close right waves-effect waves-green btn-flat">Close</a>
      <div class="modal-content">
      	<div class="preloader-wrapper small active gspin" style="display:none;margin:2% 0 0 50%">
		    <div class="spinner-layer spinner-green-only">
		      <div class="circle-clipper left">
		        <div class="circle"></div>
		      </div><div class="gap-patch">
		        <div class="circle"></div>
		      </div><div class="circle-clipper right">
		        <div class="circle"></div>
		      </div>
		    </div>
		  </div>
         <center><h5 > Create Hotel Group</h5></center>
         <div class="">
           <div class="input-field col s12">
          
           <input type="hidden" name="user" value="${user }">
           <input type="hidden" name="userName" value="${userName }">
          
             <input  type="text" required name="groupName" id="addGroupName" style="margin-bottom:3px">
             <label for="name" style="padding:0 10px 0 10px">Group Name</label>
             <span id="groupNameErr" style="color:red;font-size:13px"></span>
             <span id="groupExistErr" style="color:red;font-size:13px"></span>
           </div>
           <div class="">
    <div class="input-field ">
     <select  class="browser-default" name="templateId" required id="addTemplateId">
      <option value="" disabled selected>Choose Template</option>
       <c:forEach var="listOfEgsdTemplateObjects"
        items="${listOfEgsdTemplateObjects }">
        <option value="${listOfEgsdTemplateObjects.objectId }">${listOfEgsdTemplateObjects.name }</option>
       </c:forEach>
     </select>
     <span id="groupIdErr" style="color:red;font-size:13px"></span>
    </div>
   </div>
           
       </div>
        
        
        
       <center style="margin-top:5%"><a id="addNewGroup" href="javascript: groupSubmitform()" class="waves-effect waves-light btn">Create Hotel Group </a></center>
       
      </div>
  </form:form>     
  </div>
 <!-- end of the group hotel popup -->
 
  <!--  create chain hotel popup -->
 <div id="chainHotel" class="modal" >
  <form:form action="addChainHotel" method="post" >
   <a href="#!" class=" modal-action modal-close right waves-effect waves-green btn-flat">Close</a>
      <div class="modal-content">
         
         <div class="">
           <div class="input-field col s12">
          
           <input type="hidden" name="user" value="${user }">
           <input type="hidden" name="userName" value="${userName }">
          
          
             <input  type="text"  class="validate" name="Name" style="padding:0 10px 0 10px">
             <label for="name" >Hotel Name</label>
           </div>
           
           <div class="">
    <div class="input-field ">
     <select  name="locationId" class="browser-default">
      <option value="" disabled selected>Choose Hotel</option>
      <c:forEach var="selectLocObj"
        items="${selectLocObj }">
        <option value="${selectLocObj.objectId }">${selectLocObj.name }</option>
       </c:forEach>
       
     </select>
    </div>
   </div>
           
           <div class="">
    <div class="input-field ">
     <select  name="groupId" class="browser-default">
      <option value="" disabled selected>Choose Group</option>
       <c:forEach var="listOfEgsdGroupObjects"
        items="${listOfEgsdGroupObjects }">
        <option value="${listOfEgsdGroupObjects.objectId }">${listOfEgsdGroupObjects.name }</option>
       </c:forEach>
       
     </select>
    </div>
   </div>
   
   <div class="">
    <div class="input-field ">
     <input type="text" name="Address1" 
      style="font-size: 16px; "> <label
      for="first_name2" style="font-size: 14px; font-weight: normal">Address1</label>
    </div>
   </div>
   <div class="">
    <div class="input-field ">
     <input type="text" name="Address2"
      style="font-size: 16px; "> <label
      for="first_name2" style="font-size: 14px; font-weight: normal">Address2</label>
    </div>
   </div>
   <div class="">
    <div class="input-field ">
     <input type="text" name="Street" 
      style="font-size: 16px; "> <label
      for="first_name2" style="font-size: 14px; font-weight: normal">Street</label>
    </div>
   </div>
   <div class="">
    <div class="input-field ">
     <input type="text" name="Town" 
      style="font-size: 16px; "> <label
      for="first_name2" style="font-size: 14px; font-weight: normal">Town</label>
    </div>
   </div>
   <div class="">
    <div class="input-field ">
     <input type="text" name="zipcode" onkeypress="return isNumber(event)"
      style="font-size: 16px; "> <label
      for="first_name2" style="font-size: 14px; font-weight: normal">Zipcode</label>
    </div>
   </div>
   <div class="file-field input-field ">
    <div class="btn" style="padding: 0 10px 0 10px;">
     <span>Image</span> <input type="file" name="logo" multiple>
    </div>
    <div class="file-path-wrapper">
     <input class="file-path" type="text"
      placeholder="Upload Hotel image"
      style="font-weight: normal; font-size: 14px">
    </div>
   </div>
  <!--  <div class="">
    <div class="input-field ">
     <button type="submit" class="btn ">Add Hotel</button>
     <button type="reset" class="btn ">Clear</button>
     <br> <br> <br>
    </div>
   </div>
           
   -->         
        
       <center><button type="submit" class="waves-effect waves-light btn">Create Chain Hotel</button></center>
       
         </div>
      </div>
  </form:form>     
  </div>
 <!-- end of the chain hotel popup -->
 
 
 <!--  create change password popup -->

  
  <div id="changePassword" class="modal" style="overflow:auto;margin-top:0%">
 
  
    <a href="#!" class=" modal-action modal-close right waves-effect waves-green btn-flat">Close</a>
       <div class="modal-content sbody">
       <center> <span id="changeResultsErr" style="color:red;font-size:12px"></span> </center>
       <center><h5 id="passwordText" style="font-size:18px"> Change User Password </h5></center>
          
          
          <div class="row margin">
      <div class="input-field col s12">
       <input  type="password" class="customFont" name="changepassword" id="cPassword"  style="padding: 0 10px 0 10px">
       <span id="cpasErr" style="color:red;font-size:12px"></span>
       <label  class="center-align active customFont">New Password</label>
      </div>
     </div>
        <div class="row margin">
      <div class="input-field col s12">
       <input  type="password" class="customFont" name="reenterpassword" id="reenterPassword"  style="padding: 0 10px 0 10px">
       <span id="rpassErr" style="color:red;font-size:12px"></span>
       <label  class="center-align active customFont">Re-Enter Password</label>
      </div>
     </div>
      
     
     <input type="hidden" id="changePasswordUser" name="user" value="${user}">
     
     
           
           <div class="row">
             <div class="input-field col s12">
               <button type="submit" id="savePassword" class="btn  waves-light col s12">Save User Password</button>
               
             </div>
             
           </div>
          
       </div>
    
  </div>
 
 
<!--  end of the change password popup -->

<!-- success change password popup -->
 
 	
 		<a class="waves-effect waves-light btn modal-trigger" style="display:none" id="cuPassword" href="#chgPass">Modal</a>
			<div id="chgPass" class="modal" style="height:28%;font-size:16px;top:3% !important">
			    <div class="modal-content">
			     	<center> <p>Succesfully Changed User Password.</p> </center>
			     	
			     	<a href="../" style="float:right;padding:0px 28px 0 28px" class="waves-green btn">Ok</a>
				 
			    </div>
			    
			</div>
 	
 
 <!-- end of chenge password popup -->
 
 
 <!--  create Add Super admin popup -->

  
   <div id="superAdmin" class="modal" style="overflow:auto;margin-top:0%">
 
  
    <a href="#!" class=" modal-action modal-close right waves-effect waves-green btn-flat">Close</a>
       <div class="modal-content sbody">
       <center><h5 id="supertext"> Create Super Admin User </h5></center>
          <center><span class="userExisted" style="color:red;font-size:13px;"></span></center>
          <input type="hidden" id="saEmail"/>
          <div class="row margin">
      <div class="input-field col s12">
       <input  type="text" class="customFont" name="firstname" id="superFirstname"  style="padding: 0 10px 0 10px">
       <span id="sfnameErr" style="color:red;font-size:12px"></span>
       <label  class="center-align active customFont">First Name</label>
      </div>
     </div>
        <div class="row margin">
      <div class="input-field col s12">
       <input  type="text" class="customFont" name="lastname" id="superLastname"  style="padding: 0 10px 0 10px">
       <span id="slnameErr" style="color:red;font-size:12px"></span>
       <label  class="center-align active customFont">Last Name</label>
      </div>
     </div>
      <div class="row margin">
      <div class="input-field col s12">
       <!--             <i class="mdi-social-person-outline prefix"></i> -->
       <input  type="text" class="customFont" name="username" required id="superUsername"  style="padding: 0 10px 0 10px">
       <span id="sunameErr" style="color:red;font-size:12px"></span>
       <label  class="center-align active customFont">User Name</label>
      </div>
     </div>
     <div class="row margin">
      <div class="input-field col s12">
       <input  type="email" class="customFont" name="email" id="superEmail" required style="padding: 0 10px 0 10px">
       <span id="semailErr" style="color:red;font-size:12px"></span>
       <label  class="center-align active customFont">Email</label>
      </div>
     </div>
     
     <div class="row margin">
      <div class="input-field col s12">
       <!--             <i class="mdi-social-person-outline prefix"></i> -->
       <input  type="text" class="customFont" name="username" required id="superPhone"  onkeypress="return isNumber(event)" style="padding: 0 10px 0 10px">
       <span id="sphoneErr" style="color:red;font-size:12px"></span>
       <label  class="center-align active customFont">Phone Number</label>
      </div>
     </div>
     
     <input type="hidden" id="user" name="user" value="${user}">
     <input type="hidden" name="userName" id="userName" value="${userName }">
     <input type="hidden" name="adminType" id="adminType" >
     
           
           <div class="row">
             <div class="input-field col s12">
               <button type="submit" id="createSuperAdmin" class="btn waves-light col s12">Create Super Admin</button>
               <button type="submit" id="updateSuperAdmin" style="display:none" class="btn waves-light col s12">Update Super Admin</button>
             </div>
             
           </div>
          
       </div>
    
  </div>
 
 
<!--  end of the Super admin popup -->
 
 
 
 <!--  create Add cs admin popup -->

  
  <div id="csAdmin" class="modal" style="overflow:auto;margin-top:0%">
   
    <a href="#!" class=" modal-action modal-close right waves-effect waves-green btn-flat">Close</a>
       <div class="modal-content csbody">
       <center><h5 id="cstext"> Create Customer Service Admin User </h5></center>
       <input type="hidden" id="caEmail"/>
          <center><span class="userExisted" style="color:red;font-size:13px;"></span></center>
          <div class="row margin">
      <div class="input-field col s12">
       <input  type="text" class="customFont" name="firstname" id="csFirstname"  style="padding: 0 10px 0 10px">
       <span id="cfnameErr" style="color:red;font-size:12px"></span>
       <label  class="center-align active customFont">First Name</label>
      </div>
     </div>
        <div class="row margin">
      <div class="input-field col s12">
       <input  type="text" class="customFont" name="lastname" id="csLastname" style="padding: 0 10px 0 10px">
       <span id="clnameErr" style="color:red;font-size:12px"></span>
       <label  class="center-align active customFont">Last Name</label>
      </div>
     </div>
      <div class="row margin">
      <div class="input-field col s12">
       <input  type="text" class="customFont" name="username" required id="csUsername"  style="padding: 0 10px 0 10px" >
       <span id="cunameErr" style="color:red;font-size:12px"></span>
       <label  class="center-align active customFont">User Name</label>
      </div>
     </div>
     <div class="row margin">
      <div class="input-field col s12">
       <input  type="email" class="customFont" name="email" id="csEmail" required style="padding: 0 10px 0 10px">
       <span id="cemailErr" style="color:red;font-size:12px"></span>
       <label  class="center-align active customFont">Email</label>
      </div>
     </div>
     <div class="row margin">
      <div class="input-field col s12">
       <input  type="text" class="customFont" name="email" id="csPhone" onkeypress="return isNumber(event)" required style="padding: 0 10px 0 10px">
       <span id="cPhoneErr" style="color:red;font-size:12px"></span>
       <label  class="center-align active customFont">Phone Number</label>
      </div>
     </div>
     
     <input type="hidden" name="user" value="${user}">
     <input type="hidden" name="userName" value="${userName }">
           
           <div class="row">
             <div class="input-field col s12">
               <button type="submit" id="createCSAdmin" class="btn  waves-light col s12">Create CS Admin</button>
               <button type="submit" id="updateCSAdmin" style="display:none" class="btn  waves-light col s12">Update CS Admin</button>
             </div>
             
           </div>
          
       </div>
    
  </div>
 
 
<!--  end of the cs admin popup -->


<!--   start location admin popup -->

   <div  class="modal locationAdmin" style="overflow:auto;margin-top:0%">
  
    <a href="#!" class=" modal-action modal-close right waves-effect waves-green btn-flat">Close</a>
       <div class="modal-content lsbody">
       <center><h5 id="locationtext"> Create Location Admin User </h5></center>
       <input type="hidden" id="laEmail"/>
          <center><span class="userExisted" style="color:red;font-size:13px;"></span></center>
          <div class="row margin">
      <div class="input-field col s12">
       <!--             <i class="mdi-social-person-outline prefix"></i> -->
       <input  type="text" class="customFont" name="firstname" id="locationFirstname" style="padding: 0 10px 0 10px">
       <span id="lfnameErr" style="color:red;font-size:12px"></span>
       <label  class="center-align active customFont">First Name</label>
      </div>
     </div>
        <div class="row margin">
      <div class="input-field col s12">
       <!--             <i class="mdi-social-person-outline prefix"></i> -->
       <input  type="text" name="lastname" class="customFont" id="locationLastname" style="padding: 0 10px 0 10px">
       <span id="llnameErr" style="color:red;font-size:12px"></span>
       <label  class="customFont center-align active">Last Name</label>
      </div>
     </div>
      <div class="row margin">
      <div class="input-field col s12">
       <!--             <i class="mdi-social-person-outline prefix"></i> -->
       <input  type="text" name="username" class="customFont" id="locationUsername" required style="padding: 0 10px 0 10px" >
       <span id="lunameErr" style="color:red;font-size:12px"></span>
       <label  class="customFont center-align active">User Name</label>
      </div>
     </div>
           <div class="row margin">
      <div class="input-field col s12">
       <!--             <i class="mdi-social-person-outline prefix"></i> -->
       <input  type="email" name="email" class="customFont" id="locationEmail" required style="padding: 0 10px 0 10px">
       <span id="lemailErr" style="color:red;font-size:12px"></span>
       <label  class="customFont center-align active">Email</label>
      </div>
     </div>
     
     <div class="row margin">
      <div class="input-field col s12">
       <!--             <i class="mdi-social-person-outline prefix"></i> -->
       <input  type="text" name="email" class="customFont" id="locationPhone" onkeypress="return isNumber(event)" required style="padding: 0 10px 0 10px">
       <span id="lPhoneErr" style="color:red;font-size:12px"></span>
       <label  class="customFont center-align active">Phone Number</label>
      </div>
     </div>
     
     <input type="hidden" name="user" value="${user}">
     <input type="hidden" name="userName" value="${userName }">
           
           <div class="row">
             <div class="input-field col s12">
               <button type="submit" id="createLocationAdmin" class="btn  waves-light col s12">Create Location Admin</button>
               <button type="submit" id="updateLocationAdmin" style="display:none" class="btn  waves-light col s12">Update Location Admin</button>
             </div>
             
           </div>
          
       </div>
     
  </div>
  

<!--  end of the location admin popup -->
	
<!-- 	manage contact info popup -->

		<div id="contactInfo" class="modal" style="width:70%;min-height:200px" >
		  <%-- <form:form action="" method="post" > --%>
		   <a href="#!" class=" modal-action modal-close right waves-effect waves-green btn-flat">Close</a>
		      <div class="modal-content" >
		      		<div id='TextBoxesGroup'>
						<div id="TextBoxDiv1">
						  <div class="row">
							<div class="input-field col s4">
								<select id="select1" class="browser-default" name="manageType">
								  <option value="" disabled selected>Choose Phone/Email/Website</option>
								  <option value="phone">Phone</option>
								  <option value="email">Email</option>
								  <option value="website">Website</option>
								</select>
							</div>
							<div class="input-field col s3"></div>
							<div class="input-field col s5" style="margin:0 0 0 0">
								  <input id="textbox1" type="text" name="manageDetails" class="validate" >
								  <label for="textbox1">Enter Phone/Website/Email Details</label>
							</div>
						  </div>
						 </div>
					  </div>
					<button type="submit" class="btn waves-effect waves-light" id='addButton' style="margin-bottom:40px;margin-left:15px">Add Onemore</button>
					<button type="submit" class="btn waves-effect waves-light" id='removeButton' style="margin-bottom:40px">Remove</button>
					<button type="submit" class="btn waves-effect waves-light" id='getButtonValue' style="margin-bottom:40px">Save</button>
					
			      </div>		             	
		      	
		      
		 	<%-- </form:form>   --%>   
		 </div>
	
	
<!-- 	end of manage contact info popup -->

<!-- <input type="text" id="plugins4_q" value="" class="input" 
style="margin:0em auto 1em auto; display:block; padding:4px;
 border-radius:4px; border:1px solid silver;">
 -->
		<a class="waves-effect waves-light btn modal-trigger" style="display:none" id="narshimha" href="#modal6">Modal</a>
			<div id="modal6" class="modal">
			    <div class="modal-content">
			     	 <p><span id="userType"></span> has been created successfully. Notification email has been sent to the email id entered with user credentials.</p>
				 
			    </div>
			    <div class="modal-footer">
			      <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat">Ok</a>
			    </div>
			  </div>
	



		


		<!--  <script type="text/javascript" src="../js/jquery-1.11.2.min.js"></script> --> 

		<script type="text/javascript" src="../js/materialize.js"></script>

		<!--prism-->
		<script type="text/javascript" src="../js/prism.js"></script>
		<!--scrollbar-->
		<script type="text/javascript" src="../js/perfect-scrollbar.min.js"></script>
		<!-- chartist -->
		<!--  <script type="text/javascript" src="../js/plugins/chartist-js/chartist.min.js"></script> -->

		<!--plugins.js - Some Specific JS codes for Plugin Settings-->
		<script type="text/javascript" src="../js/plugins.js"></script>
		
		<script>
			
		
		
				
			
			  function handleClick(cb) {
							
				var spl = cb.split(":");
				for(var i=2;i<20;i++)
				{
					$('.TextBoxDiv'+i).hide();
					
				}	
				$('#menu'+spl[1]).show();
				
				$('.hr').show();
				$('.counter').val('2');
				
				
				$('input[type="checkbox"]').click(function(){
		            
		            if($(this).prop("checked") == false){
		            	//$('#manage'+spl[1]).hide();
						$('#menu'+spl[1]).hide();
						$('.hr').hide();
						$('.counter').val('0');
		            }
		        });
				
						
			}  
			  
			  function edithandleClick(cb) {
					
					var spl = cb.split(":");
					$('.edithr1').show();
					
					$('#editmenu'+spl[1]).show();
					//var val = $('.editmenuCount').val();
					
					for(var i=2;i<20;i++)
					{
						$('.editmenuTextBoxDiv'+i).hide();
						
					}	
					
					
					$('input[type="checkbox"]').click(function(){
			            
			            if($(this).prop("checked") == false){
			            	//$('#manage'+spl[1]).hide();
							$('#editmenu'+spl[1]).hide();
							$('.edithr1').hide();
							$('.editmenuCount').val('0');
			            }
			        });
					
							
				}  
			  
			  function editcontactClick(cb) {
					
					var spl = cb.split(":");
					$('.edithr2').show();
					
					//$('.editcontactCount').val('2');
					$('#editcontact'+spl[1]).show();
					
					for(var i=2;i<20;i++)
					{
						$('.editmanageTextBoxDiv'+i).hide();
						
					}
					
					
					$('input[type="checkbox"]').click(function(){
			            
			            if($(this).prop("checked") == false){
			            	//$('#manage'+spl[1]).hide();
							$('#editcontact'+spl[1]).hide();
							$('.edithr2').hide();
							$('.editcontactCount').val('0');
			            }
			        });
					
							
				} 

			  
			
			function contactClick(cb) {
				
				var spl = cb.split(":");
				for(var i=2;i<20;i++)
				{
					$('.TextBoxDiv'+i).hide();
					
				}	
				$('#contact'+spl[1]).show();
				
				$('.hr1').show();
				$('.manageCount').val('2');
				
				
				$('input[type="checkbox"]').click(function(){
		            
		            if($(this).prop("checked") == false){
		            	//$('#manage'+spl[1]).hide();
						$('#contact'+spl[1]).hide();
						$('.hr1').hide();
						$('.manageCount').val('0');
		            }
		        });
				
						
			} 
			
			
						
			  
			  
			
		
		</script>	
		
		<script type="text/javascript">
		    function Check() {
		        var chkPassport = document.getElementById("checkBox");
		        if (chkPassport.checked) {
		            
		        	$('#showGroups').show();
	            	//$("#showTemplates").prop("disabled", true);
	            	$("#showTemplates").hide();
		        	
		        } else {
		            
		        	$('#showGroups').hide();
	            	//$("#showTemplates").prop("disabled", false);
	            	$("#showTemplates").show();
		        	
		        }
		    }
		</script>
		
		<script type="text/javascript">



    //var counter = 2;
    
		
    $(".editmenuaddButton").click(function () {
		
    	//alert($('.editmenuCount').val());
    	var editmenucounter = $('.editmenuCount').val();
    	editmenucounter = parseInt(editmenucounter);
		
	var newTextBoxDiv = $(document.createElement('div'))
	     .attr("class", 'editmenuTextBoxDiv' + editmenucounter);
                
	newTextBoxDiv.after().html('<div class="row">'+
			
			'<div class="input-field col s4">'+
				'<input type="text" class="description'+editmenucounter+' " name="editmenuDescription'+editmenucounter+'" style="font-weight: normal; font-size: 14px">'+
				'<label class="active" style="font-weight: normal; font-size: 14px">MenuItem Description</label></div>'+
			'<div class="input-field col s2">'+
				'<input type="text" class="price'+editmenucounter+' " name="editmenuPrice'+editmenucounter+'" style="font-weight: normal; font-size: 14px">'+
				'<label class="active" style="font-weight: normal; font-size: 14px">Price</label></div>'+
				'<input type="button" value="Delete" class="editmenuremoveButton btn input-field col s1">'+
			/* '<div class="input-field col s2">'+
				'<input type="text" name="menuColor'+counter+'" value="3623DB" class="color" style="font-weight: normal; font-size: 14px">'+
				'<label class="active" for="last_name" style="font-weight: normal; font-size: 14px">Color</label> </div>'+
			'<div class="input-field col s2">'+
				'<select class="browser-default font'+counter+'" name="menuFont'+counter+'">'+
				'<option value="" selected>Font Weight</option>'+
				'<option default>Seleted</option>'+
				'<option value="8" style="font-size: 8px">Small</option>'+
				'<option value="12" style="font-size: 12px">Normal</option>'+
				'<option value="16" style="font-size: 16px">Large</option>'+
				'<option value="20" style="font-size: 20px">Huge</option></select></div>'+
			'<div class="input-field col s2">'+
				'<select class="browser-default family'+counter+'" name="menuFamily'+counter+'">'+
				'<option value="" selected>Font Family</option>'+
				'<option value="verdana" default>Seleted</option>'+
				'<option value="verdana" >Verdana</option>'+
				'<option value="cursive" >Cursive</option>'+
				'<option value="monospace" >Monosapce</option>'+
				'<option value="sans-serif" >Sans-Serif</option>'+
				'<option value="serif" >Serif</option></select></div>'+ */
				        
      '</div>');
	
	            
	newTextBoxDiv.appendTo(".editmenuTextBoxesGroup");

				
	editmenucounter++;
	 $('.editmenuCount').val(editmenucounter);
     });
    
    
    $("body").on("click", ".editmenuremoveButton", function () {
        $(this).closest("div").remove();
        
    });
  </script>
		
		
		<script type="text/javascript">



    
		
    $(".addButton").click(function () {
				
    	var counter = 2;
		
	var newTextBoxDiv = $(document.createElement('div'))
	     .attr("class", 'TextBoxDiv' + counter);
                
	newTextBoxDiv.after().html('<div class="row">'+
			
			'<div class="input-field col s4">'+
				'<input type="text" class="description'+counter+' " name="menuDescription'+counter+'" style="font-weight: normal; font-size: 14px">'+
				'<label class="active" style="font-weight: normal; font-size: 14px">MenuItem Description</label></div>'+
			'<div class="input-field col s2">'+
				'<input type="text" class="price'+counter+' " name="menuPrice'+counter+'" style="font-weight: normal; font-size: 14px">'+
				'<label class="active" style="font-weight: normal; font-size: 14px">Price</label></div>'+
				'<input type="button" value="Delete" class="removeButton btn input-field col s1">'+
			/* '<div class="input-field col s2">'+
				'<input type="text" name="menuColor'+counter+'" value="3623DB" class="color" style="font-weight: normal; font-size: 14px">'+
				'<label class="active" for="last_name" style="font-weight: normal; font-size: 14px">Color</label> </div>'+
			'<div class="input-field col s2">'+
				'<select class="browser-default font'+counter+'" name="menuFont'+counter+'">'+
				'<option value="" selected>Font Weight</option>'+
				'<option default>Seleted</option>'+
				'<option value="8" style="font-size: 8px">Small</option>'+
				'<option value="12" style="font-size: 12px">Normal</option>'+
				'<option value="16" style="font-size: 16px">Large</option>'+
				'<option value="20" style="font-size: 20px">Huge</option></select></div>'+
			'<div class="input-field col s2">'+
				'<select class="browser-default family'+counter+'" name="menuFamily'+counter+'">'+
				'<option value="" selected>Font Family</option>'+
				'<option value="verdana" default>Seleted</option>'+
				'<option value="verdana" >Verdana</option>'+
				'<option value="cursive" >Cursive</option>'+
				'<option value="monospace" >Monosapce</option>'+
				'<option value="sans-serif" >Sans-Serif</option>'+
				'<option value="serif" >Serif</option></select></div>'+ */
				        
      '</div>');
	
	            
	newTextBoxDiv.appendTo(".TextBoxesGroup");

				
	counter++;
	 $('.counter').val(counter);
     });
    
    
    $("body").on("click", ".removeButton", function () {
        $(this).closest("div").remove();
        
    });
   

     
	 
	 
     
</script>
				
		<script type="text/javascript">
			(function($) {
				$(function() {

					$(".dropdown-button").dropdown();

				}); // End Document Ready
				$('.counter').val('0');
				$('.manageCount').val('0');
			})(jQuery);
			
			$('#remember-me').click(function(){
				
					$("#but").show();
				});
			
			
			
			
		</script>
		
		<script type="text/javascript">



		    
				
		    $(".editmanageAddButton").click(function () {
						
		    	var editManageCounter = $('.editcontactCount').val();
		    	editManageCounter = parseInt(editManageCounter);
				
			var newTextBoxDiv = $(document.createElement('div'))
			     .attr("class", 'editmanageTextBoxDiv' + editManageCounter);
		                
			newTextBoxDiv.after().html('<div class="row">'+
				'<div class="input-field col s3"><select name="editmanageType'+editManageCounter+'" style="display:-webkit-inline-box;" class="type'+editManageCounter+'"><option value="" disabled selected>Phone/Email/Website</option>'+
						  '<option value="phone">Phone</option>'+
						  '<option value="email">Email</option>'+
						  '<option value="website">Website</option></select></div>'+
				
		        '<div class="input-field col s3">'+
		          '<input class="details'+editManageCounter+'" type="text" name="editmanageDetails'+editManageCounter+'">'+
		          '<label for="first_name"></label>'+
		        '</div>'+
		        '<input type="button" value="Delete" class="editmanageremoveButton btn input-field col s1">'+
		        
		      '</div>');
		            
			newTextBoxDiv.appendTo(".editmanageTextBoxesGroup");
			
									
			editManageCounter++;
			$('.editcontactCount').val(editManageCounter);
			
		     });
		    
		    $("body").on("click", ".editmanageremoveButton", function () {
		        $(this).closest("div").remove();
		        
		    });
		    
		    
		    </script>
		
		
		<script type="text/javascript">



		    
				
		    $(".manageAddButton").click(function () {
						
		    	var counter = 2;
				
			var newTextBoxDiv = $(document.createElement('div'))
			     .attr("class", 'manageTextBoxDiv' + counter);
		                
			newTextBoxDiv.after().html('<div class="row">'+
				'<div class="input-field col s3"><select name="manageType'+counter+'" style="display:-webkit-inline-box;" class="type'+counter+'"><option value="" disabled selected>Phone/Email/Website</option>'+
						  '<option value="phone">Phone</option>'+
						  '<option value="email">Email</option>'+
						  '<option value="website">Website</option></select></div>'+
				
		        '<div class="input-field col s2">'+
		          '<input class="details'+counter+'" type="text" name="manageDetails'+counter+'">'+
		          '<label for="first_name"></label>'+
		        '</div>'+
		        '<input type="button" value="Delete" class="manageRemoveButton btn input-field col s1">'+
		        
		      '</div>');
		            
			newTextBoxDiv.appendTo(".manageTextBoxesGroup");
			
									
			counter++;
			$('.manageCount').val(counter);
			
		     });
		    
		    $("body").on("click", ".manageRemoveButton", function () {
		        $(this).closest("div").remove();
		        
		    });
		
		     /* $(".manageRemoveButton").click(function () {
			if(counter==1){
		          alert("No more textbox to remove");
		          return false;
		       }   
		        
			counter--;
			$('.manageCount').val(counter);
					
		        $(".manageTextBoxDiv" + counter).remove();
					
		     }); */
			 
			  
		    
		 
				
		     
		</script>
		
		
		
		<script type="text/javascript">
			var lastUsed = null;
			
			$(".locAdmin").click(function(){
				
				var admin = $(this).val();
				//alert(admin);
				
			});

			function reply_click(clicked_id) {

				$('.addLocationForm').hide();

				$('.addLocationDiv').hide();
				$('#divSection').show();

				prevClicked = lastUsed;
				$("." + prevClicked).hide();

				$("." + clicked_id).show();
				lastUsed = clicked_id;

			}
			function preview_Directory_click(clicked_id) {
			    
			    //alert(clicked_id);
			    window.open("http://betabullsapp.github.io/eGSD/directories.html?id="+clicked_id, "_blank", "toolbar=yes, scrollbars=yes, resizable=yes,left=500, width=400, height=700");
			    
			   }
			
			function preview_Hotel_click(obj)	{
				
				var hId = $(obj).attr("class");
				window.open("http://betabullsapp.github.io/eGSD/directories.html?id="+hId, "_blank", "toolbar=yes, scrollbars=yes, resizable=yes,left=500, width=400, height=700");
			}

			function Loc_click_redirect(clicked_id) {
				
				/* alert(clicked_id); */
				window.location = clicked_id;
				

			}

			function Loc_click(clicked_id) {
				$('.addLocationDiv').hide();

				$('.addLocationForm').hide();

				
				
				$('.locPopup').show();

				prevClicked = lastUsed;
				$("." + prevClicked).hide();

				$("." + clicked_id).show();
				lastUsed = clicked_id;

			}
			function desc_click(clicked_id) {
				$('.edithr1').hide();
				$('.edithr2').hide();
				
				$('#overlay').show();
				$('.popup').show();
				$('.selectLocation').hide();
				$('.save').hide();

				$('.addLocationForm').hide();

				$('.editPopup').show();
				$("." + clicked_id).show();
			}
			function del_click(clicked_id) {

				$('#overlay').show();
				$('.popup').show();
				$('.selectLocation').hide();
				$('.save').hide();
				$('.addLocationForm').hide();

				$('.delPopup').show();
				$("." + clicked_id).show();
			}
			function manage_contact_click(clicked_id) {
				$('#overlay').show();
				$('.popup').show();

				$('.addLocationDiv').hide();
				$('.addLocationForm').hide();

				$('.manageDetailsPopup').show();
				prevClicked = lastUsed;
				$("." + prevClicked).hide();

				$("." + clicked_id).show();
				lastUsed = clicked_id;
			}
			function add_DirectoryItems_click(clicked_id) {
				
				
				$('#overlay').show();
				$('.popup').show();
				 $('input:checkbox').removeAttr('checked');
				 $('#menu'+clicked_id).hide();
				$('.addLocationDiv').hide();
				$('.addLocationForm').hide();

				$('.addDirectoryItemsPopup').show();
				prevClicked = lastUsed;
				$("." + prevClicked).hide();

				$("." + clicked_id).show();
				lastUsed = clicked_id;
			}
			function add_Directory_click(clicked_id) {
				$('#overlay').show();
				$('.popup').show();
				$('.addLocationDiv').hide();
				$('.addLocationForm').hide();

				$('.addDirectoryPopup').show();
				$("." + clicked_id).show();

			}
			function del_Loc_click(clicked_id) {

				$('#overlay').show();
				$('.popup').show();
				$('.selectLocation').hide();
				$('.save').hide();
				$('.addLocationForm').hide();

				$('.deleteLocation').show();
				$('.addDirectoryPopup').hide();
				$("." + clicked_id).show();
			}
			function edit_Directory_click(clicked_id) {

				$('#overlay').show();
				$('.popup').show();
				$('.addDirectoryPopup').hide();

				$('.addLocationForm').hide();

				$('.editLocation').show();

				prevClicked = lastUsed;
				$("." + prevClicked).hide();

				$("." + clicked_id).show();
				lastUsed = clicked_id;

			}
			CloseDiv()
			function add_Loc() {
				$('#divSection').hide();
				$('.addLocationForm').show();

				$('.selectLocation').hide();
				$('.editPopup').hide();
				$('.delPopup').hide();
				$('.menuPopup').hide();

				$('.save').hide();
				$('.popup').hide();

				$('.locPopup').hide();

			}
			function CloseDiv() {
				$('.selectLocation').hide();
				$('.editPopup').hide();
				$('.delPopup').hide();
				$('.menuPopup').hide();

				$('.save').hide();
				$('.popup').hide();

				$('.addLocationForm').hide();
				$('.addLocationDiv').hide();
				$('.addDirectoryItemsPopup').hide();
				$('.addDirectoryPopup').hide();

				$('.deleteLocation').hide();

			}
			
			
			
		</script>
		<script>
		
		$('#updateAdminDetails').click(function(){
			$('.userExisted').empty();
			$('#updateAdminhref').click();
			var email1 = $('#updateHideEmail').val();
			
			$('#supertext').text('Update User Details');
			$('#updateAdmin').val('Update Admin User');
			var fname = $('#updateFname').val();
	    	var lname = $('#UpdateLname').val();
	    	var uname = $('#updateUname').val();
	    	var email = $('#updateEmail').val();
	    	var phone = $('#updatePhone').val();
	    	$('#updateFnameErr').empty();
	    	$('#updateLnameErr').empty();
	    	$('#updateEmailErr').empty();
	    	$('#updatePhoneErr').empty();
			var user = "${user}";
			var data = {
				"user":user,
				"fname" : fname,
				"lname" : lname,					
				"email" :email,
				"phone":phone
				
			};
			$.ajax({
				      type: "POST",
				      url: "getAdminDetails",
				      async: true,
				      data : data,
				     
				      success :function(results) {			    	  
				    	  
				    	  console.log(results);
				    	  $('#updateHideEmail').val(results[0].objectId);
				    	  $('#updateFname').val(results[0].firstname);
				    	  $('#UpdateLname').val(results[0].lastname);
				    	  $('#updateUname').val(results[0].username);
				    	  $('#updateEmail').val(results[0].email);
				    	  $('#updatePhone').val(results[0].phone);
				    	 
				     },
				     error : function(error) {
				    	 console.log(error);
				    	
				     }
				  });	
			
			
			
			
			
		});
		
		$('#updateAdminUser').click(function(){
			
			var sEmail = $('#updateHideEmail').val();
			var fname = $('#updateFname').val();
			var lname = $('#UpdateLname').val();
			var uname = $('#updateUname').val();
			var email = $('#updateEmail').val();
			var phone = $('#updatePhone').val();
			var result = 0;
			
			if(fname == "" || fname == null)
			{
				$('#updateFnameErr').text('First Name is required');
				result++;
			}
			else
			{
				$('#updateFnameErr').empty();
			}
			
			if(lname == "" || lname == null)
			{
				$('#updateLnameErr').text('Last Name is required');
				result++;
			}
			else
			{
				$('#updateLnameErr').empty();
			}
			
			if(uname == "" || uname == null)
			{
				$('#updateUnameErr').text('User Name is required');
				result++;
			}
			else
			{
				var unameVal = uname.replace(/^\s+|\s+$/g, "");
				var CharArray = unameVal.split(" ");
		        if (CharArray.length >= 2) {
		        	$('#updateUnameErr').text("User Name doesn't allow spaces");
		        	result++;
		        }
		        else {
		        	$('#updateUnameErr').empty();
		        }
			}
			
			var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
			if(email == "" || email == null)
			{
				$('#updateEmailErr').text('E-mail is required');
				result++;
			}
			else if(!(email.match(mailformat)))
			 {
				 
			  $('#updateEmailErr').text('Invalid email format. Please enter in right format');
			   result++;
			 }
			else
			{
				$('#updateEmailErr').empty();
			}
			if(phone == "" || phone == null)
			{
				$('#updatePhoneErr').text('Phone Number is required');
				result++;
			}
			else
			{
				$('#updatePhoneErr').empty();
			}
			
			var data = {
					
					"firstname":fname,
					"lastname":lname,
					"username":uname,
					"email":email,
					"phone":phone,
					"sEmail":sEmail,
					
					
					
			};
			if(result == 0)
			{
				$.ajax({
				      type: "POST",
				      url: "updateAdminUser",
				      async: true,
				      data : data,
				     
				      success :function(results) {
				    	  console.log(results);
				    	  $('#updateAdmin').hide();
				    	  $('#lean-overlay').css({display:'none'});
				    	
				    	
				     },
				     error : function(error) {
				    	 console.log(error);
				    	
				     }
				  });
			}
			
			
			
			
		});
		
		</script>
		
		
		<script type="text/javascript">
		
			$(document).ready(function(){
			 	$("#add11").trigger('click');
			});
			
			function bodyLoad() {
				//$('.container').show();
				//$(".onload").click();

			}
			$(".locAdmin").change(function() {
			       var details = $('option:selected', this).text() ;
			       if(details == "Please Add Location Admin" )
			    	{
			    	   
			    	   $('#locationAdmin').click();
			    	}
					//$('#narshimha').click();
			 });
		</script>
		
		<script>
		
		$('#aiAdmin').click(function(){
			$('#superFirstname').val('');
			$('#superLastname').val('');
			$('#superUsername').val('');
			$('#superPhone').val('');
			$('#superUsername').removeAttr('disabled');
			$('#superEmail').val('');
			$('#saEmail').val('');
			$('#adminType').val('IT Admin');
			$('#supertext').text('Create IT Admin User');
			$('#createSuperAdmin').text('Create IT Admin');
			//$('#createSuperAdmin').show();
			//$('#updateSuperAdmin').hide();
			$('#sfnameErr').empty();
			$('.userExisted').empty();
			$('#slnameErr').empty();
			$('#sunameErr').empty();
			$('#sphoneErr').empty();
			$('#semailErr').empty();
			
			$('#asAdminhref').click();
			
		});
		
		$('#asAdmin').click(function(){
			$('#superFirstname').val('');
			$('#superLastname').val('');
			$('#superUsername').val('');
			$('#superPhone').val('');
			$('#superUsername').removeAttr('disabled');
			$('#superEmail').val('');
			$('#saEmail').val('');
			$('#adminType').val('Super Admin');
			$('#supertext').text('Create Super Admin User');
			$('#createSuperAdmin').text('Create Super Admin');
			$('#createSuperAdmin').show();
			$('#updateSuperAdmin').hide();
			$('#sfnameErr').empty();
			$('.userExisted').empty();
			$('#slnameErr').empty();
			$('#sunameErr').empty();
			$('#superPhone').val('');
			$('#semailErr').empty();
			
			$('#asAdminhref').click();
			
		});
		
		$('#acAdmin').click(function(){
			$('#csFirstname').val('');
			$('#csLastname').val('');
			$('#csUsername').val('');
			$('#csUsername').removeAttr('disabled');
			$('#csEmail').val('');
			$('#csPhone').val('');
			$('#caEmail').val('');
			$('#cstext').text('Create CS Admin User');
			$('#createCSAdmin').text('Create CS Admin');
			$('#createCSAdmin').show();
			$('#updateCSAdmin').hide();
			$('#cfnameErr').empty();
			$('.userExisted').empty();
			$('#clnameErr').empty();
			$('#cunameErr').empty();
			$('#cemailErr').empty();
			$('#cPhoneErr').empty();
			$('#csAdminhref').click();
			
		});
		
		$('#alAdmin').click(function(){
			$('#locationFirstname').val('');
			$('#locationLastname').val('');
			$('#locationUsername').val('');
			$('#locationPhone').val('');
			$('#locationUsername').removeAttr('disabled');
			$('#locationEmail').val('');
			$('#laEmail').val('');
			$('#locationtext').text('Create Location Admin User');
			$('#createLocationAdmin').text('Create Location Admin');
			$('#createLocationAdmin').show();
			$('#updateLocationAdmin').hide();
			$('#lfnameErr').empty();
			$('.userExisted').empty();
			$('#lfnameErr').empty();
			$('#llnameErr').empty();
			$('#lunameErr').empty();
			$('#lemailErr').empty();
			$('#lPhoneErr').empty();
			$('#locationAdmin').click();
			
		});
		
	$('#agroup').click(function(){
		$('#addGroupName').val('');
		$('#addTemplateId').val('');
		$('#groupNameErr').empty();
		$('#groupExistErr').empty();
		$('#groupIdErr').empty();
		
		$('#grouphref').click();
		
	});
	
	$('#ahotel').click(function(){
		$('#hotelName').val('');
		$('#Address1').val('');
		$('#Address2').val('');
		$('#adminId').val('');
		$('#showTemplates').val('');
		$('#Street').val('');
		$('#groupId').val('');
		$('#addLatitude').val('');
		$('#addLongitude').val('');
		$('#showTemplates').show();
		$('#showGroups').hide();
		$('#State').val('');
		$('#zipcode').val('');
		$('.file-path').val('');
		$('#country').val('');
		$('#hotelNameErr').empty();
		$('#hotelExistErr').empty();
		$('#hotelLocationAdminErr').empty();
		$('#hotelTemplateErr').empty();
		$('#hotelAddressErr').empty();
		$('#hotelCityErr').empty();
		$('#hotelStateErr').empty();
		$('#hotelZipcodeErr').empty();
		$('#hotelCountryErr').empty();
		
		$('#hotelhref').click();
		
	});
	
	$('#ctemplate').click(function(){
		$('#templateName').val('');
		$('#templateId').val('');
		$('#templateNameErr').empty();
		$('#templateExistErr').empty();
		$('#templateIdErr').empty();
		
		$('#templatehref').click();
		
	});
	
	
	
	function editUser(user)
	{
		var userName = "${userName}";
		$('.userExisted').empty();
		var userVal = user.split(":");
		var email=userVal[1];
		var searchElement = {
    			"searchId" : email,
    			"userName" : userName
    	};
		$('.userSpin').show();
		$.ajax({
		      type: "POST",
		      url: "searchUsers",
		      async: true,
		      data : searchElement,
		     
		      success :function(result) {
		    	  console.log(result);
		    	  for(i=0;i<result.length;i++)
		    	  {
		    		  if(result[i].user == "it admin")
		    		  {
		    			  $('#modal4').hide();
		    			  $('.lean-overlay').css({display:'none'});
		    			  $('#asAdminhref').click();
		    			  $('.userSpin').hide();
		    			  $('#supertext').text('Update IT Admin User');
		    			  //$('#updateSuperAdmin').show();
		    			 // $('#createSuperAdmin').hide();
		    			 $('#createSuperAdmin').text('Update IT Admin');
		    			  $('#saEmail').val(result[i].objectId);
		    			  $('#superFirstname').val(result[i].firstname);
		    			  $('#superLastname').val(result[i].lastname);
		    			  $('#superUsername').val(result[i].username);
		    			  $('#superUsername').attr('disabled',true);
		    			  $('#superEmail').val(result[i].email);
		    			  $('#superPhone').val(result[i].phone);
		    		  }
		    		  else if(result[i].user == "super admin")
		    		  {		
		    			  $('#modal4').hide();
		    			  $('.lean-overlay').css({display:'none'});
		    			  $('#asAdminhref').click();
		    			  $('.userSpin').hide();
		    			  $('#supertext').text('Update Super Admin User');
		    			  //$('#updateSuperAdmin').show();
		    			 // $('#createSuperAdmin').hide();
		    			 $('#createSuperAdmin').text('Update Super Admin');
		    			  $('#saEmail').val(result[i].objectId);
		    			  $('#superFirstname').val(result[i].firstname);
		    			  $('#superLastname').val(result[i].lastname);
		    			  $('#superUsername').val(result[i].username);
		    			  $('#superUsername').attr('disabled',true);
		    			  $('#superEmail').val(result[i].email);
		    			  $('#superPhone').val(result[i].phone);
		    		  }
		    		  else if(result[i].user == "cs admin")
		    		  {
		    			  $('#modal4').hide();
		    			  $('.lean-overlay').css({display:'none'});
		    			  $('#csAdminhref').click();
		    			  $('.userSpin').hide();
		    			  $('#cstext').text('Update CS Admin User');
		    			 // $('#createCSAdmin').hide();
		    			  //$('#updateCSAdmin').show();
		    			  $('#createCSAdmin').text('Update CS Admin');
		    			  $('#caEmail').val(result[i].objectId);
		    			  $('#csFirstname').val(result[i].firstname);
		    			  $('#csLastname').val(result[i].lastname);
		    			  $('#csUsername').val(result[i].username);
		    			  $('#csUsername').attr('disabled',true);
		    			  $('#csEmail').val(result[i].email);
		    			  $('#csPhone').val(result[i].phone);
		    		  }
		    		  else
		    		  {
		    			  $('#modal4').hide();
		    			  $('.lean-overlay').css({display:'none'});
		    			  $('#locationAdmin').click();
		    			  $('.userSpin').hide();
		    			  $('#locationtext').text('Update Location Admin User');
		    			 // $('#createLocationAdmin').hide();
		    			 // $('#updateLocationAdmin').show();
		    			 $('#createLocationAdmin').text('Update Location Admin');
		    			  $('#laEmail').val(result[i].objectId);
		    			  $('#locationFirstname').val(result[i].firstname);
		    			  $('#locationLastname').val(result[i].lastname);
		    			  $('#locationUsername').val(result[i].username);
		    			  $('#locationUsername').attr('disabled',true);
		    			  $('#locationEmail').val(result[i].email);
		    			  $('#locationPhone').val(result[i].phone);
		    		  }
		    	  }
		    	  	
			     },
			  error : function(error) {
			    	console.log(error);
			     }
		  });					
	}
	
	function deleteUser(userId)
	{
		
		var userVal = userId.split(":");
		var objId = userVal[1];
		$('.userSpin').show();
		
		
		var searchElement = {
    			"searchId" : objId			    			
    	};
		//$(".deletebody").append("<div style='margin:0 0 0 30%' class='preloader-wrapper small active'><div class='spinner-layer spinner-green-only'><div class='circle-clipper left'><div class='circle></div></div><div class='gap-patch'><div class='circle'></div></div><div class='circle-clipper right'><div class='circle'></div></div></div></div>");
		$.ajax({
		      type: "POST",
		      url: "deleteUser",
		      async: true,
		      data : searchElement,
		      
		      success :function(result) {
		    	  if( result == "nolocations" )
		    	  {
		    		  $('#modal4').hide();
		    		  $('#lean-overlay').css({display:'none'});
		    		  $('.userSpin').hide();
		    		  $('#deleteAdmin').click();
					  $('#deleteUserId').val(objId);					    		  
		    	  }
		    	  else
		    	  {
		    		  $('#modal4').hide();
		    		  $('.userSpin').hide();
		    		  $('#lean-overlay').css({display:'none'});
		    		  $('#deleteNotConfirmationAdmin').click();
		    	  }
		    	     	  
		     },
		     error : function(error) {
		    	console.log(error);
		     }
		  });
		
		
		
		
	}
	
	$('#deleteAdminDetails').click(function(){
		
		var userId = $('#deleteUserId').val();
		var searchElement = {
    			"searchId" : userId			    			
    	};
		
		$(".deleteConfirmBody").append("<div style='margin:0 0 0 30%' class='preloader-wrapper small active'><div class='spinner-layer spinner-green-only'><div class='circle-clipper left'><div class='circle></div></div><div class='gap-patch'><div class='circle'></div></div><div class='circle-clipper right'><div class='circle'></div></div></div></div>");
		$.ajax({
		      type: "POST",
		      url: "confirmDeleteUser",
		      async: true,
		      data : searchElement,
		      
		      success :function(result) {	
		    	  $('.deleteConfirmBody').hide();
		    	  $('#modal5').hide();
	    		  $('#lean-overlay').css({display:'none'});
		     },
		     error : function(error) {
		    	console.log(error);
		     }
		  });
		
		
	});
			
		function submitform(){
			var templateResult = 0;
			var name = $('#templateName').val();
			var id = $('#templateId').val();
			if(name == "" || name == null)
			{
				$('#templateNameErr').text("Template Name is required");
				$('#templateExistErr').empty();
				templateResult++;
			}
			else
			{
				$('#templateNameErr').empty();				
			}
			if(id == "" || id == null)
			{
				$('#templateIdErr').text("Please select template from the list");
				templateResult++;
			}
			else
			{
				$('#templateIdErr').empty();
				
			}
			
			
			
			if(templateResult == 0)
			{
				$(".tspin").show();
				var data = {
						"templateName" : name					
					};
					
					$.ajax({
					      type: "POST",
					      url: "verifyTemplate",
					      async: true,
					      data : data,
					     
					      success :function(results) {
					    	  if(results == "noduplicate")
					    	  {
					    		  $('#addNewTemplate').attr('disabled','disabled');
					    		  $('#addNewTemplate').attr('action','');
					    		  $('.tspin').show();
					    		  $("#templateExistErr").empty();
					    		  document.addTemplate.submit();
					    		  templateResult = 0;
					    	  }
					    	  else
					    	  {
					    		  $('#templateNameErr').empty();
					    		  $("#templateExistErr").text("This Template is already registered");
					    		 
					    		  $('.tspin').hide();
					    		  templateResult++;
					    	  }
					    	  
					    	  console.log(results);
					    	 
					     },
					     error : function(error) {
					    	 console.log(error);
					    	
					     }
					  });			
				
			} 
			 
		}	
		
		
				
		function groupSubmitform()
		{
			var groupResult = 0;
			var name = $('#addGroupName').val();
			var id = $('#addTemplateId').val();
			if(name == "" || name == null)
			{
				$('#groupNameErr').text("Group Name is required");
				groupResult++;
			}
			else
			{
				$('#groupNameErr').empty();     				
			}
			if(id == "" || id == null)
			{
				$('#groupIdErr').text("Please select template from the list");
				groupResult++;
			}
			else
			{
				$('#groupIdErr').empty();
				
			} 
			
			
			if(groupResult == 0)
			{
				
				$(".gspin").show();
				$.ajax({
				      type: "POST",
				      url: "verifyGroup",
				      async: true,
				      data : {"groupName":name},
				     
				      success :function(results) {
				    	  if(results == "duplicate")
				    	  {
				    		  $("#groupExistErr").text("This group is already registered");
				    		  $('#groupNameErr').empty();
				    		  $('.gspin').hide();
				    		  groupResult++;
				    	  }
				    	  else
				          {
				    		  $('#addNewGroup').attr('disabled','disabled');
				    		  $('#addNewGroup').attr('action','');
				    		  $("#groupExistErr").empty();
				    		  $('.gspin').show();
				    		 document.addGroup.submit();				    		  
				    		  groupResult = 0;  
				          }
				    	 
				     },
				     error : function(error) {
				    	 console.log(error);
				    	
				     }
				  });
				
				
			}
		}
		
		function Validate(txt) {
            txt.value = txt.value.replace(/[^a-zA-Z 0-9\n\r]+/g, '');
        }
		
		/* $('#zipcode').keydown(function (e) {
			if (e.shiftKey || e.ctrlKey || e.altKey) {
			e.preventDefault();
			} else {
			var key = e.keyCode;
			if (!((key == 8) || (key == 32) || (key == 46) || (key >= 35 && key <= 40) || (key >= 65 && key <= 90) || (key >= 48 && key <= 57) || (key >= 96 && key <= 105))) {
			e.preventDefault();
			}
			}
		}); */
		
		
		function hotelSubmitform()
		{
			var hotelResult = 0;
			var hName = $('#hotelName').val();
			var groupId = $('#groupObjectId').val();
			var hAddress1 = $('#Address1').val();
			var locId = $('#adminId').val();
			var tempId = $('#showTemplates').val();
			var hCity = $('#Street').val();
			var hState = $('#State').val();
			var hZipcode = $('#zipcode').val();
			var hCountry = $('#country').val();
			var latitude = $('#addLatitude').val();
			var longitude = $('#addLongitude').val();
			
			if(latitude != "" && latitude != null)
			{
				if(longitude == "" || longitude == null)
				{
					alert("Enter Longitude Value");
					hotelResult++;
				}	
				else
				{
					if( parseFloat(longitude).toFixed(2) <= -180 ||  parseFloat(longitude).toFixed(2) >= 180)
					{
						alert("Longitude value must between -180 to 180");
						hotelResult++;
					}
					
				}
			}
			if(longitude != "" && longitude != null)
			{
				if(latitude == "" || latitude == null)
				{
					alert("Enter Latitude Value");
					hotelResult++;
				}	
				else
				{
					if( parseFloat(latitude).toFixed(2) <= -90 ||  parseFloat(latitude).toFixed(2) >= 90)
					{
						alert("Langtude value must between -90 to 90");
						hotelResult++;
					}
				}
			}
			else
			{				
				console.log("not required");				
			}
			
			if(document.getElementById('checkBox').checked) {
				$('#hotelGroupErr').empty();
				$('#hotelTemplateErr').empty();
				if(groupId == "" || groupId == null)
				{
					$('#hotelGroupErr').text("Please select Group from the list");
					hotelResult++;
				}
				else
				{
					$('#hotelTemplateErr').empty();				
					
				} 
			    
			} else {
				
				$('#hotelGroupErr').empty();
				$('#hotelTemplateErr').empty();
				if(tempId == "" || tempId == null)
				{
					$('#hotelTemplateErr').text("Please select template from the list");
					hotelResult++;
				}
				else
				{
					$('#hotelTemplateErr').empty();				
					
				} 
				
			}
			
			if(hName == "" || hName == null)
			{
				$('#hotelNameErr').text("Hotel Name is required");
				hotelResult++;			
			}
			else
			{
				$('#hotelNameErr').empty();
				
				
			}
			
			/* if(hAddress1 == "" || hAddress1 == null)
			{
				$('#hotelAddressErr').text("Address is required");
				hotelResult++;
			}
			else
			{
				$('#hotelAddressErr').empty();				
				
			} */
			
			if(locId == "" || locId == null)
			{
				$('#hotelLocationAdminErr').text("Please select Location Admin from the list");
				hotelResult++;
			}
			else
			{
				$('#hotelLocationAdminErr').empty();				
				
			}
						
					
			/* if(hCity == "" || hCity == null)
			{
				$('#hotelCityErr').text("City is required");
				hotelResult++;
			}
			else
			{
				$('#hotelCityErr').empty();				
				
				
			}
			
			if(hState == "" || hState == null)
			{
				$('#hotelStateErr').text("State is required");
				hotelResult++;
			}
			else
			{
				$('#hotelStateErr').empty();
				
			}
			
			if(hZipcode == "" || hZipcode == null)
			{
				$('#hotelZipcodeErr').text("Zipcode is required");
				hotelResult++;
			}
			else
			{
				$('#hotelZipcodeErr').empty();				
			}
			
			if(hCountry == "" || hCountry == null)
			{
				$('#hotelCountryErr').text("Country is required");
				hotelResult++;
			}
			else
			{
				$('#hotelCountryErr').empty();			
			} */
			
			
			
			if(hotelResult == 0)
			{
				$(".hspin").show();
				$.ajax({
				      type: "POST",
				      url: "verifyHotel",
				      async: true,
				      data : {"hotelName":hName},
				     
				      success :function(results) {
				    	  if(results == "duplicate")
				    	  {
				    		  $('#hotelNameErr').empty();
				    		  $("#hotelExistErr").text("This hotel is already registered");
				    		  $('.hspin').hide();
				    		  hotelResult++;
				    	  }
				    	  else
				          {
				    		  $('#addNewHotel').attr('disabled','disabled');
				    		  $('#addNewHotel').attr('action','');
				    		  $("#hotelExistErr").empty();	
				    		  $(".hspin").show();
				    		  document.addLocation.submit();
				    		  
				    		  hotelResult = 0;  
				          }
				    	 
				     },
				     error : function(error) {
				    	 console.log(error);
				    	
				     }
				  });
			} 
		}
		
			
		
			$('#createSuperAdmin').click(function(){
				
				$('.userExisted').empty();
				var result = 0;
				var fname = $('#superFirstname').val();
				var lname = $('#superLastname').val();
				var uname = $('#superUsername').val();
				var email = $('#superEmail').val();
				var sEmail = $('#saEmail').val();
				var phone = $('#superPhone').val();
				var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
				
				if(fname == "" || fname == null)
				{
					$('#sfnameErr').text('First Name is required');
					result++;
				}
				else
				{
					$('#sfnameErr').empty();
				}
				
				if(lname == "" || lname == null)
				{
					$('#slnameErr').text('Last Name is required');
					result++;
				}
				else
				{
					$('#slnameErr').empty();
				}
				
				if(uname == "" || uname == null)
				{
					$('#sunameErr').text('User Name is required');
					result++;
				}
				else
				{
					var unameVal = uname.replace(/^\s+|\s+$/g, "");
					var CharArray = unameVal.split(" ");
			        if (CharArray.length >= 2) {
			        	$('#sunameErr').text("User Name doesn't allow spaces");
			        	result++;
			            
			        }else if(uname.match(mailformat))
			        {
			        	$('#sunameErr').text("User Name doesn't allow email address");
			        	result++;
			        }
			        else {
			        	$('#sunameErr').empty();
			        }
				}
				
				
				if(email == "" || email == null)
				{
					$('#semailErr').text('E-mail is required');
					result++;
				}
				else if(!(email.match(mailformat)))
				 {
					 
				  $('#semailErr').text('Invalid email format. Please enter in right format');
				   result++;
				 }
				else
				{
					$('#semailErr').empty();
				}
				
				if(phone == "" || phone == null)
				{
					$('#sphoneErr').text('Phone Number is required');
					result++;
				}
				else
				{
					$('#sphoneErr').empty();		        
				}
				
				if(result == 0)
				{
					var data = {
							
							"firstname":fname,
							"lastname":lname,
							"username":uname,
							"email":email,
							"phone":phone,
							"sEmail":sEmail,
							"user": $('#user').val(),
							"userName": $('#userName').val(),
							"userType":$('#adminType').val()
							
							
					};
					
					 $(".sbody").append("<div style='margin:-55% 46%' class='preloader-wrapper small active'><div class='spinner-layer spinner-green-only'><div class='circle-clipper left'><div class='circle></div></div><div class='gap-patch'><div class='circle'></div></div><div class='circle-clipper right'><div class='circle'></div></div></div></div>");
					 
					$.ajax({
					      type: "POST",
					      url: "registerSuperAdmin",
					      async: true,
					      data : data,
					     
					      success :function(results) {
					    	  console.log(results);
					    	  if(results == "userExisted")
						    	{
						    		$('.userExisted').text("This username is already taken");						    						    		
						    		$('.sbody > :last-child').remove();
						    		
						    	}
						    	else if(results == "emailExisted")
						    	{
						    		$('.userExisted').text("This email is already existing in the system. Same email id is not allowed for multiple users.");
						    		$('.sbody > :last-child').remove();
						    		
						    	}
						    	else if(results == "userUpdated")
						    	{
						    		$('.userExisted').text("Successfully updated admin details.");
						    		$('.userExisted').css("color","green");
						    		$('.sbody > :last-child').remove();
						    	}
						    	else
						    	{
						    		$('#superAdmin').hide();
							    	$('.sbody > :last-child').remove();
							    	$('.lean-overlay').css({display:'none'});
							    	$('#narshimha').click();
							    	$('#userType').text($('#adminType').val());
							    	$('#superFirstname').val('');
							    	$('#superLastname').val('');
							    	$('#superUsername').val('');
							    	$('#superEmail').val('');
							    	$('#superPhone').val('');
						    	}
					    	
					    	
					     },
					     error : function(error) {
					    	 console.log(error);
					    	$('#superAdmin').hide();
					    	$('.sbody > :last-child').remove();
					    	$('.lean-overlay').css({display:'none'});
					    	$('#superFirstname').val('');
					    	$('#superLastname').val('');
					    	$('#superUsername').val('');
					    	$('#superEmail').val('');
					    	$('#superPhone').val('');
					     }
					  });
				}
				
				
				
			});
			
			
			
			$('#createCSAdmin').click(function(){
				$('.userExisted').empty();
				var result = 0;
				var fname = $('#csFirstname').val();
				var lname = $('#csLastname').val();
				var uname = $('#csUsername').val();
				var email = $('#csEmail').val();
				var phone = $('#csPhone').val();
				var cEmail = $('#caEmail').val();
				var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
				
				if(fname == "" || fname == null)
				{
					$('#cfnameErr').text('First Name is required');
					result++;
				}
				else
				{
					$('#cfnameErr').empty();
				}
				
				if(lname == "" || lname == null)
				{
					$('#clnameErr').text('Last Name is required');
					result++;
				}
				else
				{
					$('#clnameErr').empty();
				}
				
				if(uname == "" || uname == null)
				{
					$('#cunameErr').text('User Name is required');
					result++;
				}
				else
				{
					var unameVal = uname.replace(/^\s+|\s+$/g, "");
					var CharArray = unameVal.split(" ");
			        if (CharArray.length >= 2) {
			        	$('#cunameErr').text("User Name doesn't allow spaces");
			        	result++;
			        }else if(uname.match(mailformat))
			        {
			        	$('#cunameErr').text("User Name doesn't allow email address");
			        	result++;
			        }
			        else {
			        	$('#cunameErr').empty();
			        }
				}
				
				
				if(email == "" || email == null)
				{
					$('#cemailErr').text('E-mail is required');
					result++;
				}
				else if(!(email.match(mailformat)))
				 {
					 
				  $('#cemailErr').text('Invalid email format. Please enter in right format');
				   result++;
				 }
				else
				{
					$('#cemailErr').empty();
				}
				if(phone == "" || phone == null)
				{
					$('#cPhoneErr').text('Phone Number is required');
					result++;
				}
				else
				{
					$('#cPhoneErr').empty();
				}
				
				if(result == 0)
				{
					var data = {
							
							"firstname":fname,
							"lastname":lname,
							"username":uname,
							"email":email,
							"phone":phone,
							"sEmail":cEmail,
							"user": $('#user').val(),
							"userName": $('#userName').val()
							
							
					};
					$(".csbody").append("<div style='margin:-55% 46%' class='preloader-wrapper small active'><div class='spinner-layer spinner-green-only'><div class='circle-clipper left'><div class='circle></div></div><div class='gap-patch'><div class='circle'></div></div><div class='circle-clipper right'><div class='circle'></div></div></div></div>");
					$.ajax({
					      type: "POST",
					      url: "registerCSAdmin",
					      async: true,
					      data : data,
					     
					      success :function(results) {
					    	  
					    	  console.log(results);
					    	  
					    	  if(results == "userExisted")
						    	{
						    		$('.userExisted').text("This username is already taken");
						    		$('.csbody > :last-child').remove();
						    		
						    	}
						    	else if(results == "emailExisted")
						    	{
						    		$('.userExisted').text("This email is already existing in the system. Same email id is not allowed for multiple users.");
						    		$('.csbody > :last-child').remove();
						    		
						    	}
						    	else if(results == "userUpdated")
						    	{
						    		$('.userExisted').text("Successfully updated admin details.");
						    		$('.userExisted').css("color","green");
						    		$('.csbody > :last-child').remove();
						    	}
					    	else
					    	{
					    		$('#csAdmin').hide();
						    	$('.csbody > :last-child').remove();
						    	$('.lean-overlay').css({display:'none'});
						    	$('#narshimha').click();
						    	$('#userType').text("CS Admin");
						    	$('#csFirstname').val('');
						    	$('#csLastname').val('');
						    	$('#csUsername').val('');
						    	$('#csEmail').val('');
						    	$('#csPhone').val('');
					    	}
					    	
					     },
					     error : function(error) {
					    	 $('#csAdmin').hide();
					    	 $('.csbody > :last-child').remove();
						    	$('.lean-overlay').css({display:'none'});
						    	
						    	$('#csFirstname').val('');
						    	$('#csLastname').val('');
						    	$('#csUsername').val('');
						    	$('#csEmail').val('');
						    	$('#csPhone').val('');
					     }
					  });
				}
				
				
			});
			
			
			
			$('#createLocationAdmin').click(function(){
				
				var result = 0;
				$('.userExisted').empty();
				var fname = $('#locationFirstname').val();
				var lname = $('#locationLastname').val();
				var uname = $('#locationUsername').val();
				var email = $('#locationEmail').val();
				var phone = $('#locationPhone').val();
				var lEmail = $('#laEmail').val();
				var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
				
				if(fname == "" || fname == null)
				{
					$('#lfnameErr').text('First Name is required');
					result++;
				}
				else
				{
					$('#lfnameErr').empty();
				}
				
				if(lname == "" || lname == null)
				{
					$('#llnameErr').text('Last Name is required');
					result++;
				}
				else
				{
					$('#llnameErr').empty();
				}
				
				if(uname == "" || uname == null)
				{
					$('#lunameErr').text('User Name is required');
					result++;
				}
				else
				{
					var unameVal = uname.replace(/^\s+|\s+$/g, "");
					var CharArray = unameVal.split(" ");
			        if (CharArray.length >= 2) {
			        	$('#lunameErr').text("User Name doesn't allow spaces");
			        	result++;
			        }else if(uname.match(mailformat))
			        {
			        	$('#lunameErr').text("User Name doesn't allow email address");
			        	result++;
			        }
			        else {
			        	$('#lunameErr').empty();
			        }
				}
				
				
				if(email == "" || email == null)
				{
					$('#lemailErr').text('E-mail is required');
					result++;
				}
				else if(!(email.match(mailformat)))
				 {
					 
				  $('#lemailErr').text('Invalid email format. Please enter in right format');
				   result++;
				 }
				else
				{
					$('#lemailErr').empty();
				}
				
				if(phone == "" || phone == null)
				{
					$('#lPhoneErr').text('Phone Number is required');
					result++;
				}
				else
				{
					$('#lPhoneErr').empty();
				}
				
				if(result == 0)
				{
					var data = {
							
							"firstname":fname,
							"lastname":lname,
							"username":uname,
							"email":email,
							"phone":phone,
							"sEmail":lEmail,
							"user": $('#user').val(),
							"userName": $('#userName').val()
							
							
					};
					$(".lsbody").append("<div style='margin:-55% 46%' class='preloader-wrapper small active'><div class='spinner-layer spinner-green-only'><div class='circle-clipper left'><div class='circle></div></div><div class='gap-patch'><div class='circle'></div></div><div class='circle-clipper right'><div class='circle'></div></div></div></div>");
					$.ajax({
					      type: "POST",
					      url: "registerLocationAdmin",
					      async: true,
					      data : data,
					     
					      success :function(results) {
					    	  console.log(results);
					    	if(results == "userExisted")
					    	{
					    		$('.userExisted').text("This username is already taken");
					    		$('.lsbody > :last-child').remove();
					    		
					    	}
					    	else if(results == "emailExisted")
					    	{
					    		$('.userExisted').text("This email is already existing in the system. Same email id is not allowed for multiple users.");
					    		$('.lsbody > :last-child').remove();
					    		
					    	}
					    	else if(results == "userUpdated")
					    	{
					    		$('.userExisted').text("Successfully updated admin details.");
					    		$('.userExisted').css("color","green");
					    		$('.lsbody > :last-child').remove();
					    	}
					    	else
					    	{
					    		$('.locationAdmin').hide();	
						    	$('.lsbody > :last-child').remove();
						    	$('.lean-overlay').css({display:'none'});
						    	$('#narshimha').click();
						    	$('#userType').text("Location Admin");
						    	var a ="<option value='"+results+"'>"+$('#locationUsername').val()+" - "+$('#locationFirstname').val()+" "+$('#locationLastname').val()+"  </option>";
								  $('#l2').html(a);
						    	$('#locationFirstname').val('');
						    	$('#locationLastname').val('');
						    	$('#locationUsername').val('');
						    	$('#locationEmail').val('');
						    	$('#locationPhone').val('');
					    	}
					    	
					     },
					     error : function(error) {
					    	 console.log(error);
					    	 $('.locationAdmin').hide();
					    	 $('.lsbody > :last-child').remove();
						    	$('.lean-overlay').css({display:'none'});
						    	
						    	$('#locationFirstname').val('');
						    	$('#locationLastname').val('');
						    	$('#locationUsername').val('');
						    	$('#locationEmail').val('');
						    	$('#locationPhone').val('');
					     }
					  });
				}
				
				
				
			});
			function Check() {
		    	
		    	$('#l1').hide();
		        var chkPassport = document.getElementById("checkBox");
		        if (chkPassport.checked) {
		            
		        	$('#showGroups').show();
	            	//$("#showTemplates").prop("disabled", true);
	            	$("#showTemplates").hide();
		        	
		        } else {
		        	$('#l1').show();
		        	$('#showGroups').hide();
	            	//$("#showTemplates").prop("disabled", false);
	            	$("#showTemplates").show();
		        	
		        }
		    }
			$('#showTemplates').on('change', function() {
				  
				  var a ="<span onclick='preview_Hotel_click(this)' class='"+this.value+"' style='cursor:pointer;font-size:15px;color:#00bcd4;text-decoration:underline'>Preview</span>";
				  $('#l1').html(a);
				});
		</script>
		<script type="text/javascript">
		
				$('.skipSelection').click(function(){
					
						$('.search').val('');   	
				    	var searchElement = {
				    			"searchId" : "",
				    			"username" : "null"
				    	};
				    	
				    	$('.mbody').show();
				    	
				    	
				    	$.ajax({
						      type: "POST",
						      url: "searchHotels",
						      async: true,
						      data : searchElement,
						     
						      success :function(result) {
						    	  $(".searchResults").empty();
						    	  
						    	  console.log(result.length);
						    	  if(result.length == 0)
						    	  {					    		  
						    		  $('.noResults').text('Search results not found');
						    		  $('.mbody').hide();
						    	  }
						    	  else
						    	  {
						    		  $('.noResults').empty();
						    		  $('.tbody').remove();
							    	  var tableDetails = "<tr>"+
										"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>Hotel Name</b></td>"+
										"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>Hotel Id</b></td>"+
										"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>Group Site ID</b></td>"+
										"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>Zip/Postal Code</b></td>"+
										"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>Group Name</b></td>"+
										"<td style='padding:10px 0;text-align:center'><b style='color:#337ab7;font-size:18px'>Hotel Admin</b></td>"+
										"<td style='padding:10px 0;text-align:center'><b style='color:#337ab7;font-size:18px'>Email</b></td>"+
										"</tr>";
							    	  for(var i=0;i<result.length;i++)
							    	  {
							    		  if(result[i].groupName == null)
							    		  {
							    			  result[i].groupName = "";
							    		  }
							    		  if(result[i].adminName == null)
							    		  {
							    			  result[i].adminName = "";
							    		  }
							    		  if(result[i].email == null)
							    		  {
							    			  result[i].email = "";
							    		  }
							    		  var table = "<tr>"+
												"<td style='padding:10px 0;text-align:center;'> <a style='color:#337ab7' onclick='loading()' href='select?user=${user}&amp;userName=${userName}&amp;locId="+result[i].hotelId+"'>"+
												""+result[i].name+""+
												"</a>"+
												"</td>"+
												"<td style='padding:10px 0;text-align:center;'> <a onclick='loading()' href='select?user=${user}&amp;userName=${userName}&amp;locId="+result[i].hotelId+"' style='color:#337ab7'>"+
												""+result[i].hotelId+""+
												"</a>"+
												"</td>"+
												"<td style='padding:10px 0;text-align:center;'> <a onclick='loading()' href='select?user=${user}&amp;userName=${userName}&amp;locId="+result[i].hotelId+"' style='color:#337ab7'>"+
												""+result[i].groupId+""+
												"</a>"+
												"</td>"+
												"<td style='padding:10px 0;text-align:center;'> <a onclick='loading()' href='select?user=${user}&amp;userName=${userName}&amp;locId="+result[i].hotelId+"' style='color:#337ab7'>"+
												""+result[i].zipcode+""+
												"</a>"+
												"</td>"+
												"<td style='padding:10px 0;text-align:center;'> <a onclick='loading()' href='select?user=${user}&amp;userName=${userName}&amp;locId="+result[i].hotelId+"' style='color:#337ab7'>"+
												""+result[i].groupName+""+
												"</a>"+
												"</td>"+
												"<td style='padding:10px 0;text-align:center'> <a onclick='loading()' href='select?user=${user}&amp;userName=${userName}&amp;locId="+result[i].hotelId+"' style='color:#337ab7'>"+
												""+result[i].adminName+""+
												"</a>"+
												"</td>"+
												"<td style='padding:10px 0;text-align:center'> <a onclick='loading()' href='select?user=${user}&amp;userName=${userName}&amp;locId="+result[i].hotelId+"' style='color:#337ab7'>"+
												""+result[i].email+""+
												"</a>"+
												"</td>"+
											"</tr>";
							    		  tableDetails = tableDetails+table;
							    		  
							    	  }
							    	  console.log(tableDetails);
							    	  $(".searchResults").append("<tbody style='font-size:14px'>"+tableDetails+"</tbody>");
							    	  $('.mbody').hide();
						    	  }
						    	 
						    	  
						     },
						     error : function(error) {
						    	console.log(error);
						     }
						  });
				   
				    
				});
				
				function loading()
				{
					$('.mbody').show();
				}
				
				function templateLoading()
				  {
					  $('.templateSpin').show();
				  }
				  function groupLoading()
				  {
					  $('.groupSpin').show();
				  }
				
				
				$('.search').keyup(function(e){
					
					if(e.keyCode == 13)
				    {	    	
				    	var searchElement = {
				    			"searchId" : $(this).val(),
				    			"username" : "null"
				    	};
				    	
				    	$('.mbody').show();
				    	
				    	
				    	$.ajax({
						      type: "POST",
						      url: "searchHotels",
						      async: true,
						      data : searchElement,
						     
						      success :function(result) {
						    	  $(".searchResults").empty();
						    	  
						    	  console.log(result.length);
						    	  if(result.length == 0)
						    	  {					    		  
						    		  $('.noResults').text('Search results not found');
						    		  $('.mbody').hide();
						    	  }
						    	  else
						    	  {
						    		  $('.noResults').empty();
						    		  $('.tbody').remove();
							    	  var tableDetails = "<tr>"+
										"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>Hotel Name</b></td>"+
										"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>Hotel Id</b></td>"+
										"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>Group Site ID</b></td>"+
										"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>Zip/Postal Code</b></td>"+
										"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>Group Name</b></td>"+
										"<td style='padding:10px 0;text-align:center'><b style='color:#337ab7;font-size:18px'>Hotel Admin</b></td>"+
										"<td style='padding:10px 0;text-align:center'><b style='color:#337ab7;font-size:18px'>Email</b></td>"+
										
										"</tr>";
							    	  for(var i=0;i<result.length;i++)
							    	  {
							    		  if(result[i].groupName == null)
							    		  {
							    			  result[i].groupName = "";
							    		  }
							    		  if(result[i].adminName == null)
							    		  {
							    			  result[i].adminName = "";
							    		  }
							    		  if(result[i].email == null)
							    		  {
							    			  result[i].email = "";
							    		  }
							    		  var table = "<tr>"+
												"<td style='padding:10px 0px;text-align:center;'> <a style='color:#337ab7' onclick='loading()' href='select?user=${user}&amp;userName=${userName}&amp;locId="+result[i].hotelId+"'>"+
												""+result[i].name+""+
												"</a>"+
												"</td>"+
												"<td style='padding:10px 0;text-align:center;'> <a onclick='loading()' href='select?user=${user}&amp;userName=${userName}&amp;locId="+result[i].hotelId+"' style='color:#337ab7'>"+
												""+result[i].hotelId+""+
												"</a>"+
												"</td>"+
												"<td style='padding:10px 0;text-align:center;'> <a onclick='loading()' href='select?user=${user}&amp;userName=${userName}&amp;locId="+result[i].hotelId+"' style='color:#337ab7'>"+
												""+result[i].groupId+""+
												"</a>"+
												"</td>"+
												"<td style='padding:10px 0;text-align:center;'> <a onclick='loading()' href='select?user=${user}&amp;userName=${userName}&amp;locId="+result[i].hotelId+"' style='color:#337ab7'>"+
												""+result[i].zipcode+""+
												"</a>"+
												"</td>"+
												"<td style='padding:10px 0;text-align:center;'> <a onclick='loading()' href='select?user=${user}&amp;userName=${userName}&amp;locId="+result[i].hotelId+"' style='color:#337ab7'>"+
												""+result[i].groupName+""+
												"</a>"+
												"</td>"+
												"<td style='padding:10px 0;text-align:center'> <a onclick='loading()' href='select?user=${user}&amp;userName=${userName}&amp;locId="+result[i].hotelId+"' style='color:#337ab7'>"+
												""+result[i].adminName+""+
												"</a>"+
												"</td>"+
												"<td style='padding:10px 0;text-align:center'> <a onclick='loading()' href='select?user=${user}&amp;userName=${userName}&amp;locId="+result[i].hotelId+"' style='color:#337ab7'>"+
												""+result[i].email+""+
												"</a>"+
												"</td>"+
											"</tr>";
							    		  tableDetails = tableDetails+table;
							    		  
							    	  }
							    	  console.log(tableDetails);
							    	  $(".searchResults").append("<tbody style='font-size:14px'>"+tableDetails+"</tbody>");
							    	  $('.mbody').hide();
						    	  }
						    	 
						    	  
						     },
						     error : function(error) {
						    	console.log(error);
						     }
						  });
				    }
				    
				});
			
		
		</script>
		<script>
		$('#userSearch').keyup(function(e){
			
			var userName = "${userName}";
			
			if(e.keyCode == 13)
		    {	    	
		    	var searchElement = {
		    			"searchId" : $(this).val(),
		    			"userName" : userName
		    	};
		    	
		    	$('.userSpin').show();
		    	
		    	
		    	$.ajax({
				      type: "POST",
				      url: "searchUsers",
				      async: true,
				      data : searchElement,
				     
				      success :function(result) {
				    	  $("#userSearchResults").empty();
				    	  
				    	  console.log(result.length);
				    	  if(result.length == 0)
				    	  {					    		  
				    		  $('#noUserResults').text('Search results not found');
				    		  $('.userSpin').hide();
				    	  }
				    	  else
				    	  {
				    		  $('#noUserResults').empty();
				    		  $('#userbody').remove();
				    		  $('.userSpin').hide();
					    	  var tableDetails = "<td style='padding:10px 0p;text-align:center;''><b style='color:#337ab7;font-size:18px'>User Name</b></td>"+
								"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>First Name</b></td>"+
								"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>Last Name</b></td>"+
								"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>Email</b></td>"+
								"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>Phone Number</b></td>"+
								"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>Role</b></td>"+
								"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>Actions</b></td>"+
								"</tr>";
					    	  for(var i=0;i<result.length;i++)
					    	  {
					    		  if(result[i].phone == null)
					    		  {
					    			  result[i].phone = "";
					    		  }
					    		  var table = "<tr>"+
										"<td style='padding:10px 0;text-align:center;''> <a style='color:#337ab7' href='#'>"+											
										""+result[i].username+"</a>"+
										"</td>"+
										"<td style='padding:10px 0;text-align:center;'> <a  href='#' style='color:#337ab7'>"+										
										""+result[i].firstname+"</a>"+
										"</td>"+
										"<td style='padding:10px 0;text-align:center;'> <a  href='#' style='color:#337ab7'>"+											
										""+result[i].lastname+"</a>"+
										"</td>"+
										"<td style='padding:10px 0;text-align:center;''> <a style='color:#337ab7' href='#'>"+											
										""+result[i].email+"</a>"+
										"</td>"+
										"<td style='padding:10px 0;text-align:center;''> <a style='color:#337ab7' href='#'>"+											
										""+result[i].phone+"</a>"+
										"</td>"+
										"<td style='padding:10px 0;text-align:center;'> <a  href='#' style='color:#337ab7'>"+											
										""+result[i].user+"</a>"+
										"</td>"+
										"<td style='padding:10px 0;text-align:center'> <a  href='#' style='color:#337ab7'>"+
										"<span id='edit:"+result[i].email+"' onclick='editUser(this.id)'>Edit </span > &nbsp <span id='delete:"+result[i].objectId+"' onclick='deleteUser(this.id)'> Delete </span>"+
										"</a>"+
										"</td>"+								
									"</tr>";
					    		  tableDetails = tableDetails+table;
					    		  
					    	  }
					    	  console.log(tableDetails);
					    	  $("#userSearchResults").append("<tbody style='font-size:14px'>"+tableDetails+"</tbody>");
					    	  $('.userSpin').hide();
				    	  }
				    	 
				    	  
				     },
				     error : function(error) {
				    	console.log(error);
				     }
				  });
		    }
		    
		});
		
		$('.searchUsers').click(function(e){
			
			var userName = "${userName}";
			
			$('#userSearch').val('');
			
			var searchElement = {
		    			"searchId" : "",
		    			"userName" : userName
		    	};
		    	
		    	$('.userSpin').show();
		    	
		    	
		    	$.ajax({
				      type: "POST",
				      url: "searchUsers",
				      async: true,
				      data : searchElement,
				     
				      success :function(result) {
				    	  $("#userSearchResults").empty();
				    	  
				    	  console.log(result.length);
				    	  if(result.length == 0)
				    	  {					    		  
				    		  $('#noUserResults').text('Search results not found');
				    		  $('.userSpin').hide();
				    	  }
				    	  else
				    	  {
				    		  $('#noUserResults').empty();
				    		  $('#userbody').remove();
				    		  $('.userSpin').hide();
					    	  var tableDetails = "<td style='padding: 10px 0;text-align:center;''><b style='color:#337ab7;font-size:18px'>User Name</b></td>"+
								"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>First Name</b></td>"+
								"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>Last Name</b></td>"+
								"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>Email</b></td>"+
								"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>Phone Number</b></td>"+
								"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>Role</b></td>"+
								"<td style='padding:10px 0;text-align:center;'><b style='color:#337ab7;font-size:18px'>Actions</b></td>"+
								"</tr>";
					    	  for(var i=0;i<result.length;i++)
					    	  {
					    		  if(result[i].phone == null)
					    		  {
					    			  result[i].phone = "";
					    		  }
					    		  var table = "<tr>"+
										"<td style='padding: 10px 0;text-align:center;''> <a style='color:#337ab7' href='#'>"+											
										""+result[i].username+"</a>"+
										"</td>"+
										"<td style='padding:10px 0;text-align:center;'> <a  href='#' style='color:#337ab7'>"+										
										""+result[i].firstname+"</a>"+
										"</td>"+
										"<td style='padding:10px 0;text-align:center;'> <a  href='#' style='color:#337ab7'>"+											
										""+result[i].lastname+"</a>"+
										"</td>"+
										"<td style='padding:10px 0;text-align:center;''> <a style='color:#337ab7' href='#'>"+											
										""+result[i].email+"</a>"+
										"</td>"+
										"<td style='padding:10px 0;text-align:center;''> <a style='color:#337ab7' href='#'>"+											
										""+result[i].phone+"</a>"+
										"</td>"+
										"<td style='padding:10px 0;text-align:center;'> <a  href='#' style='color:#337ab7'>"+											
										""+result[i].user+"</a>"+
										"<td style='padding:10px 0;text-align:center'> <a  href='#' style='color:#337ab7'>"+
										"<span id='edit:"+result[i].email+"' onclick='editUser(this.id)'>Edit </span > &nbsp <span id='delete:"+result[i].objectId+"' onclick='deleteUser(this.id)'> Delete </span>"+
										"</a>"+
										"</td>"+
										
									"</tr>";
					    		  tableDetails = tableDetails+table;
					    		  
					    	  }
					    	  console.log(tableDetails);
					    	  $("#userSearchResults").append("<tbody style='font-size:14px'>"+tableDetails+"</tbody>");
					    	  $('.userSpin').hide();
				    	  }
				    	 
				    	  
				     },
				     error : function(error) {
				    	console.log(error);
				     }
				  });
		    
		    
		});
			
			
			
			$('#groupSearch').keyup(function(e){
				
				if(e.keyCode == 13)
			    {	    	
			    	var searchElement = {
			    			"searchId" : $('#groupSearch').val(),
			    			"username" : "null"
			    	};
			    	
			    	$('.groupSpin').show();
			    	
			    	
			    	$.ajax({
					      type: "POST",
					      url: "searchGroups",
					      async: true,
					      data : searchElement,
					     
					      success :function(result) {
					    	  $("#groupSearchResults").empty();
					    	  
					    	  console.log(result.length);
					    	  if(result.length == 0)
					    	  {					    		  
					    		  $('#noGroupResults').text('Search results not found');
					    		  $('.groupSpin').hide();
					    	  }
					    	  else
					    	  {
					    		  $('#noGroupResults').empty();
					    		  $('.groupSpin').hide();
						    	  var tableDetails = "<tr>"+
										"<td style='padding: 10px 0px 0px 30px;''><b style='color:#337ab7;font-size:18px'>Group Name</b></td>"+
										"<td style='padding:10px 0'><b style='color:#337ab7;font-size:18px'>Group Id</b></td>"+
									"</tr>";
						    	  for(var i=0;i<result.length;i++)
						    	  {
						    		  var table = "<tr>"+
						    		  "<td style='padding: 10px 0px 0px 30px;''> <a style='color:#337ab7' onclick='groupLoading()'  href='viewGroups?user=${user}&userName=${userName}&tempId="+result[i].templateId+"'>"+
								   	      ""+result[i].templateName+"</a>"+
								   	  "</td>"+
								   	  "<td style='padding:10px 0'> <a onclick='groupLoading()' href='viewGroups?user=${user}&userName=${userName}&tempId="+result[i].templateIId+"' style='color:#337ab7'>"+
								   	     ""+result[i].templateId+"</a>"+
								   	  "</td>"+
											
										"</tr>";
						    		  tableDetails = tableDetails+table;
						    		  
						    	  }
						    	  console.log(tableDetails);
						    	  $("#groupSearchResults").append("<tbody style='font-size:14px'>"+tableDetails+"</tbody>");
						    	  $('.groupSpin').hide();
					    	  }
					    	 
					    	  
					     },
					     error : function(error) {
					    	console.log(error);
					     }
					  });
			    }
			    
			});
			
			
			
		</script>
		
		
		<script>
			$('.templateSearch').keyup(function(e){
				
				if(e.keyCode == 13)
			    {	    	
			    	var searchElement = {
			    			"searchId" : $(this).val(),
			    			"username" : "null"
			    	};
			    	
			    	$('.tspin').show();
			    	
			    	
			    	$.ajax({
					      type: "POST",
					      url: "searchTemplates",
					      async: true,
					      data : searchElement,
					     
					      success :function(result) {
					    	  $(".templateSearchResults").empty();
					    	  
					    	  console.log(result);	
					    	  
					    	  if(result.length == 0)
					    	  {					    		  
					    		  $('.noTemplateResults').text('Search results not found');
					    		  $('.tspin').hide();
					    	  }
					    	  else
					    	  {
					    		  $('.noTemplateResults').empty();
					    		  $('.tbody').remove();
						    	  var tableDetails = "<tr>"+
									"<td style='padding:10px 0px 0px 30px;''><b style='color:#337ab7;font-size:18px'>Template Name</b></td>"+
									"<td style='padding:10px 0'><b style='color:#337ab7;font-size:18px'>Template Id</b></td>"+									
									"</tr>";
						    	  for(var i=0;i<result.length;i++)
						    	  {
						    		  var table = "<tr>"+
											"<td style='padding:10px 0px 0px 30px;'> <a onclick='templateLoading()' style='color:#337ab7' href='select?user=${user}&amp;userName=${userName}&amp;locId="+result[i].templateId+"'>"+
											""+result[i].templateName+""+
											"</a>"+
											"</td>"+
											"<td style='padding:10px 0'> <a onclick='templateLoading()' href='select?user=${user}&amp;userName=${userName}&amp;locId="+result[i].templateId+"' style='color:#337ab7'>"+
											""+result[i].templateId+""+
											"</a>"+
											"</td>"+				
										"</tr>";
						    		  tableDetails = tableDetails+table;
						    		  
						    	  }
						    	  console.log(tableDetails);
						    	  $(".templateSearchResults").append("<tbody style='font-size:14px'>"+tableDetails+"</tbody>");
						    	  $('.tspin').hide();
					    	  } 
					    	 
					    	  
					     },
					     error : function(error) {
					    	console.log(error);
					     }
					  });
			    }
			    
			});
		
		</script>
		
		<script>
			$('#templateSearch').keyup(function(e){
				
				if(e.keyCode == 13)
			    {	    	
			    	var searchElement = {
			    			"searchId" : $('#templateSearch').val(),
			    			"username" : "null"
			    	};
			    	
			    	$('.templateSpin').show();
			    	
			    	
			    	$.ajax({
					      type: "POST",
					      url: "searchTemplates",
					      async: true,
					      data : searchElement,
					     
					      success :function(result) {
					    	  $("#templateSearchResults").empty();
					    	  
					    	  console.log(result.length);
					    	  if(result.length == 0)
					    	  {					    		  
					    		  $('#noTemplateResults').text('Search results not found');
					    		  $('.templateSpin').hide();
					    	  }
					    	  else
					    	  {
					    		  $('#noTemplateResults').empty();
					    		  $('#templateSpin').remove();
						    	  var tableDetails = "<tr>"+
										"<td style='padding:10px 0px 0px 30px;''><b style='color:#337ab7;font-size:18px'>Template Name</b></td>"+
										"<td style='padding:10px 0'><b style='color:#337ab7;font-size:18px'>Template Id</b></td>"+
									"</tr>";
						    	  for(var i=0;i<result.length;i++)
						    	  {
						    		  var table = "<tr>"+
						    		  "<td style='padding:10px 0px 0px 30px;''> <a onclick='templateLoading()' style='color:#337ab7' href='viewTemplates?user=${user}&userName=${userName}&tempId="+result[i].templateId+"'>"+
								   	      ""+result[i].templateName+"</a>"+
								   	  "</td>"+
								   	  "<td style='padding:10px 0'> <a onclick='templateLoading()' href='viewTemplates?user=${user}&userName=${userName}&tempId="+result[i].templateIId+"' style='color:#337ab7'>"+
								   	     ""+result[i].templateId+"</a>"+
								   	  "</td>"+
											
										"</tr>";
						    		  tableDetails = tableDetails+table;
						    		  
						    	  }
						    	  console.log(tableDetails);
						    	  $("#templateSearchResults").append("<tbody style='font-size:14px'>"+tableDetails+"</tbody>");
						    	  $('.templateSpin').hide();
					    	  }
					    	 
					    	  
					     },
					     error : function(error) {
					    	console.log(error);
					     }
					  });
			    }
			    
			});
			
			
			$('.skipTemplate').click(function(e){
				
				$('#templateSearch').val('');
				var searchElement = {
			    			"searchId" : "",
			    			"username" : "null"
			    	};
			    	
			    	$('.templateSpin').show();
			    	
			    	
			    	$.ajax({
					      type: "POST",
					      url: "searchTemplates",
					      async: true,
					      data : searchElement,
					     
					      success :function(result) {
					    	  $("#templateSearchResults").empty();
					    	  
					    	  console.log(result.length);
					    	  if(result.length == 0)
					    	  {					    		  
					    		  $('#noTemplateResults').text('Search results not found');
					    		  $('.templateSpin').hide();
					    	  }
					    	  else
					    	  {
					    		  $('#noTemplateResults').empty();
					    		  $('#templateSpin').remove();
						    	  var tableDetails = "<tr>"+
										"<td style='padding:10px 0px 0px 30px;''><b style='color:#337ab7;font-size:18px'>Template Name</b></td>"+
										"<td style='padding:10px 0'><b style='color:#337ab7;font-size:18px'>Template Id</b></td>"+
									"</tr>";
						    	  for(var i=0;i<result.length;i++)
						    	  {
						    		  var table = "<tr>"+
						    		  "<td style='padding: 10px 0px 0px 30px;''> <a onclick='templateLoading()' style='color:#337ab7' href='viewTemplates?user=${user}&userName=${userName}&tempId="+result[i].templateId+"'>"+
								   	      ""+result[i].templateName+"</a>"+
								   	  "</td>"+
								   	  "<td style='padding:10px 0'> <a onclick='templateLoading()' href='viewTemplates?user=${user}&userName=${userName}&tempId="+result[i].templateIId+"' style='color:#337ab7'>"+
								   	     ""+result[i].templateId+"</a>"+
								   	  "</td>"+
											
										"</tr>";
						    		  tableDetails = tableDetails+table;
						    		  
						    	  }
						    	  console.log(tableDetails);
						    	  $("#templateSearchResults").append("<tbody style='font-size:14px'>"+tableDetails+"</tbody>");
						    	  $('.templateSpin').hide();
					    	  }
					    	 
					    	  
					     },
					     error : function(error) {
					    	console.log(error);
					     }
					  });
			  
			    
			});
			
			
			$('.skipGroup').click(function(e){
				$('#groupSearch').val('');
				var searchElement = {
			    			"searchId" : "",
			    			"username" : "null"
			    	};
			    	
			    	$('.groupSpin').show();
			    	
			    	
			    	$.ajax({
					      type: "POST",
					      url: "searchGroups",
					      async: true,
					      data : searchElement,
					     
					      success :function(result) {
					    	  $("#groupSearchResults").empty();
					    	  
					    	  console.log(result.length);
					    	  if(result.length == 0)
					    	  {					    		  
					    		  $('#noGroupResults').text('Search results not found');
					    		  $('.groupSpin').hide();
					    	  }
					    	  else
					    	  {
					    		  $('#noGroupResults').empty();
					    		  $('.groupSpin').hide();
						    	  var tableDetails = "<tr>"+
										"<td style='padding: 10px 0px 0px 30px;''><b style='color:#337ab7;font-size:18px'>Group Name</b></td>"+
										"<td style='padding:10px 0'><b style='color:#337ab7;font-size:18px'>Group Id</b></td>"+
									"</tr>";
						    	  for(var i=0;i<result.length;i++)
						    	  {
						    		  var table = "<tr>"+
						    		  "<td style='padding: 10px 0px 0px 30px;''> <a onclick='groupLoading()' style='color:#337ab7' href='viewGroups?user=${user}&userName=${userName}&tempId="+result[i].templateId+"'>"+
								   	      ""+result[i].templateName+"</a>"+
								   	  "</td>"+
								   	  "<td style='padding:10px 0'> <a onclick='groupLoading()' href='viewGroups?user=${user}&userName=${userName}&tempId="+result[i].templateIId+"' style='color:#337ab7'>"+
								   	     ""+result[i].templateId+"</a>"+
								   	  "</td>"+
											
										"</tr>";
						    		  tableDetails = tableDetails+table;
						    		  
						    	  }
						    	  console.log(tableDetails);
						    	  $("#groupSearchResults").append("<tbody style='font-size:14px'>"+tableDetails+"</tbody>");
						    	  $('.groupSpin').hide();
					    	  }
					    	 
					    	  
					     },
					     error : function(error) {
					    	console.log(error);
					     }
					  });
			    
			    
			});
			
			
			
		</script>
		
		
		<script type="text/javascript">
		
			
		
			$('#groupId').bind('keypress', function (event) {
			    var regex = new RegExp("^[a-zA-Z0-9\b]+$");
			    var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
			    if (!regex.test(key)) {
			       event.preventDefault();
			       return false;
			    }
			});
		
			
			$('#changePasswordDetails').click(function(){
				
				$('#changePasswordhref').click();
				
			});
			
			$('#savePassword').click(function(){
				
				var result = 0;
				var username = "${user}";
				var password = $('#cPassword').val();
				var repassword = $('#reenterPassword').val();
				
				
				if(password == "" || password == null)
				{
					$('#cpasErr').text('Password is required');
					result++;
				}
				else
				{
					$('#cpasErr').empty();
				}
				
				if(repassword == "" || repassword == null)
				{
					$('#rpassErr').text('Re-Enter Password is required');
					result++;
				}
				
				else if(password != repassword )
				{
					$('#rpassErr').text('Password s is not Match');
					$('#cpasErr').empty();
					result++;
				}
				else
				{
					$('#rpassErr').empty();
					$('#cpasErr').empty();
				}
				
				
				
				
				if( result == 0 )
				{
					var data = {
							"username" : username,
							"password" : password,
							"repassword" : repassword
						};
						
						$.ajax({
						      type: "POST",
						      url: "updateUserPassword",
						      async: true,
						      data : data,
						     
						      success :function(results) {
						    	  
						    	  if(results == "success")
						    	  {
						    		  $('#changeResultsErr').text('');
						    		  $('#cuPassword').click();
						    		  $('#changePassword').hide();
						    		  $('#cPassword').val('');
						    		  $('#reenterPassword').val('');
						    		  
						    		  
						    	  }
						    	  else
						    	  {
						    		  	$('#changeResultsErr').text("Sorry some error occured, Please try again");			    		  
						    	  }
						    	  	    	  		    	
						     },
						     error : function(error) {
						    	 console.log(error);
						    	
						     }
						  });
				}
				
				
			});
			
			
			$(document).ready(function(){
				
				$('#confirmChangePassword').click(function(){
					
					location.href = '/egsdAdminApp';
					
				});
				
			});
			
			
			 function isNumber(evt) {
			       evt = (evt) ? evt : window.event;
			       var charCode = (evt.which) ? evt.which : evt.keyCode;
			       if(charCode==46){
			        return true;
			       }
			       else if (charCode > 31 && (charCode < 48 || charCode > 57)) {
			           return false;
			       }else{
			       return true;
			       }
			   }
		</script>
		
		
		
		
</body>
</html>