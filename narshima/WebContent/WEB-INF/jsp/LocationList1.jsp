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
<title>Location Admin Page | eGSD Admin Template</title>


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
    	
	    <div class="modal-content" >
	      <center><h5>Select Hotel</h5></center>
	      <nav style="width:50%;height:40px;margin:14px 0 0 0px;background-color:#00bcd4;line-height:45px !important">
		    <div class="nav-wrapper">
		      
		        <div class="input-field">
		          <input class="search" type="search">
		          <label for="search"><i class="material-icons" style="line-height:45px">search</i></label>
		          
		        </div>
		      
		    </div>
		  </nav>
		  <div class="preloader-wrapper small active loader" style="display:none;margin:2% 0 0 50%">
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
		  <a href="#!" style="margin:-40px 0% 3% 3%;height:42px;line-height:39px"  class="skipSelection modal-action modal-close waves-effect waves-green btn right">Close</a>
		  <center style="margin-top:5%"><span class="noResults"></span></center>
	      <center> ${noHotels} </center>
				<table class="table bordered striped searchResults" >
					<tr>
					<td style="padding: 6px 0px 0px 30px;"><b style="color:#337ab7;font-size:18px">Hotel Name</b></td>
					<td style="padding:10px 0"><b style="color:#337ab7;font-size:18px">Hotel Id</b></td>
					<td style="padding:10px 0"><b style="color:#337ab7;font-size:18px">Group Site ID</b></td>
					<td style="padding:10px 0"><b style="color:#337ab7;font-size:18px">Zip/Postal Code</b></td>
						<td style="padding:10px 0"><b style="color:#337ab7;font-size:18px">Group Name</b></td>
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
							<td style="padding:10px 0"> <a  href="select?user=${user}&userName=${userName}&locId=${selectLocObj.directory}" style="color:#337ab7">
							${selectLocObj.zipcode}
							</a>
							</td>
							<td style="padding:10px 0"> <a  href="select?user=${user}&userName=${userName}&locId=${selectLocObj.directory}" style="color:#337ab7">
							${selectLocObj.groupName}
							</a>
							</td>
						</tr> 
					</c:forEach>
				</table>
	    </div>
    
  </div>
  
  
  <!-- start change hotel popup -->
	
	<div id="modal1" class="modal" style="width:80%">
	
		<a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat right">Close</a>
			<center ><h5>Select Hotel</h5></center>
			
		  <nav style="width:50%;height:40px;margin:14px 0 0 23px;line-height:45px !important;background-color:#00bcd4">
		    <div class="nav-wrapper">
		      
		        <div class="input-field">
		          <input class="search" type="search" >
		          <label for="search"><i class="material-icons" style="line-height:45px">search</i></label>
		          
		        </div>
		      
		    </div>
		  </nav>
		  
		  <div class="preloader-wrapper small active loader" style="display:none;margin:2% 0 0 50%">
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
						<tr>
						<td style="padding: 6px 0px 0px 30px;"><b style="color:#337ab7;font-size:18px">Hotel Name</b></td>
						<td style="padding:10px 0"><b style="color:#337ab7;font-size:18px">Hotel Id</b></td>
						<td style="padding:10px 0"><b style="color:#337ab7;font-size:18px">Group Site ID</b></td>
						<td style="padding:10px 0"><b style="color:#337ab7;font-size:18px">Zip/Postal Code</b></td>
						<td style="padding:10px 0"><b style="color:#337ab7;font-size:18px">Group Name</b></td>
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
								<td style="padding:10px 0"> <a  href="select?user=${user}&userName=${userName}&locId=${selectLocObj.directory}" style="color:#337ab7">
								${selectLocObj.zipcode}
								</a>
								</td>
								<td style="padding:10px 0"> <a  href="select?user=${user}&userName=${userName}&locId=${selectLocObj.directory}" style="color:#337ab7">
								${selectLocObj.groupName}
								</a>
								</td>
							</tr> 
						</c:forEach>
					</tbody>
				</table>
	    </div>
	    
	 </div>
	
	<!-- end of the change hotel popup -->
  

