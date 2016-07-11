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

<body class="loaded" onload="bodyLoad()"
	style="font-family: 'Open Sans', sans-serif;">

	<div class="navbar-fixed cyan">
		<ul id="dropdown1" class="dropdown-content">
			
			<!-- <li><a style="font-size: 1rem; padding: 0.5rem 0.5rem;" class="modal-trigger" 
				href="#modal1">Change Hotel</a></li> -->
				
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
	<br />
	
	
	
	
	<!-- start change hotel popup -->
	
	<div id="modal1" class="modal" style="width:80%">
	<a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat right">Close</a>
		<center><h5>Select Hotel</h5></center>
		<nav style="width:50%;height:40px;margin:14px 0 0 23px;line-height:45px;background-color:#00bcd4">
		    <div class="nav-wrapper">
		      
		        <div class="input-field">
		          <input id="search" type="search" required>
		          <label for="search"><i class="material-icons" style="line-height:45px">search</i></label>
		          
		        </div>
		      
		    </div>
		  </nav>
		  <div class="preloader-wrapper small active loader" style="display:none;margin:1% 0 0 45%">
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
	      
	      		<center style="margin-top:5%"><span id="noResults"></span></center>
				<table class="table bordered striped" id="searchResults">
				  <tbody id="tbody">
					<tr>
					<td style="padding: 6px 0px 0px 30px;"><b style="color:#337ab7;font-size:18px">Hotel Name</b></td>
					<td style="padding:10px 0"><b style="color:#337ab7;font-size:18px">Hotel Id</b></td>
					<td style="padding:10px 0"><b style="color:#337ab7;font-size:18px">Group Site ID</b></td>
					<td style="padding:10px 0"><b style="color:#337ab7;font-size:18px">Zip/Postal Code</b></td>
					<td style="padding:10px 0"><b style="color:#337ab7;font-size:18px">Group Name</b></td>
					</tr>	
					<c:forEach var="adminLocObj" items="${adminLocObj}">
						<tr>
							<td style="padding: 6px 0px 0px 30px;"> <a style="color:#337ab7" href="select?user=${user}&userName=${userName}&locId=${adminLocObj.directory}">
							${adminLocObj.name}
							</a>
							</td>
							<td style="padding:10px 0"> <a  href="select?user=${user}&userName=${userName}&locId=${adminLocObj.directory}" style="color:#337ab7">
							${adminLocObj.directory}
							</a>
							</td>
							<td style="padding:10px 0"> <a  href="select?user=${user}&userName=${userName}&locId=${adminLocObj.directory}" style="color:#337ab7">
							${adminLocObj.siteId}
							</a>
							</td>
							<td style="padding:10px 0"> <a  href="select?user=${user}&userName=${userName}&locId=${adminLocObj.directory}" style="color:#337ab7">
							${adminLocObj.zipcode}
							</a>
							</td>
							<td style="padding:10px 0"> <a  href="select?user=${user}&userName=${userName}&locId=${adminLocObj.directory}" style="color:#337ab7">
							${adminLocObj.groupName}
							</a>
							</td>
						</tr> 
					</c:forEach>
				  </tbody>
				</table>
	    </div>
	    
	 </div>
	
	<!-- end of the change hotel popup -->
	
	
	
	
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
	
	
	
	
	<div class="container" style="width: 95%; display: none">
		<div class="row">
<c:forEach
									var="locObj" items="${locObj}">
			<div class="col col s4 m4 l4 ">
				<div class=" grey lighten-3"
					style="box-shadow: 0 2px 5px 0 #000, 0 2px 10px 0 #000; padding: 1% 0% 3% 6%">

					<div id="jstree-proton-1" class="proton-demo">
						<ul style="font-family: "Roboto", sans-serif;">
							<li class="jstree-open"><b>Hotel</b> 
									<ul>
									<%-- <li><a  href="viewLocation?user=${user}&userName=${userName}&locId=${locObj.objectId }"><b>${locObj.name}</b></a> --%>
										<li class="jstree-open"><a onclick="Loc_click(this.id)"
											id="${locObj.objectId }"><b>${locObj.name}
											<c:if test="${locObj.parentDirectoryId ne null }">
									          <c:forEach var="locObjForParentHotel" items="${locObjForParentHotel}">
									          <c:if test="${locObj.parentDirectoryId eq locObjForParentHotel.objectId }">
									           
									             (${locObjForParentHotel.name })
									          
									          </c:if>
									          </c:forEach>
									        </c:if>											
											</b></a> 
											 <c:forEach
												var="direcObjList" items="${direcObjList}">
												<ul>
													<c:if
														test="${locObj.directory eq direcObjList.directoryId }">
														<li class="jstree-open"
															style="font-family: 'Open Sans', sans-serif;"><a
															id="${direcObjList.objectId}"
															onclick="reply_click(this.id)">${direcObjList.title}</a>
															<ul>
																<c:forEach var="subDirObj" items="${subDirObj}">
																	<c:if
																		test="${direcObjList.objectId eq subDirObj.parentDirectoryId }">
																		<li class="jstree-open"><a
																			onclick="reply_click(this.id)"
																			id="${subDirObj.objectId }">${subDirObj.title }</a>
																			<ul>
																				<c:forEach var="subsubDirObj"
																					items="${subsubDirObj }">
																					<c:if
																						test="${(subDirObj.objectId eq subsubDirObj.directoryId) }">


																						<c:if
																							test="${(subsubDirObj.directoryId eq subsubDirObj.parentDirectoryId) }">

																							<li class="jstree-open"><a
																								title="${subsubDirObj.title }"
																								id="${subsubDirObj.objectId }"
																								onclick="reply_click(this.id)">
																									${subsubDirObj.title } </a>
																								<ul>
																									<c:forEach var="DirObjId" items="${DirObjId }">
																										<c:if
																											test="${subsubDirObj.objectId eq DirObjId.parentDirectoryId }">
																											<li><a id="${DirObjId.objectId }"
																												title="${DirObjId.title }"
																												onclick="reply_click(this.id)">
																													${DirObjId.title }</a></li>
																										</c:if>
																									</c:forEach>
																								</ul></li>
																						</c:if>
																					</c:if>
																				</c:forEach>
																			</ul></li>
																	</c:if>
																</c:forEach>
															</ul></li>
													</c:if>
												</ul>
											</c:forEach>  <!-- </li>
										</ul> --></li>
									</ul>
								 <!-- 	</li>
					</ul> --> <!-- <li> <a href="addLocation"><em>AddLocation</em></a></li> -->
					</div>

				</div>
			</div>
</c:forEach>

			<div id="#addLoc" class="modal">
				<div class="modal-content">
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
						do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
						enim ad minim veniam, quis nostrud exercitation ullamco laboris
						nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in
						reprehenderit in voluptate velit esse cillum dolore eu fugiat
						nulla pariatur. Excepteur sint occaecat cupidatat non proident,
						sunt in culpa qui officia deserunt mollit anim id est laborum</p>
				</div>
				<div class="modal-footer">
					<a href="#"
						class="waves-effect waves-red btn-flat modal-action modal-close">Disagree</a>
					<a href="#"
						class="waves-effect waves-green btn-flat modal-action modal-close">Agree</a>
				</div>
			</div>


			<div class="col col s8 s8 l8">
				<!-- <div class=" grey lighten-3"
					style="box-shadow: 0 2px 5px 0 #000, 0 2px 10px 0 #000; padding: 2% 5% 3% 5%"> -->




				<!--Start of displaying Directory Items  -->
				<div id="divSection"
					style="font-family: 'Open Sans', sans-serif; background-color: #fff; border-radius: 5px; box-shadow: 0 2px 5px 0 #000, 0 2px 10px 0 #000;">
					<!-- Displaying DiscriptionObjId  -->
					<c:forEach var="DiscriptionObjId" items="${DiscriptionObjId }">

						<c:forEach var="styleObjects" items="${styleObjects }">
							<c:if
								test="${styleObjects.objectId eq DiscriptionObjId.styleId }">

								<div class="${DiscriptionObjId.objectId} grey lighten-3"
									style="display: none; box-shadow: 0 2px 5px 0 #000, 0 2px 10px 0 #000; padding: 2% 5% 3% 5%">

									<%-- 	<div style="display:none;padding: 15px 15px 15px 15px; text-align: justify"
										class="${DiscriptionObjId.objectId} discription"> --%>



									<!-- nav bar -->
									<div class="row">
										 <%-- <a id="${DiscriptionObjId.objectId }"
											class="waves-effect waves-light btn modal-trigger right"
											onclick="manage_contact_click(this.id)" href="#manage"
											style="margin: 0 7px">Manage Contact Info</a> --%>
										<a id="${DiscriptionObjId.objectId }"
											class="waves-effect waves-light btn modal-trigger right"
											onclick="desc_click(this.id)" href="#edit"
											style="margin: 0 7px">Edit</a> <a
											id="${DiscriptionObjId.objectId }"
											onclick="del_click(this.id)"
											class="waves-effect waves-light btn modal-trigger right"
											href="#delete" style="margin: 0 7px">Delete</a> <a
											id="${DiscriptionObjId.objectId }"
											onclick="add_DirectoryItems_click(this.id)"
											class="waves-effect waves-light btn modal-trigger right"
											href="#add" style="margin: 0 7px">ADD DIRECTORY ITEM</a>
									</div>

									<div class="divider"></div>
									<!--Dispalying title  -->
									<div
										>
										<center style="color: #${styleObjects.titleColor} ; font-size: ${styleObjects.titleFont};font-family:${styleObjects.titleFamily}">
											<b><u>${DiscriptionObjId.title}</u></b>
										</center>
									</div>

									<!-- Displaying Caption -->
									<div
										>
										<center style="color: #${styleObjects.captionColor} ; font-size: ${styleObjects.captionFont};font-family:${styleObjects.captionFamily}">
											<c:if test="${DiscriptionObjId.caption ne null}">
							 ${DiscriptionObjId.caption}
											</c:if>
										</center>
									</div>
									
									<br/>

									<!-- Displaying Timings -->
									<div
										>
										<center style="color: #${styleObjects.timingsColor} ; font-size: ${styleObjects.timingsFont};font-family:${styleObjects.timingsFamily}">
											<c:if test="${DiscriptionObjId.timings ne null}">
							 Timings : ${DiscriptionObjId.timings}
											</c:if>
										</center>
									</div>
									

									<!-- Displaying Discription-->
									<div
										style="color: #${styleObjects.descriptionColor} ; font-size: ${styleObjects.descriptionFont};font-family:${styleObjects.descriptionFamily}">
										<c:if test="${DiscriptionObjId.description ne null}">
							 ${DiscriptionObjId.description}
										</c:if>
									</div>

									<!-- Displaying website -->
									<%-- <div
										style="color: #${styleObjects.websiteColor} ; font-size: ${styleObjects.websiteFont}px;font-family:${styleObjects.websiteFamily}">
										<c:if test="${DiscriptionObjId.website ne null}">
							 ${DiscriptionObjId.website}
										</c:if>
									</div>

									<!-- Displaying Email -->
									<div
										style="color: #${styleObjects.emailColor} ; font-size: ${styleObjects.emailFont}px;font-family:${styleObjects.emailFamily}">
										<c:if test="${DiscriptionObjId.email ne null}">
							 ${DiscriptionObjId.email}
										</c:if>
									</div> --%>
									
									<div>
										<c:if
											test="${DiscriptionObjId.picture ne 'No Image To Display'}">
											<center>
												<img alt="" style="width: 20%; height: 180px;"
													src="${DiscriptionObjId.picture}">
											</center>
											<br />
										</c:if>
										
									</div>
									<!-- Displaying MenuObjList -->


									<table class="table table-hover">

										<c:forEach var="menuObjectsList" items="${menuObjectsList }">
											<tr>
												<c:if
													test="${DiscriptionObjId.objectId eq menuObjectsList.menuId }">


													<td style="padding:7px 0px;width:10%"><c:if
															test="${menuObjectsList.description ne null}">
															<p
																style="margin-top: 0px;margin-bottom:0px;font-size:14px; font-family: 'Courier New, Courier, monospace">${menuObjectsList.description}</p>
														</c:if></td>

													<td style="padding:7px 5px;width:15%">
														<div
															style="font-family: Courier New, Courier, monospace;color: #${styleObjects.priceColor} ; font-size: ${styleObjects.priceFont}">
															<c:if test="${menuObjectsList.price ne null}">
											<b>${menuObjectsList.price}</b>
											</c:if>
														</div>
													</td>


												</c:if>
											</tr>
										</c:forEach>
										<!-- End of MenuObjList -->
										
										
										
										<!-- Displaying phonesObjList -->
										<c:forEach var="phonesObjectsList" items="${phonesObjectsList }">
											<tr>
												<c:if
													test="${DiscriptionObjId.objectId eq phonesObjectsList.phoneId }">


													<td style="padding:7px 0px;width:10%"><c:if
															test="${phonesObjectsList.type ne null}">
															<p
																style="margin-top: 0px;margin-bottom:0px;font-size:14px; font-family: 'Courier New, Courier, monospace">${phonesObjectsList.type}</p>
														</c:if></td>


													<td style="padding:7px 5px;width:15%">
														<div
															style="font-family: Courier New, Courier, monospace;color: #${styleObjects.priceColor} ; font-size: ${styleObjects.priceFont}">
															<c:if test="${phonesObjectsList.ext ne null}">
											<b>${phonesObjectsList.ext}</b>
											</c:if>
														</div>
													</td>


												</c:if>
											</tr>
										</c:forEach>
										<!-- End of PhonesObjList -->
									</table>

									<!-- End of PhonesObjList -->

								</div>

							</c:if>
						</c:forEach>

					</c:forEach>
					<!-- End of DiscriptionObjId -->
					<!-- </div> -->



				</div>
				<!--End of Displaying Directory Items  -->




				<!--Start of displaying Location Details  -->
				<div class="locPopup" style="display: none;">
					<div class="row"
						style="border-radius: 5px; box-shadow: 0 2px 5px 0 #000, 0 2px 10px 0 #000;">

						<c:forEach var="locObjForAddDirectoryItems"
							items="${locObjForAddDirectoryItems }">

							<%-- <div class=${locObjForAddDirectoryItems.objectId }
								style="display: none; text-align: center; margin: 15 10 10 10;">
 --%>
							<div
								class="${locObjForAddDirectoryItems.objectId } grey lighten-3"
								style="display: none; box-shadow: 0 2px 5px 0 #000, 0 2px 10px 0 #000; padding: 2% 5% 3% 5%">



								<%-- <span> <a id="${locObjForAddDirectoryItems.objectId }"
									class="btn btn-sm" onclick="add_Directory_click(this.id)"
									style="float: right; background-color: #46A597; border-radius: 5px; margin: 0px 0px 0 13px; padding: 8px 10px 0 10px;">
										Add Directory</a>
										 <a id="${locObjForAddDirectoryItems.objectId }"
									class="btn btn-sm" onclick="edit_Directory_click(this.id)"
									style="float: right; background-color: #46A597; border-radius: 5px; margin: 0px 0px 0 13px; padding: 8px 10px 0 10px;">
										Edit</a>
										 <a id="${locObjForAddDirectoryItems.objectId }"
									class="btn btn-sm" onclick="del_Loc_click(this.id)"
									style="float: right; background-color: #46A597; border-radius: 5px; margin: 0px 0px 0 13px; padding: 8px 10px 0 10px;">
										Delete Location</a> 
								</span> <br>
								<hr> --%>
								<div class="row" >
           <a id="${locObjForAddDirectoryItems.objectId }"
    onclick="preview_Directory_click(this.id)" class="waves-effect waves-light btn right"
     style="margin: 0 7px">Preview</a>
           <a id="${locObjForAddDirectoryItems.objectId }"
    onclick="edit_Directory_click(this.id)" class="waves-effect waves-light btn modal-trigger right"
    href="#editLocation" style="margin: 0 7px">Edit</a> <a id="${locObjForAddDirectoryItems.objectId }"
     onclick="del_Loc_click(this.id)" class="waves-effect waves-light btn modal-trigger right"
    href="#deleteLocation"    style="margin: 0 7px">Delete this Hotel</a>
              <a id="${locObjForAddDirectoryItems.objectId }"
       onclick="add_Directory_click(this.id)" class="waves-effect waves-light btn modal-trigger right"
           href="#addDirectory" style="margin: 0 7px">Add Directory Item</a>
          </div>

								<div class="divider"></div>

								 <br/>
       <div class="row">
        <div class="col col s4 m4 l4">
        <c:if test="${locObjForAddDirectoryItems.name ne null}">
        <b> <span class="active" for="first_name2"
          style="font-size: 14px;">${locObjForAddDirectoryItems.name }</span></b><br/>
        </c:if>
        <br/>
        <c:if test="${locObjForAddDirectoryItems.address ne null}">
         <span class="active" for="first_name2"
          style="font-size: 14px; font-weight: normal">${locObjForAddDirectoryItems.address }</span>&nbsp
        </c:if>
        
        <c:if test="${locObjForAddDirectoryItems.address2 ne null}">
         <span class="active" for="first_name2"
          style="font-size: 14px; font-weight: normal">${locObjForAddDirectoryItems.address2 }</span>&nbsp
        </c:if>
        
        <c:if test="${locObjForAddDirectoryItems.street ne null}">
         <span class="active" for="first_name2"
          style="font-size: 14px; font-weight: normal">${locObjForAddDirectoryItems.street }</span>&nbsp
        </c:if>
        
        <c:if test="${locObjForAddDirectoryItems.town ne null}">
         <span class="active" for="first_name2"
          style="font-size: 14px; font-weight: normal">${locObjForAddDirectoryItems.town }</span><br/>
        </c:if>
        
        <c:if test="${locObjForAddDirectoryItems.zipcode ne null}">
         <span class="active" for="first_name2"
          style="font-size: 14px; font-weight: normal">${locObjForAddDirectoryItems.zipcode }</span><br/>
        </c:if>
        
         <c:if test="${locObjForAddDirectoryItems.country ne null}">
         <span class="active" for="first_name2"
          style="font-size: 14px; font-weight: normal">${locObjForAddDirectoryItems.country}</span><br/>
        </c:if> 
        
        <c:if test="${locObjForAddDirectoryItems.logo ne 'No Image To Display'}">
        <br/><img alt="" style="width: 100%; height: 180px;"
         src="${locObjForAddDirectoryItems.logo}">
         
        </c:if>
        </div>
        <div class="col col s4 m4 l4">
         	<img alt="" style="width: 100%; height: 180px;"
         src="${locObjForAddDirectoryItems.qRCode}">
         <br/>
         <br/>
         <%-- <a href="print?qrcode=${locObjForAddDirectoryItems.qRCode}" class="waves-effect waves-light btn modal-trigger right" style="margin: 0 7px">Print</a> --%>
         
         <a href="#" onclick="VoucherPrint('${locObjForAddDirectoryItems.qRCode}'); return true;" class="waves-effect waves-light btn modal-trigger right" style="margin: 0 7px">Print</a>
         
        </div>
        <div class="col col s4 m4 l4">
         	<span onclick="preview_Hotel_click(this)" class="${locObjForAddDirectoryItems.objectId }" style="cursor:pointer;font-size:11px">
         		http://betabullsapp.github.io/eGSD/directories.html?id=${locObjForAddDirectoryItems.objectId }
         	</span>
        </div>
        
       </div>
								<%-- 											<input type="hidden" name="user" value="${userName}"> --%>
								<!-- 										<input type="file" name="logo" value="choose Image"> -->
								<!-- 											<input type="submit" value="Submit"> -->


							</div>

						</c:forEach>

						<!-- 					</div> -->
					</div>
					<!--End of Displaying location Details  -->


				</div>

			</div>

			<div class="col col s8 s8 l8">
				<div class="addLocationForm grey lighten-3"
					style="display: none; box-shadow: 0 2px 5px 0 #000, 0 2px 10px 0 #000; padding: 1% 6% 3% 6%">

					<a style="cursor: pointer;" onclick="CloseDiv()"
						class="close right">Close</a>

					


				</div>
			</div>





		</div>
		<!--  Popup code  -->



		<!--Start of Directory Edit  -->
		<div class="editPopup"
			style="display: none; opacity: 1; top: 10%; max-height: 50%">


			<div id="edit" class="modal" style="width:75%">
				<a href="#"
					class="waves-effect waves-green btn-flat modal-action modal-close right">Close</a>
				<div class="modal-content">


					<c:forEach var="showDiscriptionObjId"
						items="${showDiscriptionObjId }">


						<!--Start of Div to Display Edit Values  -->
						<div class="${showDiscriptionObjId.objectId}"
							style="display: none; padding: 15px 15px 15px 15px; text-align: justify">

							<!-- new popup -->
							<div class="row">
								<!--Displayingf Styles  -->
								<c:forEach var="styleObjectsForEdit"
									items="${styleObjectsForEdit }">

									<c:if
										test="${showDiscriptionObjId.styleId eq styleObjectsForEdit.objectId }">



										<form class="col s12" action="edit" method="post"
											commandName="editDirectory" enctype="multipart/form-data">

											<!--Hidden values  -->
											<input type="hidden" value="${showDiscriptionObjId.objectId}"
												name="objectId"> <input type="hidden"
												value="${showDiscriptionObjId.directoryId}"
												name="directoryId"><input type="hidden"
            									value="${showDiscriptionObjId.locationId}" name="locationId"> <input type="hidden"
												value="${showDiscriptionObjId.styleId}" name="styleId">
											<input type="hidden" value="${showDiscriptionObjId.phones}"
												name="phones"> <input type="hidden"
												value="${userName}" name="userName"> <input
												type="hidden" value="${user}" name="user">


											<%-- <!--Displaying Location  -->
										<c:forEach var="locObjForEdit" items="${locObjForEdit}">
											<c:if
												test="${locObjForEdit.objectId eq showDiscriptionObjId.directoryId }">
												<div class="row">
													<div class="input-field col s7">
														<input type="text" class="validate"
															value="${locObjForEdit.name }" name="locName"> <label
															class="active" for="first_name2">Location</label>
													</div>
													<div class="input-field col s2">
														<input type="text" class="color" name="descriptionColor">
														<label class="active" for="last_name">Color</label>
													</div>
													<div class="input-field col s3">
														<select class="browser-default">
															<option value="" disabled selected>Font Weight</option>
															<option value="${styleObjectsForEdit.descriptionFont }"
																default>Seleted</option>
															<option value="1" style="font-size: 8px">Small</option>
															<option value="2" style="font-size: 12px">Normal</option>
															<option value="3" style="font-size: 16px">Large</option>
															<option value="4" style="font-size: 20px">Huge</option>
														</select>

													</div>
												</div>
											</c:if>
										</c:forEach>
 --%>
											<!--Displaying Title  -->
											<div class="row">
												<div class="input-field col s3">
													<input name="title" value="${showDiscriptionObjId.title}" required id="${showDiscriptionObjId.objectId}:title"
														type="text" style="font-weight: normal; font-size: 14px" required>
													<label class="active"
														style="font-weight: normal; font-size: 14px">Title</label>

												</div>
												<div class="input-field col s2">
													<input type="text" class="color" name="titleColor" id="${showDiscriptionObjId.objectId}:titleColor"
														value="${styleObjectsForEdit.titleColor}"
														style="font-weight: normal; font-size: 14px" disabled> <label
														class="active"
														style="font-weight: normal; font-size: 14px">Color</label>

												</div>
												<div class="input-field col s2">
													<select class="browser-default" name="titleFont" id="${showDiscriptionObjId.objectId}:titleFont" disabled>
														<option value="${styleObjectsForEdit.titleFont}" style="font-size:${styleObjectsForEdit.titleFont}" selected>${styleObjectsForEdit.titleFont}</option>
														<option value="initial" style="font-size: initial" >initial</option>
														<option value="xx-small" style="font-size: xx-small">xx-small</option>
														<option value="x-small" style="font-size: x-small">x-small</option>
														<option value="small" style="font-size: small">small</option>
														<option value="medium" style="font-size: medium">medium</option>
														<option value="large" style="font-size: large">large</option>
														<option value="x-large" style="font-size: x-large">x-large</option>
														<option value="xx-large" style="font-size: xx-large">xx-large</option>
														<option value="smaller" style="font-size: smaller">smaller</option>
														<option value="larger" style="font-size: larger">larger</option>
													</select>

												</div>
												<div class="input-field col s3">
													<select class="browser-default" name="titleFamily" id="${showDiscriptionObjId.objectId}:titleFamily" disabled>
														<option value="${styleObjectsForEdit.titleFamily}" style="font-family:${styleObjectsForEdit.titleFamily}" selected>${styleObjectsForEdit.titleFamily}</option>
														
														<option value="Courier New" style="font-family:Courier New">Courier New</option>
														<option value="Lucida Console" style="font-family:Lucida Console">Lucida Console</option>
														<option value="Verdana" style="font-family:Verdana">Verdana</option>
														<option value="Trebuchet MS" style="font-family:Trebuchet MS">sans-serif</option>
														<option value="Tahoma" style="font-family:Tahoma">Tahoma</option>
														<option value="Lucida Sans Unicode" style="font-family:Lucida Sans Unicode">Lucida Sans Unicode</option>
														<option value="Charcoal" style="font-family:Charcoal">Charcoal</option>
														<option value="Comic Sans MS" style="font-family:Comic Sans MS">Comic Sans MS</option>
														<option value="Arial Black" style="font-family:Arial Black">Arial Black</option>
														<option value="Arial" style="font-family:Arial">Arial</option>
														<option value="Times New Roman" style="font-family:Times New Roman">Times New Roman</option>
														<option value="Palatino Linotype" style="font-family:Palatino Linotype">Palatino Linotype</option>
														<option value="Georgia" style="font-family:Georgia">Georgia</option>
														
													</select>
		
												</div>
											</div>

											<!--Displaying Caption  -->
											<div class="row">
												<div class="input-field col s3">
													<input type="text" value="${showDiscriptionObjId.caption}"
														name="caption" id="${showDiscriptionObjId.objectId}:caption"
														style="font-weight: normal; font-size: 14px"> <label
														class="active"
														style="font-weight: normal; font-size: 14px">Caption</label>
												</div>
												<div class="input-field col s2">
													<input type="text" name="captionColor" id="${showDiscriptionObjId.objectId}:captionColor"
														value="${styleObjectsForEdit.captionColor}" class="color"
														style="font-weight: normal; font-size: 14px" disabled> <label
														class="active"
														style="font-weight: normal; font-size: 14px">Color</label>

												</div>
												<div class="input-field col s2">
													<select class="browser-default" name="captionFont" id="${showDiscriptionObjId.objectId}:captionFont" disabled>
														<option value="${styleObjectsForEdit.captionFont}"	style="font-size: ${styleObjectsForEdit.captionFont}" selected>${styleObjectsForEdit.captionFont}</option>
														<option value="initial" style="font-size: initial">initial</option>
														<option value="xx-small" style="font-size: xx-small">xx-small</option>
														<option value="x-small" style="font-size: x-small">x-small</option>
														<option value="small" style="font-size: small">small</option>
														<option value="medium" style="font-size: medium">medium</option>
														<option value="large" style="font-size: large">large</option>
														<option value="x-large" style="font-size: x-large">x-large</option>
														<option value="xx-large" style="font-size: xx-large">xx-large</option>
														<option value="smaller" style="font-size: smaller">smaller</option>
														<option value="larger" style="font-size: larger">larger</option>
													</select>

												</div>
												<div class="input-field col s3">
													<select class="browser-default" name="captionFamily" id="${showDiscriptionObjId.objectId}:captionFamily" disabled>
														<option value="${styleObjectsForEdit.captionFamily}" style="font-family:${styleObjectsForEdit.captionFamily}" selected>${styleObjectsForEdit.captionFamily}</option>
														<option value="Courier New" style="font-family:Courier New">Courier New</option>
														<option value="Lucida Console" style="font-family:Lucida Console">Lucida Console</option>
														<option value="Verdana" style="font-family:Verdana">Verdana</option>
														<option value="Trebuchet MS" style="font-family:Trebuchet MS">sans-serif</option>
														<option value="Tahoma" style="font-family:Tahoma">Tahoma</option>
														<option value="Lucida Sans Unicode" style="font-family:Lucida Sans Unicode">Lucida Sans Unicode</option>
														<option value="Charcoal" style="font-family:Charcoal">Charcoal</option>
														<option value="Comic Sans MS" style="font-family:Comic Sans MS">Comic Sans MS</option>
														<option value="Arial Black" style="font-family:Arial Black">Arial Black</option>
														<option value="Arial" style="font-family:Arial">Arial</option>
														<option value="Times New Roman" style="font-family:Times New Roman">Times New Roman</option>
														<option value="Palatino Linotype" style="font-family:Palatino Linotype">Palatino Linotype</option>
														<option value="Georgia" style="font-family:Georgia">Georgia</option>
														
													</select>

												</div>
												
											</div>


											<!-- Displaying Timings -->
											<div class="row">
												<div class="input-field col s3">
													<input type="text" class="validate" name="timings" id="${showDiscriptionObjId.objectId}:timings"
														value="${showDiscriptionObjId.timings}"
														style="font-weight: normal; font-size: 14px"> <label
														class="active"
														style="font-weight: normal; font-size: 14px">Timings</label>
												</div>
												<div class="input-field col s2">
													<input type="text" class="color" name="timingsColor" id="${showDiscriptionObjId.objectId}:timingsColor"
														value="${styleObjectsForEdit.timingsColor}"
														style="font-weight: normal; font-size: 14px" disabled> <label
														class="active" for="last_name"
														style="font-weight: normal; font-size: 14px">Color</label>
												</div>
												<div class="input-field col s2">
													<select class="browser-default" name="timingsFont" id="${showDiscriptionObjId.objectId}:timingsFont" disabled>
														
														<option value="${styleObjectsForEdit.timingsFont }"
															style="font-size: ${styleObjectsForEdit.timingsFont }" selected>${styleObjectsForEdit.timingsFont}</option>
														<option value="initial" style="font-size: initial">initial</option>
														<option value="xx-small" style="font-size: xx-small">xx-small</option>
														<option value="x-small" style="font-size: x-small">x-small</option>
														<option value="small" style="font-size: small">small</option>
														<option value="medium" style="font-size: medium">medium</option>
														<option value="large" style="font-size: large">large</option>
														<option value="x-large" style="font-size: x-large">x-large</option>
														<option value="xx-large" style="font-size: xx-large">xx-large</option>
														<option value="smaller" style="font-size: smaller">smaller</option>
														<option value="larger" style="font-size: larger">larger</option>
													</select>

												</div>
												<div class="input-field col s3">
													<select class="browser-default" name="timingsFamily" id="${showDiscriptionObjId.objectId}:family" disabled>
														<option value="${styleObjectsForEdit.timingsFamily}" style="font-family:${styleObjectsForEdit.timingsFamily}" selected>${styleObjectsForEdit.timingsFamily}</option>
														<option value="Courier New" style="font-family:Courier New">Courier New</option>
														<option value="Lucida Console" style="font-family:Lucida Console">Lucida Console</option>
														<option value="Verdana" style="font-family:Verdana">Verdana</option>
														<option value="Trebuchet MS" style="font-family:Trebuchet MS">sans-serif</option>
														<option value="Tahoma" style="font-family:Tahoma">Tahoma</option>
														<option value="Lucida Sans Unicode" style="font-family:Lucida Sans Unicode">Lucida Sans Unicode</option>
														<option value="Charcoal" style="font-family:Charcoal">Charcoal</option>
														<option value="Comic Sans MS" style="font-family:Comic Sans MS">Comic Sans MS</option>
														<option value="Arial Black" style="font-family:Arial Black">Arial Black</option>
														<option value="Arial" style="font-family:Arial">Arial</option>
														<option value="Times New Roman" style="font-family:Times New Roman">Times New Roman</option>
														<option value="Palatino Linotype" style="font-family:Palatino Linotype">Palatino Linotype</option>
														<option value="Georgia" style="font-family:Georgia">Georgia</option>
														
													</select>

												</div>
											</div>
										
											<!--Displaying Description -  -->
											<div class="row">
												<div class="input-field col s5">
													<input type="text" name="description" required
														value="${showDiscriptionObjId.description}" id="${showDiscriptionObjId.objectId}:description"
														class=" validate"
														style="font-weight: normal; font-size: 14px"> <label
														class="active" for="first_name2"
														style="font-weight: normal; font-size: 14px">Description</label>
												</div>
												<div class="input-field col s2">
													<input type="text" name="descriptionColor" id="${showDiscriptionObjId.objectId}:descriptionColor"
														value="${styleObjectsForEdit.descriptionColor }"
														class="color "
														style="font-weight: normal; font-size: 14px" disabled> <label
														class="active" for="last_name"
														style="font-weight: normal; font-size: 14px">Color</label>
												</div>
												<div class="input-field col s2">
													<select class="browser-default" name="descriptionFont" id="${showDiscriptionObjId.objectId}:descriptionFont" disabled>
														
														<option value="${styleObjectsForEdit.descriptionFont }"
															style="font-size: ${styleObjectsForEdit.descriptionFont }" selected>${styleObjectsForEdit.descriptionFont }</option> 
														<option value="initial" style="font-size: initial">initial</option>
														<option value="xx-small" style="font-size: xx-small">xx-small</option>
														<option value="x-small" style="font-size: x-small">x-small</option>
														<option value="small" style="font-size: small">small</option>
														<option value="medium" style="font-size: medium">medium</option>
														<option value="large" style="font-size: large">large</option>
														<option value="x-large" style="font-size: x-large">x-large</option>
														<option value="xx-large" style="font-size: xx-large">xx-large</option>
														<option value="smaller" style="font-size: smaller">smaller</option>
														<option value="larger" style="font-size: larger">larger</option>
													</select>

												</div>
												<div class="input-field col s3">
													<select class="browser-default" name="descriptionFamily" id="${showDiscriptionObjId.objectId}:descriptionFamily" disabled>
														<option value="${styleObjectsForEdit.descriptionFamily}" style="font-family:${styleObjectsForEdit.descriptionFamily}" selected>${styleObjectsForEdit.timingsFamily}</option>
														<option value="Courier New" style="font-family:Courier New">Courier New</option>
														<option value="Lucida Console" style="font-family:Lucida Console">Lucida Console</option>
														<option value="Verdana" style="font-family:Verdana">Verdana</option>
														<option value="Trebuchet MS" style="font-family:Trebuchet MS">sans-serif</option>
														<option value="Tahoma" style="font-family:Tahoma">Tahoma</option>
														<option value="Lucida Sans Unicode" style="font-family:Lucida Sans Unicode">Lucida Sans Unicode</option>
														<option value="Charcoal" style="font-family:Charcoal">Charcoal</option>
														<option value="Comic Sans MS" style="font-family:Comic Sans MS">Comic Sans MS</option>
														<option value="Arial Black" style="font-family:Arial Black">Arial Black</option>
														<option value="Arial" style="font-family:Arial">Arial</option>
														<option value="Times New Roman" style="font-family:Times New Roman">Times New Roman</option>
														<option value="Palatino Linotype" style="font-family:Palatino Linotype">Palatino Linotype</option>
														<option value="Georgia" style="font-family:Georgia">Georgia</option>
														
													</select>

												</div>
											</div>

											<c:if test="${showDiscriptionObjId.customizedOrder ne null}">
									 				<div class="row">
														<div class="input-field col s3">
															<input type="text" name="editCustomizeNumber" class="description " 
																style="font-weight: normal; font-size: 14px" value="${showDiscriptionObjId.customizedOrder}" id="${showDiscriptionObjId.objectId}:customizeorder" onkeypress="return isNumber(event)"> <label
																class="active" for="first_name2"
																style="font-weight: normal; font-size: 14px">Customized Display Order</label>
														</div>
													</div>
											</c:if>
											
											<c:if test="${showDiscriptionObjId.customizedOrder == null}">
									 				<div class="row">
														<div class="input-field col s3">
															<input type="text" name="editCustomizeNumber" class="description " 
																placeholder="Enter a Number" style="font-weight: normal; font-size: 14px" onkeypress="return isNumber(event)"> <label
																class="active" for="first_name2"
																style="font-weight: normal; font-size: 14px">Customized Display Order</label>
														</div>
													</div>
											</c:if>
											
											
											<div class="file-field input-field col s12">
												<div class="btn"
													style="padding: 0 10px 0 10px; margin: 0 0 0 0;">
													<span>Image</span> <input type="file" name="logo" multiple>
												</div>
												<div class="file-path-wrapper ">
													<input class="file-path validate col s6" type="text"
														placeholder="Upload Image"
														style="font-weight: normal; font-size: 14px; margin: 0 0 0 70px">
												</div>
											</div>																
											
											<div class="">
												<div class="input-field col s12"
													style="margin: 10px 0 0 10px;">
													<c:if
														test="${showDiscriptionObjId.picture ne 'No Image To Display'}">
														<br/><center><img src="${showDiscriptionObjId.picture}" style="width:40%;height:auto"/></center><br/>
													</c:if>
												</div>
											</div>

											<br/>
											
											
											
											<div class="row">
											  	          
									          <div class="input-field col s3 m3 l3">
									              <input type="checkbox" name="editmenu:${showDiscriptionObjId.objectId}" id="editmenu:${showDiscriptionObjId.objectId}" onclick="edithandleClick(this.id);"/>
									              <label for="editmenu:${showDiscriptionObjId.objectId}">Add Menu</label>
									          </div>
									          
									          <div class="input-field col s1 m1 l1"></div>
									          
									          <div class="input-field col s3 m3 l3">
									              <input type="checkbox" name="editcontact:${showDiscriptionObjId.objectId}" id="editcontact:${showDiscriptionObjId.objectId}" onclick="editcontactClick(this.id);"/>
									              <label for="editcontact:${showDiscriptionObjId.objectId}">Add Contacts</label>
									          </div>
									          
									          
									        </div>
											<hr style="border-style:solid;margin-top:4%;display:none" class="edithr1">
											
											<div class=""  id="editmenu${showDiscriptionObjId.objectId}" style="display:none" >
												
											<div class="row">	
															
															<div class="input-field col s2">
																<input type="text" name="editpriceColor"
																	value="${styleObjectsForEdit.priceColor}"
																	class="color colors1"
																	style="font-weight: normal; font-size: ${styleObjectsForEdit.priceColor}px" > <label
																	class="active" for="last_name"
																	style="font-weight: normal; font-size: 14px">Color</label>
															</div>
															<div class="input-field col s3">
																<select class="browser-default font1" name="editpriceFont">
																	
																	<option value="${styleObjectsForEdit.priceFont}" style="font-size: ${styleObjectsForEdit.priceFont}">${styleObjectsForEdit.priceFont}</option>
																	<option value="initial" style="font-size: initial" selected>initial</option>
																	<option value="xx-small" style="font-size: xx-small">xx-small</option>
																	<option value="x-small" style="font-size: x-small">x-small</option>
																	<option value="small" style="font-size: small">small</option>
																	<option value="medium" style="font-size: medium">medium</option>
																	<option value="large" style="font-size: large">large</option>
																	<option value="x-large" style="font-size: x-large">x-large</option>
																	<option value="xx-large" style="font-size: xx-large">xx-large</option>
																	<option value="smaller" style="font-size: smaller">smaller</option>
																	<option value="larger" style="font-size: larger">larger</option>
																</select>
			
															</div>
															<div class="input-field col s3">
																<select class="browser-default family1" name="editpriceFamily">
																	
																	<option selected value="Courier New" style="font-family:Courier New">Courier New</option>
														<option value="Lucida Console" style="font-family:Lucida Console">Lucida Console</option>
														<option value="Verdana" style="font-family:Verdana">Verdana</option>
														<option value="Trebuchet MS" style="font-family:Trebuchet MS">sans-serif</option>
														<option value="Tahoma" style="font-family:Tahoma">Tahoma</option>
														<option value="Lucida Sans Unicode" style="font-family:Lucida Sans Unicode">Lucida Sans Unicode</option>
														<option value="Charcoal" style="font-family:Charcoal">Charcoal</option>
														<option value="Comic Sans MS" style="font-family:Comic Sans MS">Comic Sans MS</option>
														<option value="Arial Black" style="font-family:Arial Black">Arial Black</option>
														<option value="Arial" style="font-family:Arial">Arial</option>
														<option value="Times New Roman" style="font-family:Times New Roman">Times New Roman</option>
														<option value="Palatino Linotype" style="font-family:Palatino Linotype">Palatino Linotype</option>
														<option value="Georgia" style="font-family:Georgia">Georgia</option>
																	
																</select>
					
															</div>
														</div>				
											<div class="">	
												<div class='editmenuTextBoxesGroup'>
														
													<div class="editmenuTextBoxDiv1">
															<c:set var="count" value="0" scope="page" />		
															<c:forEach var="menuObjectsListForEdit" 
																items="${menuObjectsListForEdit }">
					
																<c:if
																	test="${showDiscriptionObjId.objectId eq menuObjectsListForEdit.menuId }">
																	
																	<c:set var="fcheck" value="1" scope="page" />
																	<input type="hidden" value="${fcheck}" class="fcheck${showDiscriptionObjId.objectId}" >
																	<c:set var="count" value="${count + 1}" scope="page"/>
																	<input type="hidden" value="${menuObjectsListForEdit.objectId}" name="editmenuObject${count}"/>
																	
																	<div class="row">																					
																			
																		
																	
																		<div class="input-field col s4">
																			<input type="text" name="editmenuDescription${count}"
																				value="${menuObjectsListForEdit.description}"
																				class="materialize-textarea validate"> <label
																				class="active" for="first_name2">MenuItem Description</label>
																		</div>
																		<div class="input-field col s2">
																			<input type="text" value="${menuObjectsListForEdit.price}" name="editmenuPrice${count}"
																				class="materialize-textarea validate"> <label
																				class="active" for="first_name2">Price</label>
																		</div>
																		
																		<input type="button" value="Delete" class="editmenuremoveButton btn input-field col s1">
																		
																	</div>	
																												
					
																</c:if>
															</c:forEach>
															<input type="hidden" class="editmenuCount" name="editmenuCount" value="${count}" />
													   </div>
														
														
														
													</div>
													<div class="left">
														<input type='button'  value='Add New Menu Item' class='editmenuaddButton btn' style="padding:0 47px 0 47px">
														
														<!-- <input type='button' value='Save' class='getButtonValue btn'> -->
													</div>
												</div>
												
											
											</div>
											
											<hr style="border-style:solid;margin-top:8%;display:none" class="edithr2">
											
											<div class="col s12"  id="editcontact${showDiscriptionObjId.objectId}" style="display:none;padding:0 0 0 0">
												<div class='editmanageTextBoxesGroup' >
												<c:set var="count1" value="0" scope="page" />
													<div class="editmanageTextBoxDiv1">
														
														<c:forEach var="phonesObjectsListForEdit" 
															items="${phonesObjectsListForEdit}">
															
															<c:if test="${showDiscriptionObjId.objectId eq phonesObjectsListForEdit.phoneId}">
															<c:set var="count1" value="${count1 + 1}" scope="page"/>
															
															<c:set var="scheck" value="1" scope="page" />
															<input type="hidden" value="${scheck}" class="scheck${showDiscriptionObjId.objectId}" >
																
																<input type="hidden" name="phoneId${count1}"
																	value="${phonesObjectsListForEdit.phoneId}">
																<input type="hidden" name="editphoneObjectId${count1}"
																	value="${phonesObjectsListForEdit.objectId}">
																	<div class="row">
																        <div class="input-field col s3">
																			<select class="browser-default type1"
																				name="editmanageType${count1}">
																				<option value="${phonesObjectsListForEdit.type}" selected>
																					${phonesObjectsListForEdit.type}</option>
																				<option value="phone">Phone</option>
																				<option value="email">Email</option>
																				<option value="website">Website</option>
																			</select>
																		</div>												
																																										
																		<div class="input-field col s2">
																			<input type="text" value="${phonesObjectsListForEdit.ext}" name="editmanageDetails${count1}"
																				class="materialize-textarea validate"> <label
																				class="active" for="first_name2"></label>
																		</div>
																		
																		<input type="button" value="Delete" class="editmanageremoveButton btn input-field col s1">
																	</div>
																	
															</c:if>
															
														</c:forEach>
														
														
													</div>
													<input type="hidden" value="${count1}" name="editcontactCount" class="editcontactCount" />
												</div>
											<input type='button' style="margin-top:1%"  value='Add New Contact' class='editmanageAddButton btn'>
											</div>
											
											
																										
										
											<div class="">
												<div class="input-field col s12"
													style="margin: 10px 0 0 0px;padding:0 0 0 0">
													<button type="submit" class="btn ">Save</button>
													<button type="reset" class="btn ">Clear</button>
													<br> <br> <br>
												</div>
											</div>

										</form>


									</c:if>
								</c:forEach>
								<!-- End of Displaying Styles -->

							</div>

							<!--End of new popup  -->

						</div>

					</c:forEach>

				</div>
				<div class="modal-footer"></div>
			</div>

		</div>
		<!--End of Directory Edit  -->



		<!--Edit location   -->
		<div class="editLocation"
			style="display: none; opacity: 1; top: 10%; max-height: 50%; padding: 0 25px 0 25px;">
			<div id="editLocation" class="modal">
				<a href="#"
					class="waves-effect waves-green btn-flat modal-action modal-close right">Close</a>
				<div class="modal-content">


					<c:forEach var="locObjForEditLocation"
						items="${locObjForEditLocation}">

						<div class=${locObjForEditLocation.objectId }
							style="display: none; padding: 60px; text-align: justify">

							<form:form action="editLocation" commandName="addLocation"
								enctype="multipart/form-data">

								<!-- hidden fields -->
								<input type="hidden" name="locId"
									value="${locObjForEditLocation.objectId }">
								<input type="hidden" name="directory"
									value="${locObjForEditLocation.directory }">
								<input type="hidden" name="user" value="${user}">
								<input type="hidden" name="userName" value="${userName}">
								<div class="">
									<div class="input-field col s6">
										<input type="text" name="name" required
											value="${locObjForEditLocation.name}"
											style="font-size: 14px; font-weight: normal; padding: 0 10px 0 10px;">
										<label class="active" for="first_name2"
											style="font-size: 14px; font-weight: normal">Hotel Name</label>
									</div>
								</div>
								<div class="">
									<div class="input-field col s6">
										<input type="text" name="siteId" 
											value="${locObjForEditLocation.siteId}"
											style="font-size: 14px; font-weight: normal; padding: 0 10px 0 10px;">
										<label class="active" for="first_name2"
											style="font-size: 14px; font-weight: normal">Group Site ID</label>
									</div>
								</div>
								<div class="">
									<div class="input-field col s6">
										<input type="text" name="address"
											value="${locObjForEditLocation.address}"
											style="font-size: 14px; font-weight: normal; padding: 0 10px 0 10px;">
										<label class="active" for="first_name2"
											style="font-size: 14px; font-weight: normal">Address1</label>
									</div>
								</div>
								<div class="">
									<div class="input-field col s6">
										<input type="text" name="address2"
											value="${locObjForEditLocation.address2}"
											style="font-size: 14px; font-weight: normal; padding: 0 10px 0 10px;">
										<label class="active" for="first_name2"
											style="font-size: 14px; font-weight: normal">Address2</label>
									</div>
								</div>
								<div class="">
									<div class="input-field col s6">
										<input type="text" name="street"
											value="${locObjForEditLocation.street}"
											style="font-size: 14px; font-weight: normal; padding: 0 10px 0 10px;">
										<label class="active" for="first_name2"
											style="font-size: 14px; font-weight: normal">City</label>
									</div>
								</div>
								<div class="">
									<div class="input-field col s6">
										<input type="text" name="town"
											value="${locObjForEditLocation.town}"
											style="font-size: 14px; font-weight: normal; padding: 0 10px 0 10px;">
										<label class="active" for="first_name2"
											style="font-size: 14px; font-weight: normal">State/Province</label>
									</div>
								</div>
								<div class="">
									<div class="input-field col s6">
										<input type="text" name="zipcode" onkeypress="return isNumber(event)"
											value="${locObjForEditLocation.zipcode}"
											style="font-size: 14px; font-weight: normal; padding: 0 10px 0 10px;">
										<label class="active" for="first_name2"
											style="font-size: 14px; font-weight: normal">Zip Code/Postal Code</label>
									</div>
								</div>
								
								<div class="">
									<div class="input-field col s6">
										<input type="text" name="country"
											value="${locObjForEditLocation.country}"
											style="font-size: 14px; font-weight: normal; padding: 0 10px 0 10px;">
										<label class="active" for="first_name2"
											style="font-size: 14px; font-weight: normal">Country</label>
									</div>
								</div> 

								<input type="hidden" name="user" value="${userName}">


								<div class="file-field input-field col s6">
									<div class="btn" style="padding: 0 10px 0 10px;">
										<span>Image</span> <input type="file" name="logo" multiple>
									</div>
									<div class="file-path-wrapper">
										<input class="file-path validate" type="text"
											placeholder="Upload Hotel Image"
											style="font-weight: normal; font-size: 14px">
									</div>
								</div>
								<div class="">
									<div class="input-field col s6">
										<button type="submit" class="btn ">Save</button>
										<button type="reset" class="btn ">Clear</button>
										<br> <br> <br>
									</div>
								</div>
								<!-- 				 <div class="row"> -->
								<!-- 					<div class="file-field input-field"> -->
								<!-- 					  <div class="btn"> -->
								<!-- 						<span>File</span> -->
								<!-- 						<input type="file" name="Logo" onchange="dreadURL(this);"> -->

								<!-- 					  </div> -->
								<!-- 					  <div class="file-path-wrapper"> -->
								<!-- 						<input class="file-path validate" type="text" placeholder="Upload one or more files"> -->
								<!-- 					  </div> -->
								<!-- 					</div> -->
								<!-- 			  	</div> -->

							</form:form>

						</div>

					</c:forEach>
				</div>
				<div class="modal-footer"></div>
			</div>
		</div>
		<!--End of edit location objects  -->


		<!--Deleting Location  -->
		<div class="deleteLocation"
			style="display: none; opacity: 1; top: 10%; max-height: 50%; padding: 0 25px 0 25px;">
			<div id="deleteLocation" class="modal">
				<a href="#"
					class="waves-effect waves-green btn-flat modal-action modal-close right">Close</a>
				<div class="modal-content">


					<c:forEach var="locObjForDeleteLocation"
						items="${locObjForEditLocation}">

						<div class=${locObjForDeleteLocation.objectId }
							style="display: none; padding: 60px; text-align: justify">

							<a>Are you Sure To delete the Following Location and it's
								DirectoryItems</a>


							<form action="deleteLocation" method="post">

								"${locObjForDeleteLocation.name}" <input type="hidden"
									value="${locObjForDeleteLocation.objectId}"
									name="objectIdForDeleteLocation"> <input type="hidden"
									value="${userName}" name="userName"> <input
									type="hidden" value="${user}" name="user">
								<button class="btn btn-sm" type="submit"
									style="float: right; background-color: #46A597; border-radius: 5px; margin: 25px 30px 0 0px;">
									Delete</button>

							</form>

						</div>

					</c:forEach>
				</div>
				<div class="modal-footer"></div>
			</div>
		</div>

		<!--End of Deleting Location  -->




		<!--start of Add Diretory  -->
		<div class="addDirectoryPopup"
			style="display: none; margin-top: 10px; padding: 40px 20px 40px 20px;">

			<div id="addDirectory" class="modal" style="width:70%">
				<a href="#"
					class="waves-effect waves-green btn-flat modal-action modal-close right">Close</a>
				<div class="modal-content">


					<c:forEach var="locObjForAddDirectoryItems"
						items="${locObjForAddDirectoryItems }">

						<div class="${locObjForAddDirectoryItems.objectId}"
							style="display: none;">
							<div class="row">
								<form:form class="col s12" action="addDirectory" method="post"
									commandName="addDirectory" enctype="multipart/form-data">

									<!--Hidden values  -->
									<input type="hidden"
										value="${locObjForAddDirectoryItems.objectId}"
										name="objectIdOfLocation">
									<input type="hidden" value="${userName}" name="userName">
									<input type="hidden" value="${user}" name="user">
									<!--Displaying Title  -->
									<!--Displaying Title  -->
											<div class="row">
												<div class="input-field col s3">
													<input name="title" type="text" class="title" required
														style="font-weight: normal; font-size: 14px"> <label
														class="active"
														style="font-weight: normal; font-size: 14px">Title</label>

												</div>
												<div class="input-field col s2">
													<input type="text" class="color" name="titleColor" class="titleColor"
														value="3623DB"
														style="font-weight: normal; font-size: 14px"> <label
														class="active"
														style="font-weight: normal; font-size: 14px">Color</label>

												</div>
												<div class="input-field col s2">
													<select class="browser-default" name="titleFont">
														<option value="initial" style="font-size: initial" selected>initial</option>
														<option value="xx-small" style="font-size: xx-small">xx-small</option>
														<option value="x-small" style="font-size: x-small">x-small</option>
														<option value="small" style="font-size: small">small</option>
														<option value="medium" style="font-size: medium">medium</option>
														<option value="large" style="font-size: large">large</option>
														<option value="x-large" style="font-size: x-large">x-large</option>
														<option value="xx-large" style="font-size: xx-large">xx-large</option>
														<option value="smaller" style="font-size: smaller">smaller</option>
														<option value="larger" style="font-size: larger">larger</option>
														
													</select>

												</div>
												<div class="input-field col s3">
													<select class="browser-default" name="titleFamily">
														
														<option value="Courier New" style="font-family:Courier New" selected>Courier New</option>
														<option value="Lucida Console" style="font-family:Lucida Console">Lucida Console</option>
														<option value="Verdana" style="font-family:Verdana">Verdana</option>
														<option value="Trebuchet MS" style="font-family:Trebuchet MS">sans-serif</option>
														<option value="Tahoma" style="font-family:Tahoma">Tahoma</option>
														<option value="Lucida Sans Unicode" style="font-family:Lucida Sans Unicode">Lucida Sans Unicode</option>
														<option value="Charcoal" style="font-family:Charcoal">Charcoal</option>
														<option value="Comic Sans MS" style="font-family:Comic Sans MS">Comic Sans MS</option>
														<option value="Arial Black" style="font-family:Arial Black">Arial Black</option>
														<option value="Arial" style="font-family:Arial">Arial</option>
														<option value="Times New Roman" style="font-family:Times New Roman">Times New Roman</option>
														<option value="Palatino Linotype" style="font-family:Palatino Linotype">Palatino Linotype</option>
														<option value="Georgia" style="font-family:Georgia">Georgia</option>
														
													</select>
		
												</div>
											</div>

											<!--Displaying Caption  -->
											<div class="row">
												<div class="input-field col s3">
													<input type="text" name="caption" class="caption" 
														style="font-weight: normal; font-size: 14px"> <label
														class="active"
														style="font-weight: normal; font-size: 14px">Caption</label>
												</div>
												<div class="input-field col s2">
													<input type="text" name="captionColor" 
														value="3623DB"
														class="color captionColor" style="font-weight: normal; font-size: 14px">
													<label class="active"
														style="font-weight: normal; font-size: 14px">Color</label>

												</div>
												<div class="input-field col s2">
													<select class="browser-default" name="captionFont">
														<option value="initial" style="font-size: initial" selected>initial</option>
														<option value="xx-small" style="font-size: xx-small">xx-small</option>
														<option value="x-small" style="font-size: x-small">x-small</option>
														<option value="small" style="font-size: small">small</option>
														<option value="medium" style="font-size: medium">medium</option>
														<option value="large" style="font-size: large">large</option>
														<option value="x-large" style="font-size: x-large">x-large</option>
														<option value="xx-large" style="font-size: xx-large">xx-large</option>
														<option value="smaller" style="font-size: smaller">smaller</option>
														<option value="larger" style="font-size: larger">larger</option>
													</select>

												</div>
												<div class="input-field col s3">
													<select class="browser-default" name="captionFamily">
														
														<option value="Courier New" style="font-family:Courier New" selected>Courier New</option>
														<option value="Lucida Console" style="font-family:Lucida Console">Lucida Console</option>
														<option value="Verdana" style="font-family:Verdana">Verdana</option>
														<option value="Trebuchet MS" style="font-family:Trebuchet MS">sans-serif</option>
														<option value="Tahoma" style="font-family:Tahoma">Tahoma</option>
														<option value="Lucida Sans Unicode" style="font-family:Lucida Sans Unicode">Lucida Sans Unicode</option>
														<option value="Charcoal" style="font-family:Charcoal">Charcoal</option>
														<option value="Comic Sans MS" style="font-family:Comic Sans MS">Comic Sans MS</option>
														<option value="Arial Black" style="font-family:Arial Black">Arial Black</option>
														<option value="Arial" style="font-family:Arial">Arial</option>
														<option value="Times New Roman" style="font-family:Times New Roman">Times New Roman</option>
														<option value="Palatino Linotype" style="font-family:Palatino Linotype">Palatino Linotype</option>
														<option value="Georgia" style="font-family:Georgia">Georgia</option>
														
													</select>
		
												</div>
											</div>


											<!-- Displaying Timings -->
											<div class="row">
												<div class="input-field col s3">
													<input type="text" class="validate" name="timings" class="timings"
														 style="font-weight: normal; font-size: 14px"> <label
														class="active"
														style="font-weight: normal; font-size: 14px">Timings</label>
												</div>
												<div class="input-field col s2">
													<input type="text" class="color" name="timingsColor" class="timingsColor"
														 value="3623DB"
														style="font-weight: normal; font-size: 14px"> <label
														class="active" for="last_name"
														style="font-weight: normal; font-size: 14px">Color</label>
												</div>
												<div class="input-field col s2">
													<select class="browser-default" name="timingsFont">
														<option value="initial" style="font-size: initial" selected>initial</option>
														<option value="xx-small" style="font-size: xx-small">xx-small</option>
														<option value="x-small" style="font-size: x-small">x-small</option>
														<option value="small" style="font-size: small">small</option>
														<option value="medium" style="font-size: medium">medium</option>
														<option value="large" style="font-size: large">large</option>
														<option value="x-large" style="font-size: x-large">x-large</option>
														<option value="xx-large" style="font-size: xx-large">xx-large</option>
														<option value="smaller" style="font-size: smaller">smaller</option>
														<option value="larger" style="font-size: larger">larger</option>
													</select>

												</div>
												<div class="input-field col s3">
													<select class="browser-default" name="timingsFamily">
														
														<option value="Courier New" style="font-family:Courier New" selected>Courier New</option>
														<option value="Lucida Console" style="font-family:Lucida Console">Lucida Console</option>
														<option value="Verdana" style="font-family:Verdana">Verdana</option>
														<option value="Trebuchet MS" style="font-family:Trebuchet MS">sans-serif</option>
														<option value="Tahoma" style="font-family:Tahoma">Tahoma</option>
														<option value="Lucida Sans Unicode" style="font-family:Lucida Sans Unicode">Lucida Sans Unicode</option>
														<option value="Charcoal" style="font-family:Charcoal">Charcoal</option>
														<option value="Comic Sans MS" style="font-family:Comic Sans MS">Comic Sans MS</option>
														<option value="Arial Black" style="font-family:Arial Black">Arial Black</option>
														<option value="Arial" style="font-family:Arial">Arial</option>
														<option value="Times New Roman" style="font-family:Times New Roman">Times New Roman</option>
														<option value="Palatino Linotype" style="font-family:Palatino Linotype">Palatino Linotype</option>
														<option value="Georgia" style="font-family:Georgia">Georgia</option>
													</select>
		
												</div>
											</div>

											
											
											<!--Displaying Description -  -->
											<div class="row">
												<div class="input-field col s5">
													<input type="text" name="description" required class="description validate" 
														style="font-weight: normal; font-size: 14px"> <label
														class="active" for="first_name2"
														style="font-weight: normal; font-size: 14px">Description</label>
												</div>
												<div class="input-field col s2">
													<input type="text" name="descriptionColor" value="3623DB" 
														class="color descriptionColor"
														style="font-weight: normal; font-size: 14px"> <label
														class="active" for="last_name"
														style="font-weight: normal; font-size: 14px">Color</label>
												</div>
												<div class="input-field col s2">
													<select class="browser-default" name="descriptionFont">
														<option value="initial" style="font-size: initial" selected>initial</option>
														<option value="xx-small" style="font-size: xx-small">xx-small</option>
														<option value="x-small" style="font-size: x-small">x-small</option>
														<option value="small" style="font-size: small">small</option>
														<option value="medium" style="font-size: medium">medium</option>
														<option value="large" style="font-size: large">large</option>
														<option value="x-large" style="font-size: x-large">x-large</option>
														<option value="xx-large" style="font-size: xx-large">xx-large</option>
														<option value="smaller" style="font-size: smaller">smaller</option>
														<option value="larger" style="font-size: larger">larger</option>
													</select>

												</div>
												<div class="input-field col s3">
													<select class="browser-default" name="descriptionFamily">
														
														<option value="Courier New" style="font-family:Courier New" selected>Courier New</option>
														<option value="Lucida Console" style="font-family:Lucida Console">Lucida Console</option>
														<option value="Verdana" style="font-family:Verdana">Verdana</option>
														<option value="Trebuchet MS" style="font-family:Trebuchet MS">sans-serif</option>
														<option value="Tahoma" style="font-family:Tahoma">Tahoma</option>
														<option value="Lucida Sans Unicode" style="font-family:Lucida Sans Unicode">Lucida Sans Unicode</option>
														<option value="Charcoal" style="font-family:Charcoal">Charcoal</option>
														<option value="Comic Sans MS" style="font-family:Comic Sans MS">Comic Sans MS</option>
														<option value="Arial Black" style="font-family:Arial Black">Arial Black</option>
														<option value="Arial" style="font-family:Arial">Arial</option>
														<option value="Times New Roman" style="font-family:Times New Roman">Times New Roman</option>
														<option value="Palatino Linotype" style="font-family:Palatino Linotype">Palatino Linotype</option>
														<option value="Georgia" style="font-family:Georgia">Georgia</option>
													</select>
		
												</div>
											</div>

											<div class="row">
												<div class="input-field col s3">
													<input type="text" name="customizeNumber" class="description " 
														placeholder="Enter a Number" style="font-weight: normal; font-size: 14px" onkeypress="return isNumber(event)"> <label
														class="active" for="first_name2"
														style="font-weight: normal; font-size: 14px" >Customized Display Order</label>
												</div>
											</div>
																						
											
											<div class="file-field input-field col s12">
												<div class="btn"
													style="padding: 0 10px 0 10px; margin: 0 0 0 0px;">
													<span>Image</span> <input type="file" name="logo" multiple>
												</div>
												<div class="file-path-wrapper ">
													<input class="file-path validate col s6" type="text"
														placeholder="Upload Directory Image"
														style="font-weight: normal; font-size: 14px; margin: 0 0 0 70px">
												</div>
											</div>
											
											
											
											<div class="row">
											  	          
									          <div class="input-field col s3 m3 l3">
									              <input type="checkbox" id="check:${locObjForAddDirectoryItems.objectId}" onclick="handleClick(this.id);"/>
									              <label for="check:${locObjForAddDirectoryItems.objectId}">Add Menu</label>
									          </div>
									          
									          <div class="input-field col s1 m1 l1"></div>
									          
									          <div class="input-field col s3 m3 l3">
									              <input type="checkbox" id="contact:${locObjForAddDirectoryItems.objectId}" onclick="contactClick(this.id);"/>
									              <label for="contact:${locObjForAddDirectoryItems.objectId}">Add Contacts</label>
									          </div>
									          
									          <div class="input-field col s2 m2 l2"></div>
									          <div class="input-field col s3 m3 l3" >
									              <p class="btn" style="display:none" id="manage${locObjForAddDirectoryItems.objectId}"> Manage MenuItems </p>
									          </div>
									        </div>
											<hr style="border-style:solid;margin-top:3%;display:none" class="hr">
											
											<div class=""  id="menu${locObjForAddDirectoryItems.objectId}" style="display:none">
												
														<div class="row">	
															
															<div class="input-field col s2">
																<input type="text" name="priceColor"
																	value="3623DB"
																	class="color colors1"
																	style="font-weight: normal; font-size: 14px"> <label
																	class="active" for="last_name"
																	style="font-weight: normal; font-size: 14px">Color</label>
															</div>
															<div class="input-field col s3">
																<select class="browser-default font1" name="priceFont">
																	<option value="initial" style="font-size: initial" selected>initial</option>
																	<option value="xx-small" style="font-size: xx-small">xx-small</option>
																	<option value="x-small" style="font-size: x-small">x-small</option>
																	<option value="small" style="font-size: small">small</option>
																	<option value="medium" style="font-size: medium">medium</option>
																	<option value="large" style="font-size: large">large</option>
																	<option value="x-large" style="font-size: x-large">x-large</option>
																	<option value="xx-large" style="font-size: xx-large">xx-large</option>
																	<option value="smaller" style="font-size: smaller">smaller</option>
																	<option value="larger" style="font-size: larger">larger</option>
																</select>
			
															</div>
															<div class="input-field col s3">
																<select class="browser-default family1" name="priceFamily">
																	
														<option value="Courier New" style="font-family:Courier New" selected>Courier New</option>
														<option value="Lucida Console" style="font-family:Lucida Console">Lucida Console</option>
														<option value="Verdana" style="font-family:Verdana">Verdana</option>
														<option value="Trebuchet MS" style="font-family:Trebuchet MS">sans-serif</option>
														<option value="Tahoma" style="font-family:Tahoma">Tahoma</option>
														<option value="Lucida Sans Unicode" style="font-family:Lucida Sans Unicode">Lucida Sans Unicode</option>
														<option value="Charcoal" style="font-family:Charcoal">Charcoal</option>
														<option value="Comic Sans MS" style="font-family:Comic Sans MS">Comic Sans MS</option>
														<option value="Arial Black" style="font-family:Arial Black">Arial Black</option>
														<option value="Arial" style="font-family:Arial">Arial</option>
														<option value="Times New Roman" style="font-family:Times New Roman">Times New Roman</option>
														<option value="Palatino Linotype" style="font-family:Palatino Linotype">Palatino Linotype</option>
														<option value="Georgia" style="font-family:Georgia">Georgia</option>
																	
																</select>
					
															</div>
														</div>	
											<div class="">	
												<div class='TextBoxesGroup'>
													<div class="TextBoxDiv1">
														<div class="row">
															
															<div class="input-field col s4">
																<input type="text" class="description1" name="menuDescription1"
																	style="font-weight: normal; font-size: 14px"> <label
																	class="active" for="first_name2"
																	style="font-weight: normal; font-size: 14px">MenuItem Description</label>
															</div>
															
															
															
															<div class="input-field col s2">
																<input type="text" class="price1" name="menuPrice1"
																	style="font-weight: normal; font-size: 14px"> <label
																	class="active" for="first_name2"
																	style="font-weight: normal; font-size: 14px">Price</label>
															</div>
															
															
																<input type='button' value='Delete' class='removeButton btn input-field col s1'>
															
															
															
															
															
															
														  </div>
														</div>
													</div>
													<div class="left">
														<input type='button'  value='Add Menu Item' class='addButton btn' style="padding:0 47px 0 47px">
														
														<!-- <input type='button' value='Save' class='getButtonValue btn'> -->
													</div>
												</div>
												
											
											</div>
											
											<hr style="border-style:solid;margin-top:8%;display:none" class="hr1">
											
											<div class="col s12"  id="contact${locObjForAddDirectoryItems.objectId}" style="display:none;padding:0 0 0 0">
												<div class='manageTextBoxesGroup' >
													<div class="manageTextBoxDiv1">
														<div class="row">
															<div class="input-field col s3">
																<select class="browser-default type1"
																	name="manageType1">
																	<option value="" disabled selected>
																		Phone/Email/Website</option>
																	<option value="phone">Phone</option>
																	<option value="email">Email</option>
																	<option value="website">Website</option>
																</select>
															</div>
															
															<div class="input-field col s2" >
																<input type="text" name="manageDetails1"
																	class="details1"> <label for="textbox1">
																	</label>
															</div>
															<input type='button' value='Delete' class='manageRemoveButton btn input-field col s1'>
															
														</div>
														
													</div>
												</div>
											<input type='button'  value='Add Contacts' class='manageAddButton btn'>
											</div>

									<input type="hidden" class="counter" name="counter" value="0" />
									<input type="hidden" value="0" name="manageCount" class="manageCount"/>
									<div class="">
										<div class="input-field col s12"
											style="margin: 10px 0 0 0px;padding:0 0 0 0">
											<button type="submit" class="btn ">Save</button>
											<button type="reset" class="btn ">Clear</button>
											<br> <br> <br>
										</div>
									</div>

								</form:form>


							</div>
						</div>
					</c:forEach>
				</div>
				<div class="modal-footer"></div>
			</div>
		</div>
		<!-- End of Add Directory -->



		<!--Displaying Deleted files -->
		<div class="delPopup"
			style="display: none; margin-top: 10px; padding: 40px 20px 40px 20px;">


			<div id="delete" class="modal">
				<a href="#"
					class="waves-effect waves-green btn-flat modal-action modal-close right">Close</a>
				<div class="modal-content">

					<c:forEach var="showDiscriptionObjId"
						items="${showDiscriptionObjId }">
						<div>

							<div class=${showDiscriptionObjId.objectId }
								style="display: none; text-align: justify">

								<a>Are you Sure To delete the this directory</a>

								<form action="delete">

									${showDiscriptionObjId.title} <input type="hidden"
										value="${showDiscriptionObjId.objectId}"
										name="objectIdForDelete"> <input type="hidden"
										value="${showDiscriptionObjId.directoryId}" name="directoryId">
									<input type="hidden"
										value="${showDiscriptionObjId.parentDirectoryId}"
										name="parentDirectoryId"> <input type="hidden"
										value="${showDiscriptionObjId.locationId}" name="locationId">
									<input type="hidden" value="${userName}" name="userName">
									<input type="hidden" value="${user}" name="user">
									<button class="btn btn-sm" type="submit"
										style="float: right; background-color: #46A597; border-radius: 5px; margin: 25px 30px 0 0px;">
										Delete</button>

								</form>

							</div>

						</div>
					</c:forEach>

				</div>
				<div class="modal-footer"></div>
			</div>

		</div>
		<!--End of Delete items  -->
		
		<!--start of manage Details  -->
		<div class="manageDetailsPopup"
			style="display: none; opacity: 1; top: 10%; max-height: 50%">

			<div id="manage" class="modal" style="width: 60%">
				<a href="#"
					class="waves-effect waves-green btn-flat modal-action modal-close right">Close</a>
				<div class="modal-content">
					<!-- manage details -->
					<c:forEach var="DiscriptionObjForNavBar"
						items="${DiscriptionObjForNavBar }">
						<div class="${DiscriptionObjForNavBar.objectId}"
							style="display: none;" value="${DiscriptionObjForNavBar.objectId}" name="phoneId">
						
							
							<form:form action="manageDetails" method="post">
							
										<!--Hidden values  -->
											<input type="hidden"
												value="${DiscriptionObjForNavBar.objectId}"
												name="objectId">
											<input type="hidden"
												value="${DiscriptionObjForNavBar.directoryId}"
												name="directoryId">
											<input type="hidden"
												value="${DiscriptionObjForNavBar.styleId}"
												name="styleId">
											<input type="hidden"
												value="${DiscriptionObjForNavBar.objectId}"
												name="phoneId">
											
											<input type="hidden"
												value="${DiscriptionObjForNavBar.locationId}"
												name="locationId">
											

											<input type="hidden" value="${userName}" name="userName">
											<input type="hidden" value="${user}" name="user">
							
								
								
								
								
								<button type="submit" class="btn waves-effect waves-light">Save</button>
							</form:form>



						</div>

					</c:forEach>

				</div>
				<div class="modal-footer"></div>
			</div>



		</div>


		<!--end of manage Details  -->
		

		<!--Start of add Directory Items  -->
		<div class="addDirectoryItemsPopup"
			style="display: none; opacity: 1; top: 10%; max-height: 50%">

			<div id="add" class="modal" style="width:75%">
				<a href="#"
					class="waves-effect waves-green btn-flat modal-action modal-close right">Close</a>
				<div class="modal-content">


					<c:forEach var="subDiscriptionObjForAddDirItems"
						items="${subDiscriptionObjForAddDirItems }">

						<div class="${subDiscriptionObjForAddDirItems.objectId}"
							style="display: none;">
							<!--Start of Displaying Add Disrectory Items Form  -->
							<!-- new popup -->
							<div class="row">
								<!--Displayingf Styles  -->
								<c:forEach var="styleObjectsForAddDirItems"
									items="${styleObjectsForAddDirItems }">

									<c:if
										test="${subDiscriptionObjForAddDirItems.styleId eq styleObjectsForAddDirItems.objectId }">



										<form:form class="col s12" action="addDirectoryItems"
											method="post" commandName="addLocation"
											enctype="multipart/form-data">

											<!--Hidden values  -->
											<input type="hidden"
												value="${subDiscriptionObjForAddDirItems.objectId}"
												name="objectId">
											<input type="hidden"
												value="${subDiscriptionObjForAddDirItems.directoryId}"
												name="directoryId">
											<input type="hidden"
												value="${subDiscriptionObjForAddDirItems.styleId}"
												name="styleId">
											<input type="hidden"
												value="${subDiscriptionObjForAddDirItems.phones}"
												name="phones">
											<input type="hidden"
												value="${subDiscriptionObjForAddDirItems.locationId}"
												name="locationId">
											

											<input type="hidden" value="${userName}" name="userName">
											<input type="hidden" value="${user}" name="user">
											<!--Displaying Title  -->
											<div class="row">
												<div class="input-field col s3">
													<input name="title" type="text" class="title" required
														style="font-weight: normal; font-size: 14px"> <label
														class="active"
														style="font-weight: normal; font-size: 14px">Title</label>

												</div>
												<div class="input-field col s2">
													<input type="text" class="color" name="titleColor" class="titleColor"
														value="3623DB"
														style="font-weight: normal; font-size: 14px"> <label
														class="active"
														style="font-weight: normal; font-size: 14px">Color</label>

												</div>
												<div class="input-field col s2">
													<select class="browser-default" name="titleFont">
														<option value="initial" style="font-size: initial" selected>initial</option>
														<option value="xx-small" style="font-size: xx-small">xx-small</option>
														<option value="x-small" style="font-size: x-small">x-small</option>
														<option value="small" style="font-size: small">small</option>
														<option value="medium" style="font-size: medium">medium</option>
														<option value="large" style="font-size: large">large</option>
														<option value="x-large" style="font-size: x-large">x-large</option>
														<option value="xx-large" style="font-size: xx-large">xx-large</option>
														<option value="smaller" style="font-size: smaller">smaller</option>
														<option value="larger" style="font-size: larger">larger</option>
														
													</select>

												</div>
												<div class="input-field col s3">
													<select class="browser-default" name="titleFamily">
														
														<option value="Courier New" style="font-family:Courier New" selected>Courier New</option>
														<option value="Lucida Console" style="font-family:Lucida Console">Lucida Console</option>
														<option value="Verdana" style="font-family:Verdana">Verdana</option>
														<option value="Trebuchet MS" style="font-family:Trebuchet MS">sans-serif</option>
														<option value="Tahoma" style="font-family:Tahoma">Tahoma</option>
														<option value="Lucida Sans Unicode" style="font-family:Lucida Sans Unicode">Lucida Sans Unicode</option>
														<option value="Charcoal" style="font-family:Charcoal">Charcoal</option>
														<option value="Comic Sans MS" style="font-family:Comic Sans MS">Comic Sans MS</option>
														<option value="Arial Black" style="font-family:Arial Black">Arial Black</option>
														<option value="Arial" style="font-family:Arial">Arial</option>
														<option value="Times New Roman" style="font-family:Times New Roman">Times New Roman</option>
														<option value="Palatino Linotype" style="font-family:Palatino Linotype">Palatino Linotype</option>
														<option value="Georgia" style="font-family:Georgia">Georgia</option>
														
													</select>
		
												</div>
											</div>

											<!--Displaying Caption  -->
											<div class="row">
												<div class="input-field col s3">
													<input type="text" name="caption" class="caption" 
														style="font-weight: normal; font-size: 14px"> <label
														class="active"
														style="font-weight: normal; font-size: 14px">Caption</label>
												</div>
												<div class="input-field col s2">
													<input type="text" name="captionColor" 
														value="3623DB"
														class="color captionColor" style="font-weight: normal; font-size: 14px">
													<label class="active"
														style="font-weight: normal; font-size: 14px">Color</label>

												</div>
												<div class="input-field col s2">
													<select class="browser-default" name="captionFont">
														<option value="initial" style="font-size: initial" selected>initial</option>
														<option value="xx-small" style="font-size: xx-small">xx-small</option>
														<option value="x-small" style="font-size: x-small">x-small</option>
														<option value="small" style="font-size: small">small</option>
														<option value="medium" style="font-size: medium">medium</option>
														<option value="large" style="font-size: large">large</option>
														<option value="x-large" style="font-size: x-large">x-large</option>
														<option value="xx-large" style="font-size: xx-large">xx-large</option>
														<option value="smaller" style="font-size: smaller">smaller</option>
														<option value="larger" style="font-size: larger">larger</option>
													</select>

												</div>
												<div class="input-field col s3">
													<select class="browser-default" name="captionFamily">
														
														<option value="Courier New" style="font-family:Courier New" selected>Courier New</option>
														<option value="Lucida Console" style="font-family:Lucida Console">Lucida Console</option>
														<option value="Verdana" style="font-family:Verdana">Verdana</option>
														<option value="Trebuchet MS" style="font-family:Trebuchet MS">sans-serif</option>
														<option value="Tahoma" style="font-family:Tahoma">Tahoma</option>
														<option value="Lucida Sans Unicode" style="font-family:Lucida Sans Unicode">Lucida Sans Unicode</option>
														<option value="Charcoal" style="font-family:Charcoal">Charcoal</option>
														<option value="Comic Sans MS" style="font-family:Comic Sans MS">Comic Sans MS</option>
														<option value="Arial Black" style="font-family:Arial Black">Arial Black</option>
														<option value="Arial" style="font-family:Arial">Arial</option>
														<option value="Times New Roman" style="font-family:Times New Roman">Times New Roman</option>
														<option value="Palatino Linotype" style="font-family:Palatino Linotype">Palatino Linotype</option>
														<option value="Georgia" style="font-family:Georgia">Georgia</option>
														
													</select>
		
												</div>
											</div>


											<!-- Displaying Timings -->
											<div class="row">
												<div class="input-field col s3">
													<input type="text" class="validate" name="timings" class="timings"
														 style="font-weight: normal; font-size: 14px"> <label
														class="active"
														style="font-weight: normal; font-size: 14px">Timings</label>
												</div>
												<div class="input-field col s2">
													<input type="text" class="color" name="timingsColor" class="timingsColor"
														 value="3623DB"
														style="font-weight: normal; font-size: 14px"> <label
														class="active" for="last_name"
														style="font-weight: normal; font-size: 14px">Color</label>
												</div>
												<div class="input-field col s2">
													<select class="browser-default" name="timingsFont">
														<option value="initial" style="font-size: initial" selected>initial</option>
														<option value="xx-small" style="font-size: xx-small">xx-small</option>
														<option value="x-small" style="font-size: x-small">x-small</option>
														<option value="small" style="font-size: small">small</option>
														<option value="medium" style="font-size: medium">medium</option>
														<option value="large" style="font-size: large">large</option>
														<option value="x-large" style="font-size: x-large">x-large</option>
														<option value="xx-large" style="font-size: xx-large">xx-large</option>
														<option value="smaller" style="font-size: smaller">smaller</option>
														<option value="larger" style="font-size: larger">larger</option>
													</select>

												</div>
												<div class="input-field col s3">
													<select class="browser-default" name="timingsFamily">
														
														<option value="Courier New" style="font-family:Courier New" selected>Courier New</option>
														<option value="Lucida Console" style="font-family:Lucida Console">Lucida Console</option>
														<option value="Verdana" style="font-family:Verdana">Verdana</option>
														<option value="Trebuchet MS" style="font-family:Trebuchet MS">sans-serif</option>
														<option value="Tahoma" style="font-family:Tahoma">Tahoma</option>
														<option value="Lucida Sans Unicode" style="font-family:Lucida Sans Unicode">Lucida Sans Unicode</option>
														<option value="Charcoal" style="font-family:Charcoal">Charcoal</option>
														<option value="Comic Sans MS" style="font-family:Comic Sans MS">Comic Sans MS</option>
														<option value="Arial Black" style="font-family:Arial Black">Arial Black</option>
														<option value="Arial" style="font-family:Arial">Arial</option>
														<option value="Times New Roman" style="font-family:Times New Roman">Times New Roman</option>
														<option value="Palatino Linotype" style="font-family:Palatino Linotype">Palatino Linotype</option>
														<option value="Georgia" style="font-family:Georgia">Georgia</option>
													</select>
		
												</div>
											</div>

											
											
											<!--Displaying Description -  -->
											<div class="row">
												<div class="input-field col s5">
													<input type="text" name="description" required class="description validate" 
														style="font-weight: normal; font-size: 14px"> <label
														class="active" for="first_name2"
														style="font-weight: normal; font-size: 14px">Description</label>
												</div>
												<div class="input-field col s2">
													<input type="text" name="descriptionColor" value="3623DB" 
														class="color descriptionColor"
														style="font-weight: normal; font-size: 14px"> <label
														class="active" for="last_name"
														style="font-weight: normal; font-size: 14px">Color</label>
												</div>
												<div class="input-field col s2">
													<select class="browser-default" name="descriptionFont">
														<option value="initial" style="font-size: initial" selected>initial</option>
														<option value="xx-small" style="font-size: xx-small">xx-small</option>
														<option value="x-small" style="font-size: x-small">x-small</option>
														<option value="small" style="font-size: small">small</option>
														<option value="medium" style="font-size: medium">medium</option>
														<option value="large" style="font-size: large">large</option>
														<option value="x-large" style="font-size: x-large">x-large</option>
														<option value="xx-large" style="font-size: xx-large">xx-large</option>
														<option value="smaller" style="font-size: smaller">smaller</option>
														<option value="larger" style="font-size: larger">larger</option>
													</select>

												</div>
												<div class="input-field col s3">
													<select class="browser-default" name="descriptionFamily">
														
														<option value="Courier New" style="font-family:Courier New" selected>Courier New</option>
														<option value="Lucida Console" style="font-family:Lucida Console">Lucida Console</option>
														<option value="Verdana" style="font-family:Verdana">Verdana</option>
														<option value="Trebuchet MS" style="font-family:Trebuchet MS">sans-serif</option>
														<option value="Tahoma" style="font-family:Tahoma">Tahoma</option>
														<option value="Lucida Sans Unicode" style="font-family:Lucida Sans Unicode">Lucida Sans Unicode</option>
														<option value="Charcoal" style="font-family:Charcoal">Charcoal</option>
														<option value="Comic Sans MS" style="font-family:Comic Sans MS">Comic Sans MS</option>
														<option value="Arial Black" style="font-family:Arial Black">Arial Black</option>
														<option value="Arial" style="font-family:Arial">Arial</option>
														<option value="Times New Roman" style="font-family:Times New Roman">Times New Roman</option>
														<option value="Palatino Linotype" style="font-family:Palatino Linotype">Palatino Linotype</option>
														<option value="Georgia" style="font-family:Georgia">Georgia</option>
													</select>
		
												</div>
											</div>

											<div class="row">
												<div class="input-field col s3">
													<input type="text" name="customizeNumber" class="description " 
														placeholder="Enter a Number" style="font-weight: normal; font-size: 14px" onkeypress="return isNumber(event)"> <label
														class="active" for="first_name2"
														style="font-weight: normal; font-size: 14px" >Customized Display Order</label>
												</div>
											</div>
																						
											
											<div class="file-field input-field col s12">
												<div class="btn"
													style="padding: 0 10px 0 10px; margin: 0 0 0 0px;">
													<span>Image</span> <input type="file" name="logo" multiple>
												</div>
												<div class="file-path-wrapper ">
													<input class="file-path validate col s6" type="text"
														placeholder="Upload Directory Image"
														style="font-weight: normal; font-size: 14px; margin: 0 0 0 70px">
												</div>
											</div>
											
											
											
											<div class="row">
											  	          
									          <div class="input-field col s3 m3 l3">
									              <input type="checkbox" id="check:${subDiscriptionObjForAddDirItems.objectId}" onclick="handleClick(this.id);"/>
									              <label for="check:${subDiscriptionObjForAddDirItems.objectId}">Add Menu</label>
									          </div>
									          
									          <div class="input-field col s1 m1 l1"></div>
									          
									          <div class="input-field col s3 m3 l3">
									              <input type="checkbox" id="contact:${subDiscriptionObjForAddDirItems.objectId}" onclick="contactClick(this.id);"/>
									              <label for="contact:${subDiscriptionObjForAddDirItems.objectId}">Add Contacts</label>
									          </div>
									          
									          <div class="input-field col s2 m2 l2"></div>
									          <div class="input-field col s3 m3 l3" >
									              <p class="btn" style="display:none" id="manage${subDiscriptionObjForAddDirItems.objectId}"> Manage MenuItems </p>
									          </div>
									        </div>
											<hr style="border-style:solid;margin-top:3%;display:none" class="hr">
											
											<div class=""  id="menu${subDiscriptionObjForAddDirItems.objectId}" style="display:none">
												
														<div class="row">	
															
															<div class="input-field col s2">
																<input type="text" name="priceColor"
																	value="3623DB"
																	class="color colors1"
																	style="font-weight: normal; font-size: 14px"> <label
																	class="active" for="last_name"
																	style="font-weight: normal; font-size: 14px">Color</label>
															</div>
															<div class="input-field col s3">
																<select class="browser-default font1" name="priceFont">
																	<option value="initial" style="font-size: initial" selected>initial</option>
																	<option value="xx-small" style="font-size: xx-small">xx-small</option>
																	<option value="x-small" style="font-size: x-small">x-small</option>
																	<option value="small" style="font-size: small">small</option>
																	<option value="medium" style="font-size: medium">medium</option>
																	<option value="large" style="font-size: large">large</option>
																	<option value="x-large" style="font-size: x-large">x-large</option>
																	<option value="xx-large" style="font-size: xx-large">xx-large</option>
																	<option value="smaller" style="font-size: smaller">smaller</option>
																	<option value="larger" style="font-size: larger">larger</option>
																</select>
			
															</div>
															<div class="input-field col s3">
																<select class="browser-default family1" name="priceFamily">
																	
														<option value="Courier New" style="font-family:Courier New" selected>Courier New</option>
														<option value="Lucida Console" style="font-family:Lucida Console">Lucida Console</option>
														<option value="Verdana" style="font-family:Verdana">Verdana</option>
														<option value="Trebuchet MS" style="font-family:Trebuchet MS">sans-serif</option>
														<option value="Tahoma" style="font-family:Tahoma">Tahoma</option>
														<option value="Lucida Sans Unicode" style="font-family:Lucida Sans Unicode">Lucida Sans Unicode</option>
														<option value="Charcoal" style="font-family:Charcoal">Charcoal</option>
														<option value="Comic Sans MS" style="font-family:Comic Sans MS">Comic Sans MS</option>
														<option value="Arial Black" style="font-family:Arial Black">Arial Black</option>
														<option value="Arial" style="font-family:Arial">Arial</option>
														<option value="Times New Roman" style="font-family:Times New Roman">Times New Roman</option>
														<option value="Palatino Linotype" style="font-family:Palatino Linotype">Palatino Linotype</option>
														<option value="Georgia" style="font-family:Georgia">Georgia</option>
																	
																</select>
					
															</div>
														</div>	
											<div class="">	
												<div class='TextBoxesGroup'>
													<div class="TextBoxDiv1">
														<div class="row">
															
															<div class="input-field col s4">
																<input type="text" class="description1" name="menuDescription1"
																	style="font-weight: normal; font-size: 14px"> <label
																	class="active" for="first_name2"
																	style="font-weight: normal; font-size: 14px">MenuItem Description</label>
															</div>
															
															
															
															<div class="input-field col s2">
																<input type="text" class="price1" name="menuPrice1"
																	style="font-weight: normal; font-size: 14px"> <label
																	class="active" for="first_name2"
																	style="font-weight: normal; font-size: 14px">Price</label>
															</div>
															
															
																<input type='button' value='Delete' class='removeButton btn input-field col s1'>
															
															
															
															
															
															
														  </div>
														</div>
													</div>
													<div class="left">
														<input type='button'  value='Add Menu Item' class='addButton btn' style="padding:0 47px 0 47px">
														
														<!-- <input type='button' value='Save' class='getButtonValue btn'> -->
													</div>
												</div>
												
											
											</div>
											
											<hr style="border-style:solid;margin-top:8%;display:none" class="hr1">
											
											<div class="col s12"  id="contact${subDiscriptionObjForAddDirItems.objectId}" style="display:none;padding:0 0 0 0">
												<div class='manageTextBoxesGroup' >
													<div class="manageTextBoxDiv1">
														<div class="row">
															<div class="input-field col s3">
																<select class="browser-default type1"
																	name="manageType1">
																	<option value="" disabled selected>
																		Phone/Email/Website</option>
																	<option value="phone">Phone</option>
																	<option value="email">Email</option>
																	<option value="website">Website</option>
																</select>
															</div>
															
															<div class="input-field col s2" >
																<input type="text" name="manageDetails1"
																	class="details1"> <label for="textbox1">
																	</label>
															</div>
															<input type='button' value='Delete' class='manageRemoveButton btn input-field col s1'>
															
														</div>
														
													</div>
												</div>
											<input type='button'  value='Add Contacts' class='manageAddButton btn'>
											</div>
											
											<input type="hidden" class="counter" name="counter" value="0" />
											<input type="hidden" value="0" name="manageCount" class="manageCount"/>
											<div class="">
												<div class="input-field col s12"
													style="margin: 10px 0 0 0px;padding:0 0 0 0">
													<button type="submit" class="btn ">Save</button>
													<button type="reset" class="btn ">Clear</button>
													<br> <br> <br>
												</div>
											</div>

										</form:form>



									</c:if>
								</c:forEach>


								<!-- Displaying Menu Objects -->


								<%-- 							<a id="${subDiscriptionObjForAddDirItems.objectId }"
								class="btn btn-sm" onclick="menu_click(this.id)"
								style="float: right; background-color: #46A597; border-radius: 5px; margin: 12px 0px 0 13px;">
								Add Menu Items</a>
 --%>




								<!-- End of Displaying Styles -->

							</div>

							<!--End of new popup  -->

						</div>
					</c:forEach>
				</div>
				<div class="modal-footer"></div>
			</div>



		</div>
		<!--End of Add Disrectory Items Form  -->






		<div id="add11" class="modal">
		<a href="#"
			class="waves-effect waves-green btn-flat modal-action modal-close right">Close</a>
		<div class="modal-content">

			<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
				do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
				enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi
				ut aliquip ex ea commodo consequat. Duis aute irure dolor in
				reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
				pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
				culpa qui officia deserunt mollit anim id est laborum</p>
		</div>
		<div class="modal-footer"></div>
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
				var che = document.getElementById('check:'+spl[1]).checked;
				if(che)
				{
					for(var i=2;i<20;i++)
					{
						$('.TextBoxDiv'+i).hide();
						
					}	
					$('#menu'+spl[1]).show();
					
					$('.hr').show();
					$('.counter').val('2');
				}
				else {
					//$('#manage'+spl[1]).hide();
					$('#menu'+spl[1]).hide();
					$('.hr').hide();
					$('.counter').val('0');
				}			
						
			}  
			  
			  function edithandleClick(cb) {
				  var spl = cb.split(":");
				  
					var che = document.getElementById('editmenu:'+spl[1]).checked;
					
					if(che)
					{
						$('.edithr1').show();
						
						$('#editmenu'+spl[1]).show();
						//var val = $('.editmenuCount').val();
						
						for(var i=2;i<20;i++)
						{
							$('.editmenuTextBoxDiv'+i).hide();
							
						}	
					}
					else
					{
						$('#editmenu'+spl[1]).hide();
						$('.edithr1').hide();
						$('.editmenuCount').val('0');
					}
						
				}  
			  
			  function editcontactClick(cb) {
					
					var spl = cb.split(":");
					var che = document.getElementById('editcontact:'+spl[1]).checked;
					
					if(che)
					{
						$('.edithr2').show();
						
						//$('.editcontactCount').val('2');
						$('#editcontact'+spl[1]).show();
						
						for(var i=2;i<20;i++)
						{
							$('.editmanageTextBoxDiv'+i).hide();
							
						}
					} else {
						//$('#manage'+spl[1]).hide();
						$('#editcontact'+spl[1]).hide();
						$('.edithr2').hide();
						$('.editcontactCount').val('0');
					}							
				} 

			  
			
			function contactClick(cb) {
				
				var spl = cb.split(":");
				
				var che = document.getElementById('contact:'+spl[1]).checked;
				
				if(che)
				{
					for(var i=2;i<20;i++)
					{
						$('.TextBoxDiv'+i).hide();
						
					}	
					$('#contact'+spl[1]).show();
					
					$('.hr1').show();
					$('.manageCount').val('2');
				}
				else {
					//$('#manage'+spl[1]).hide();
					$('#contact'+spl[1]).hide();
					$('.hr1').hide();
					$('.manageCount').val('0');
				}
					
			}			
		
		</script>	
		
		<script type="text/javascript">
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
		</script>
		
		<script type="text/javascript">



    //var counter = 2;
    
		
    $(".editmenuaddButton").click(function () {
		
    	//alert($('.editmenuCount').val());
    	var editmenucounter = $('.editmenuCount').val();
    	editmenucounter = parseInt(editmenucounter);
    	
    	if( editmenucounter == 0 )
		{
    		editmenucounter = editmenucounter+30;
		}
		
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
				
    	var counter = $('.counter').val();
		
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
		    	if( editManageCounter == 0 )
		    		{
		    		editManageCounter = editManageCounter+30;
		    		}
				
			var newTextBoxDiv = $(document.createElement('div'))
			     .attr("class", 'editmanageTextBoxDiv' + editManageCounter);
		                
			newTextBoxDiv.after().html('<div class="row">'+
				'<div class="input-field col s3"><select name="editmanageType'+editManageCounter+'" style="display:-webkit-inline-box;" class="type'+editManageCounter+'"><option value="" disabled selected>Phone/Email/Website</option>'+
						  '<option value="phone">Phone</option>'+
						  '<option value="email">Email</option>'+
						  '<option value="website">Website</option></select></div>'+
				
		        '<div class="input-field col s2">'+
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
						
		    	var counter = $('.manageCount').val();
				
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
				
				var fa = $('.fcheck'+clicked_id).val();
				var sa = $('.scheck'+clicked_id).val();
				
				if(fa == undefined)
				{
					
					document.getElementById("editmenu:"+clicked_id).checked = false;
					$('#editmenu'+clicked_id).hide();
				}
				else {
					
					document.getElementById("editmenu:"+clicked_id).checked = true;
					$('#editmenu'+clicked_id).show();
				}
				
				if(sa == undefined)
				{
					
					document.getElementById("editcontact:"+clicked_id).checked = false;
					$('#editcontact'+clicked_id).hide();
				}
				else {
					
					document.getElementById("editcontact:"+clicked_id).checked = true;
					$('#editcontact'+clicked_id).show();
				}
				
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
		
		
		
		<script type="text/javascript">
		
			$(document).ready(function(){
			 	$("#add11").trigger('click');
			 	
			});
			
			function bodyLoad() {
				$('.container').show();
				

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
		
		<script type="text/javascript">
			$('#customOrder').click(function(){
				
				var orderNum = document.getElementById("customOrder");
				if(orderNum.checked)
					{
						$('#customNumber').show();
					}
				else
					{
						$('#customNumber').hide();
					}
			});
			
			
			function customOrder(number)
			{
				var orderNum = document.getElementById(number);
				var id=number.split(':');
				if(orderNum.checked)
					{
					$(".displaydrop").show();
					}
				else
					{
					$(".displaydrop").hide();
					}
				$('#subCustomNumber:SSwSagzAaA').show();
			}
				
		
		</script>
		
		<script>
		
			$('#createSuperAdmin').click(function(){
				
				var data = {
					
						"firstname":$('#superFirstname').val(),
						"lastname":$('#superLastname').val(),
						"username":$('#superUsername').val(),
						"email":$('#superEmail').val(),
						"user": $('#user').val(),
						"userName": $('#userName').val(),
						"locId": $('#locId').val()
						
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
						"userName": $('#userName').val(),
						"locId": $('#locId').val()
						
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
						"userName": $('#userName').val(),
						"locId": $('#locId').val()
						
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
			
			$('#showTemplates').on('change', function() {
				  
				  var a ="<span onclick='preview_Hotel_click(this)' class='"+this.value+"' style='cursor:pointer;font-size:15px;color:#00bcd4;text-decoration:underline'>Preview</span>";
				  $('#l1').html(a);
				});
		
		</script>
		
		<script type="text/javascript">
			function VoucherSourcetoPrint(source) {
				return "<html><head><script>function step1(){\n" +
						"setTimeout('step2()', 10);}\n" +
						"function step2(){window.print();window.close()}\n" +
						"</scri" + "pt></head><body onload='step1()'>\n" +
						"<img  style='height:300px;width:300px' src='" + source + "' /></body></html>";
			}
			function VoucherPrint(source) {
				Pagelink = "about:blank";
				var pwa = window.open(Pagelink, "_blank");
				pwa.document.open();
				pwa.document.write(VoucherSourcetoPrint(source));
				//$('#lean-overlay').css({display:'none !important'});
				
				pwa.document.close();
				location.reload();
				//document.getElementById("lean-overlay").style.display = "none";
			}
		</script>
		
		
		
		
		<script>
			$('#search').keyup(function(e){
				if(e.keyCode == 13)
			    {	
					var username = "${user}";
			    		    	
			    	var searchElement = {
			    			"searchId" : $('#search').val(),
			    			"username" : username
			    	};			    	
			    	 $('.loader').show();
			    	
			    	$.ajax({
					      type: "POST",
					      url: "searchHotels",
					      async: true,
					      data : searchElement,
					     
					      success :function(result) {
					    	  $("#searchResults").empty();
					    	 
					    	  console.log(result.length);
					    	  if(result.length == 0)
					    	  {					    		  
					    		  $('#noResults').text('Search results not found');
					    		  $('.loader').hide();
					    	  }
					    	  else
					    	  {
					    		  $('#noResults').empty();
					    		  $('#tbody').remove();
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
						    	  $("#searchResults").append(tableDetails);
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
		
		<script>
			function isNumber(evt) {
			    evt = (evt) ? evt : window.event;
			    var charCode = (evt.which) ? evt.which : evt.keyCode;
			    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
			        return false;
			    }
			    return true;
			}
		</script>
		
</body>
</html>