<body class="loaded" onload="bodyLoad()"
	style="font-family: 'Open Sans', sans-serif;">

	
	<div class="navbar-fixed cyan">
		<ul id="dropdown1" class="dropdown-content">
			 
			<li><a style="font-size: 1rem; padding: 0.5rem 0.5rem;" class="modal-trigger" 
				href="#modal1">Change Hotel</a></li>
			
			<li class="divider"></li>
			<li><a href="/egsdAdminApp/"
				style="font-size: 1rem; padding: 0.5rem 0.5rem;">Logout</a></li>
		</ul>
		<nav class="cyan" style="padding:0 5% 0 4%">
		<div class="nav-wrapper">
			<a href="/egsdAdminApp/" class="brand-logo"><img
				src="../img/logo.png" style="width: 100%; padding-top: 7px;"></a>
			<ul class="right hide-on-med-and-down">

				<li><a class="dropdown-button" href="#!"
					data-activates="dropdown1" style="min-width: 150px">${user} (${userName })<i
						class="material-icons right">arrow_drop_down</i></a></li>
			</ul>
		</div>
		</nav>
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
				alert("hai");
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
			$('.search').keyup(function(e){
				if(e.keyCode == 13)
			    {	
					
					var username = "${user}";
			    		    	
			    	var searchElement = {
			    			"searchId" : $(this).val(),
			    			"username" : username
			    	};			    	
			    	 $('.loader').show();
			    	
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
					    		  $('.loader').hide();
					    	  }
					    	  else
					    	  {
					    		  $('.noResults').empty();
					    		  $('.tbody').remove();
						    	  var tableDetails = "<tbody><tr>"+
									"<td style='padding: 6px 0px 0px 30px;''><b style='color:#337ab7;font-size:18px'>Hotel Name</b></td>"+
									"<td style='padding:10px 0'><b style='color:#337ab7;font-size:18px'>Hotel Id</b></td>"+
									"<td style='padding:10px 0'><b style='color:#337ab7;font-size:18px'>Group Site ID</b></td>"+
									"<td style='padding:10px 0'><b style='color:#337ab7;font-size:18px'>Zip/Postal Code</b></td>"+
									"<td style='padding:10px 0'><b style='color:#337ab7;font-size:18px'>Group Name</b></td>"+
									"</tr>";
						    	  for(var i=0;i<result.length;i++)
						    	  {
						    		  if(result[i].groupName == null)
						    		  {
						    			  result[i].groupName = "";
						    		  }
						    		  var table = "<tr>"+
											"<td style='padding: 6px 0px 0px 30px;'> <a style='color:#337ab7' href='select?user=${user}&amp;userName=${userName}&amp;locId="+result[i].hotelId+"'>"+
											""+result[i].name+""+
											"</a>"+
											"</td>"+
											"<td style='padding:10px 0'> <a href='select?user=${user}&amp;userName=${userName}&amp;locId="+result[i].hotelId+"' style='color:#337ab7'>"+
											""+result[i].hotelId+""+
											"</a>"+
											"</td>"+
											"<td style='padding:10px 0'> <a href='select?user=${user}&amp;userName=${userName}&amp;locId="+result[i].hotelId+"' style='color:#337ab7'>"+
											""+result[i].groupId+""+
											"</a>"+
											"</td>"+
											"<td style='padding:10px 0'> <a href='select?user=${user}&amp;userName=${userName}&amp;locId="+result[i].hotelId+"' style='color:#337ab7'>"+
											""+result[i].zipcode+""+
											"</a>"+
											"</td>"+
											"<td style='padding:10px 0'> <a href='select?user=${user}&amp;userName=${userName}&amp;locId="+result[i].hotelId+"' style='color:#337ab7'>"+
											""+result[i].groupName+""+
											"</a>"+
											"</td>"+
										"</tr><tbody>";
						    		  tableDetails = tableDetails+table;
						    		  
						    	  }
						    	  console.log(tableDetails);
						    	  $(".searchResults").append(tableDetails);
						    	  $('.loader').hide();
					    	  }
					    	 
					    	  
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
				$(".onload").click();

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
		
			$('#createSuperAdmin').click(function(){
				
				var data = {
					
						"firstname":$('#superFirstname').val(),
						"lastname":$('#superLastname').val(),
						"username":$('#superUsername').val(),
						"email":$('#superEmail').val(),
						"user": $('#user').val(),
						"userName": $('#userName').val()
						
						
				};
				
				 $(".mbody").append("<div style='margin:-55% 46%' class='preloader-wrapper small active'><div class='spinner-layer spinner-green-only'><div class='circle-clipper left'><div class='circle></div></div><div class='gap-patch'><div class='circle'></div></div><div class='circle-clipper right'><div class='circle'></div></div></div></div>");
				
				$.ajax({
				      type: "POST",
				      url: "registerSuperAdmin",
				      async: true,
				      data : data,
				     
				      success :function(results) {
				    	$('#superAdmin').hide();
				    	$('.mbody > :last-child').remove();
				    	$('#lean-overlay').css({display:'none'});
				    	$('#superFirstname').val('');
				    	$('#superLastname').val('');
				    	$('#superUsername').val('');
				    	$('#superEmail').val('');
				    	
				     },
				     error : function(error) {
				    	$('#superAdmin').hide();
				    	$('.mbody > :last-child').remove();
				    	$('#lean-overlay').css({display:'none'});
				    	$('#superFirstname').val('');
				    	$('#superLastname').val('');
				    	$('#superUsername').val('');
				    	$('#superEmail').val('');
				     }
				  });
				
			});
			
			$('#createCSAdmin').click(function(){
				
				var data = {
					
						"firstname":$('#csFirstname').val(),
						"lastname":$('#csLastname').val(),
						"username":$('#csUsername').val(),
						"email":$('#csEmail').val(),
						"user": $('#user').val(),
						"userName": $('#userName').val()
						
						
				};
				$(".mbody").append("<div style='margin:-55% 46%' class='preloader-wrapper small active'><div class='spinner-layer spinner-green-only'><div class='circle-clipper left'><div class='circle></div></div><div class='gap-patch'><div class='circle'></div></div><div class='circle-clipper right'><div class='circle'></div></div></div></div>");
				$.ajax({
				      type: "POST",
				      url: "registerCSAdmin",
				      async: true,
				      data : data,
				     
				      success :function(results) {
				    	$('#csAdmin').hide();
				    	$('.mbody > :last-child').remove();
				    	$('#lean-overlay').css({display:'none'});
				    	$('#csFirstname').val('');
				    	$('#csLastname').val('');
				    	$('#csUsername').val('');
				    	$('#csEmail').val('');
				     },
				     error : function(error) {
				    	 $('#csAdmin').hide();
				    	 $('.mbody > :last-child').remove();
					    	$('#lean-overlay').css({display:'none'});
					    	$('#csFirstname').val('');
					    	$('#csLastname').val('');
					    	$('#csUsername').val('');
					    	$('#csEmail').val('');
				     }
				  });
				
			});
			
			$('#createLocationAdmin').click(function(){
				
				var data = {
					
						"firstname":$('#locationFirstname').val(),
						"lastname":$('#locationLastname').val(),
						"username":$('#locationUsername').val(),
						"email":$('#locationEmail').val(),
						"user": $('#user').val(),
						"userName": $('#userName').val()
						
						
				};
				$(".mbody").append("<div style='margin:-55% 46%' class='preloader-wrapper small active'><div class='spinner-layer spinner-green-only'><div class='circle-clipper left'><div class='circle></div></div><div class='gap-patch'><div class='circle'></div></div><div class='circle-clipper right'><div class='circle'></div></div></div></div>");
				$.ajax({
				      type: "POST",
				      url: "registerLocationAdmin",
				      async: true,
				      data : data,
				     
				      success :function(results) {
				    	$('.locationAdmin').hide();	
				    	$('.mbody > :last-child').remove();
				    	$('#lean-overlay').css({display:'none'});
				    	var a ="<option value='"+results+"'>"+$('#locationUsername').val()+" - "+$('#locationFirstname').val()+" "+$('#locationLastname').val()+"  </option>";
						  $('#l2').html(a);
				    	$('#locationFirstname').val('');
				    	$('#locationLastname').val('');
				    	$('#locationUsername').val('');
				    	$('#locationEmail').val('');
				     },
				     error : function(error) {
				    	 $('.locationAdmin').hide();
				    	 $('.mbody > :last-child').remove();
					    	$('#lean-overlay').css({display:'none'});
					    	$('#locationFirstname').val('');
					    	$('#locationLastname').val('');
					    	$('#locationUsername').val('');
					    	$('#locationEmail').val('');
				     }
				  });
				
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
		
		
		
		
		
		
</body>
</html>