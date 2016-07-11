<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <link rel="stylesheet" href="../dist/themes/default/style.min.css" />
<link rel="stylesheet" href="../../../dist/themes/default-dark/style.min.css"> 

 <script src="../assets/jquery.min.js"></script> 
 <script src="../assets/dist/jstree.min.js"></script>
<script src="../js/jstree.dnd.js"></script> 


 <script>
$(function () {
	 var current_position;
	 var current_node_parent;
	  $("#jstree-proton-1").jstree({
	    "core" : {
	      //"check_callback" : true	      
	      "check_callback": function(operation, node, node_parent, node_position) {
	    	console.log("Entered check call back.......");
	        var check_passed = true;
	       
	        switch(operation) {
	            case "move_node":
	                //console.log("move_node");
	                //console.log("Node  : "+node);
	                //console.log("Node_parent  : "+node_parent);
	                console.log("Node_position  : "+node_position);
	                console.log("Node_parent  : "+node_parent);
	                var some_checks = true;
	                if(some_checks) {
	                    check_passed = true;	                    
	                }
	                break;
	        }
	        current_position = node_position;
	        current_node_parent = node_parent;
	        return check_passed;
	    }
	    },
	    "plugins" : [ "dnd" ],
	    
	  });
	  
	  var sourceElementID = "";
	  var destinationElementID = "";
	  debugger;
	  $(document).on('dnd_start.vakata', function (e, data) {	
		  debugger;
		  sourceElementID = $(data.element).attr('id');
		  console.log("sourceElementID is "+sourceElementID);
		});
	  $(document).on('dnd_stop.vakata', function (e, data) {
		  debugger;
		  console.log("destination data is "+data);	
		  console.log("destination data target is "+$(data.event.target));	
		  if(data.event && data.event.target){
		  destinationElementID = $(data.event.target).attr('id');
		  
		 
		  console.log("Current position is : "+current_position);
		  console.log("Current node parent  is : "+current_node_parent);
		  console.log(current_node_parent);
		  if(current_node_parent){
			  if(current_node_parent.a_attr){
				  if(current_node_parent.a_attr){
				  	console.log("Parent Id is : " + current_node_parent.a_attr.id);
				  	destinationElementID = current_node_parent.a_attr.id;
				  	
				  }
			  }
		  }
		  //call the update function
		  console.log("destinationElementID is "+destinationElementID);	
		  if(destinationElementID.length==10&&destinationElementID!=sourceElementID){
			  console.log(destinationElementID.length+" "+sourceElementID+" "+destinationElementID+" "+current_position); 			  
			 
			  $('#spinTree').click();
				 
				$.ajax({
				      type: "POST",
				   	  url: "jstree",				     
				      data : {"sourceElementID":sourceElementID,"destinationElementID":destinationElementID,"position":current_position},
				      success :function(result) {
				    	  
				    	  console.log(result);	
				    	  $('#jstreeSpin').hide();
				    	  $('.lean-overlay').css({display:'none'});
				     },
				     error : function(error) {
				    	console.log(error);
				    	 $('#jstreeSpin').hide();
				    	  $('.lean-overlay').css({display:'none'});
				     } 
				      
				     

				  }); 	 
		  }
		  }
		  
		});
	  $(document).on("move_node.jstree", function(node,nodes){
		    console.log("node : "+nodes.node.id);
		    console.log("parent : "+nodes.node.parent);
		    console.log("position : "+nodes.position);
		});

	});	
 
</script>

<script src="http://tinymce.cachefly.net/4.1/tinymce.min.js"></script>
<script type="text/javascript">
tinymce.init({
  selector: "textarea",
  height: 150,
  plugins: [
    "advlist autolink autosave link image lists charmap print preview hr anchor pagebreak spellchecker",
    "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
    "table contextmenu directionality emoticons template textcolor paste fullpage textcolor colorpicker textpattern"
  ],

  //toolbar1: "newdocument fullpage | bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | styleselect formatselect fontselect fontsizeselect",
  //toolbar2: "cut copy paste | searchreplace | bullist numlist | outdent indent blockquote | undo redo | link unlink anchor image media code | insertdatetime preview | forecolor backcolor",
  //toolbar3: "table | hr removeformat | subscript superscript | charmap emoticons | print fullscreen | ltr rtl | spellchecker | visualchars visualblocks nonbreaking template pagebreak restoredraft",
  
  toolbar1: "bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | styleselect fontselect fontsizeselect",
  toolbar2: "cut copy paste | searchreplace | bullist numlist | outdent indent blockquote | undo redo | link unlink anchor code | insertdatetime preview | forecolor backcolor",
  toolbar3: "table | hr removeformat | subscript superscript | charmap emoticons | fullscreen | ltr rtl | spellchecker | visualchars visualblocks nonbreaking template pagebreak",

  menubar: false,
  toolbar_items_size: 'small',

  style_formats: [{
    title: 'Bold text',
    inline: 'b'
  }, {
    title: 'Red text',
    inline: 'span',
    styles: {
      color: '#ff0000'
    }
  }, {
    title: 'Red header',
    block: 'h1',
    styles: {
      color: '#ff0000'
    }
  }, {
    title: 'Example 1',
    inline: 'span',
    classes: 'example1'
  }, {
    title: 'Example 2',
    inline: 'span',
    classes: 'example2'
  }, {
    title: 'Table styles'
  }, {
    title: 'Table row 1',
    selector: 'tr',
    classes: 'tablerow1'
  }],

  templates: [{
    title: 'Test template 1',
    content: 'Test 1'
  }, {
    title: 'Test template 2',
    content: 'Test 2'
  }],
  
});
</script>


  
<meta name="viewport" content="width=device-width, initial-scale=1.0">


<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<title>IT Admin Page | eGSD Admin Template</title>


<!-- CORE CSS-->

<link rel="stylesheet" href="../dist/themes/proton/style.min.css" />


<script src="../assets/jquery-1.10.2.min.js"></script>

<script src="../assets/dist/jstree.min.js"></script>


	<script type="text/javascript" src="../js/jscolor.js"></script>
<script type="text/javascript" src="../styles/js/boot.js"></script>

<!-- html editor -->
<link type="text/css" rel="stylesheet" href="../styles/css/materialize.min.css"  media="screen,projection"/>
      <link type="text/css" rel="stylesheet" href="../styles/css/cust.css" />
		 <link href="../styles/css/app.css" rel="stylesheet">
         <link href="../styles/vendors/bower_components/material-design-iconic-font/dist/css/material-design-iconic-font.min.css" rel="stylesheet">
        <link href="../styles/vendors/summernote/dist/summernote.css" rel="stylesheet">

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

<body class="loaded" onload="bodyLoad()"
	style="font-family: 'Open Sans', sans-serif;background-color:white">
	
	<a href="#updateAdmin" class="modal-trigger" id="updateAdminhref"
	    style="font-size: 1rem; display:none;padding: 0.5rem 0.5rem;">Edit Profile</a>
	
	<a href="#superAdmin" class="modal-trigger" id="asAdminhref"
	    style="font-size: 1rem; display:none;padding: 0.5rem 0.5rem;">Add Super Admin User</a>
	    
	 <a href="#csAdmin" class="modal-trigger" id="csAdminhref"
    	style="font-size: 1rem;display:none; padding: 0.5rem 0.5rem;">Add CS Admin User</a>
    	
     <a href=".locationAdmin" class="modal-trigger " id="locationAdmin"
    	style="font-size: 1rem;display:none; padding: 0.5rem 0.5rem;">Add Hotel Admin User</a>
    	
     <a href="#groupHotel" class="modal-trigger" id="grouphref"
		style="font-size: 1rem;display:none; padding: 0.5rem 0.5rem;">Add Group</a>
		
	 <a href="#addHotel" class="modal-trigger" id="hotelhref"
		style="font-size: 1rem;display:none; padding: 0.5rem 0.5rem;">Add Hotel</a>
		
	 <a href="#createTemplate" class="modal-trigger" id="templatehref"
		style="font-size: 1rem;display:none; padding: 0.5rem 0.5rem;">Create New Template</a>

	<div class="navbar-fixed cyan">
		<ul id="dropdown1" class="dropdown-content">
			<li><a  id="updateAdminDetails"style="font-size: 1rem; padding: 0.5rem 0.5rem;">Manage User Profile</a></li>
			<li><a id="asAdmin" style="font-size: 1rem; padding: 0.5rem 0.5rem;">Add Super Admin User</a></li>     		
			<li><a  id="acAdmin" style="font-size: 1rem; padding: 0.5rem 0.5rem;">Add CS Admin User</a></li> 
   			<li style="min-height:31px"><a id="alAdmin"	style="font-size: 1.5rem; padding:9px 0 9px 17px;">Add Hotel Admin User</a></li>
   			<li style="min-height:31px"><a href="#modal4" class="modal-trigger searchUsers"
				style="font-size: 1.5rem; padding:9px 0 9px 17px;">Manage Users</a></li>
   			<li style="min-height:31px"> <a id="agroup"	style="font-size: 1rem; padding:9px 0 9px 17px;">Create Hotel Group</a></li>
    		<li style="min-height:31px"><a href="#modal3" class="modal-trigger skipGroup"
				style="font-size: 1.5rem; padding:9px 0 9px 17px;">Manage Hotel Groups</a></li>
			<li><a id="ctemplate" style="font-size: 1.5rem; padding:9px 0 9px 17px;">Create Template</a></li>
			<li style="min-height:31px"><a href="#modal2" class="modal-trigger skipTemplate"
				style="font-size: 1.5rem; padding:9px 0 9px 17px;">Manage Templates</a></li>
			<li style="min-height:31px"><a id="ahotel"	style="font-size: 1rem; padding:9px 0 9px 17px;">Create Hotel</a></li>
			<li style="min-height:31px"><a style="font-size: 1.5rem; padding:9px 0 9px 17px;" class="modal-trigger skipSelection" 
				href="#modal1">Manage Hotels</a></li>
			
			
			<p class="divider"></p>
			<li style="min-height:31px"><a href="/egsdAdminApp/"
				style="font-size: 1.5rem; padding:9px 0 9px 17px;">Logout</a></li>
		</ul>
		<nav class="cyan" style="padding:0 5% 0 4%">
		<div class="nav-wrapper">
			
				<span class="brand-logo"><img
				src="../img/logo.png" style="width: 100%; padding-top: 7px;"></span>
			<ul class="right hide-on-med-and-down">

				<li><a class="dropdown-button" href="#!"
					data-activates="dropdown1" style="min-width: 150px;font-size:14px;color:white;">${user} (${userName })<i
						class="material-icons right" style="font-size: 30px;">arrow_drop_down</i></a></li>
			</ul>
		</div>
		</nav>
	</div>
	<br />
	
	
	
		
 
 <div id="modal29" class="modal checkbox_input"
		style="overflow: auto; width: 80%;margin-top:0%">
		
			<a href="#" onclick="closeDiv()"
				class="waves-effect waves-green btn-flat modal-action modal-close right  waves-effect waves-light btn "
				style="margin-right: 6%; color: white; margin-top: 10px; width: 100px; background-color: #26a69a;!important">CANCEL</a>
			
				<div class="modal-content menuBody">


					<center>
						<h5 id="locationtext">Menu Items</h5>
					</center>

					<div class="main">
						<div class="table">
							<table >
								<thead>
									<tr style="width: 81%;">
										<th data-field="show" style="width: 5%">Show
											<hr>
										</th>
										<th data-field="menu" style="width: 11%">Menu Description
											<hr>
										</th>
										<th data-field="swque" style="width: 11%">Menu Sequence
											<hr>
										</th>
										<th data-field="icon" style="width: 11%">Icon
											<hr>
										</th>
										<th data-field="show" style="width: 5%">Show
											<hr>
										</th>
										<th data-field="sequence" style="width: 11%">Icon
											Sequence
											<hr>
										</th>
										<th data-field="item" style="width: 15%">ItemAction
											<hr>
										</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><input type="checkbox" id="test0000"
											onclick="clicking0000()"
											style="background-color: green; color: green" /></td>
										<td id="menuDesc0000">House Phone</td>
										<td><div id="dvPassport0000" style="display: none">
												<input type="text" maxlength="1" id="quantity0000" 
													placeholder="Enter Number"
													style="width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 95px; margin-top: 19px;" />


											</div>
											<span id="dvPa1"></span>
											</td>
											
										<td><i class="large material-icons">call</i></td>
										<td><input type="checkbox" maxlength="1" id="icon0000"
											onclick="clicking00()" /></td>
										<td>
										<div id="dvPassport500" style="display: none">
												<input type="text" id="quantity1" maxlength="1"
													placeholder="Enter Number"
													style="width: 170px; font-size: 14px; background: white; margin-top: 19px; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 95px;" />
											</div>
											<span id="dvPa11"></span>
											</td>
										<td><input type="text" id="itemAction0000"
											style="width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; margin-top: 19px; color: #666; outline: none; height: 23px; width: 120px;" "/>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" id="test0001"
											onclick="clicking0001()" /></td>
										<td id="menuDesc0001">Service/Front Desk</td>
										<td><div id="dvPassport0001" style="display: none">
												<input type="text" maxlength="1" id="quantity0001"
													placeholder="Enter Number"
													style="width: 170px; font-size: 14px; margin-top: 19px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 95px;" " />
										</div>
												<span id="dvPa2"></span>
											</td>
										<td><i class="large material-icons"><image
													src="../img/frontdesk.png" class="img-rounded"
													style="height: 50px"></i></td>
										<td><input type="checkbox" id="icon0001"
											onclick="clicking()" /></td>
										<td><div id="dvPassport50" style="display: none">
												<input type="text" maxlength="1" id="quantity2"
													placeholder="Enter Number"
													style="width: 170px; font-size: 14px; margin-top: 19px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 95px;" " />
											</div>
											<span id="dvPa12"></span>
											</td>
										<td><input type="text" id="itemAction0001"
											style="width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; margin-top: 19px; color: #666; outline: none; height: 23px; width: 120px;" "/>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" id="test0002"
											onclick="clicking0002()" /></td>
										<td id="menuDesc0002">Bellman/Baggage</td>
										<td><div id="dvPassport0002" style="display: none">
												<input type="text" maxlength="1" id="quantity0002"
													placeholder="Enter Number"
													style="margin-top: 19px; width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 95px;" " />
											</div>
											<span id="dvPa3"></span>
											</td>
											
										<td><i class="large material-icons"><image
													src="../img/baggage.png" class="img-rounded"
													style="height: 35px;margin-left:12px;"></i></td>
										<td><input type="checkbox" id="icon0002"
											onclick="clicking1()" /></td>
										<td><div id="dvPassport7" style="display: none">
												<input type="text" maxlength="1" id="quantity3"
													placeholder="Enter Number"
													style="margin-top: 19px; width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 95px;" " />
											</div>
											<span id="dvPa13"></span>
											</td>
										<td><input type="text" id="itemAction0002"
											style="margin-top: 19px; width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 120px;" " /></td>
									</tr>
									<tr>
										<td><input type="checkbox" id="test0003"
											onclick="clicking0003()" /></td>
										<td id="menuDesc0003">Maid Service</td>
										<td><div id="dvPassport0003" style="display: none">
												<input type="text" maxlength="1" id="quantity0003"
													placeholder="Enter Number"
													style="margin-top: 19px; width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 95px;" " />
											</div>
										<span id="dvPa4"></span>	
											</td>
										<td><i class="large material-icons"><image
													src="../img/maidservice.png" class="img-rounded"
													style="    margin-top: 19px;height: 50px;margin-left:4px;"></i></td>
										<td><input type="checkbox" id="icon0003"
											onclick="clicking2()" /></td>
										<td><div id="dvPassport9" style="display: none">
												<input type="text" maxlength="1" id="quantity4"
													placeholder="Enter Number"
													style="margin-top: 19px; width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 95px;" " />
											</div>
											<span id="dvPa14"></span>
											</td>
										<td><input type="text" id="itemAction0003"
											style="margin-top: 19px; width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 120px;" " /></td>
									</tr>
									<tr>
										<td><input type="checkbox" id="test0004"
											onclick="clicking0004()" /></td>
										<td id="menuDesc0004">Emergency</td>
										<td><div id="dvPassport0004" style="display: none">
												<input type="text" maxlength="1" id="quantity0004"
													placeholder="Enter Number"
													style="margin-top: 19px; width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 95px;" " />
											</div>
									    <span id="dvPa5"></span>		
											</td>
										<td><i class="large material-icons"><image
													src="../img/sos.png" class="img-rounded"
													style="height: 55px"></i></td>
										<td><input type="checkbox" id="icon0004"
											onclick="clicking3()" /></td>
										<td><div id="dvPassport11" style="display: none">
												<input type="text" maxlength="1" id="quantity5"
													placeholder="Enter Number"
													style="margin-top: 19px; width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 95px;" " />
											</div>
											<span id="dvPa15"></span>
											</td>
										<td><input type="text" id="itemAction0004"
											style="margin-top: 19px; width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 120px;"" ></td>
									</tr>
									<tr>
										<td><input type="checkbox" id="test0005"
											onclick="clicking0005()" /></td>
										<td id="menuDesc0005">Food and Beverage</td>
										<td><div id="dvPassport0005" style="display: none">
												<input type="text" maxlength="1" id="quantity0005"
													placeholder="Enter Number"
													style="margin-top: 19px; width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 95px;" " />
											</div>
										<span id="dvPa6"></span>	
											</td>
										<td><i class="large material-icons"><image
													src="../img/food.png" class="img-rounded"
													style="height: 50px"></i></td>
										<td><input type="checkbox" id="icon0005"
											onclick="clicking4()" /></td>
										<td><div id="dvPassport13" style="display: none">
												<input type="text" maxlength="1" id="quantity6"
													placeholder="Enter Number"
													style="margin-top: 19px; width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 95px;" " />
											</div>
											<span id="dvPa16"></span>
											</td>
										<td><input type="text" id="itemAction0005"
											style="margin-top: 19px; width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 120px;" " /></td>
									</tr>
									<tr>
										<td><input type="checkbox" id="test0006"
											onclick="clicking0006()" /></td>
										<td id="menuDesc0006">Taxi</td>
										<td><div id="dvPassport0006" style="display: none">
												<input type="text" maxlength="1" id="quantity0006"
													placeholder="Enter Number"
													style="margin-top: 19px; width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 95px;" " />
											</div>
									<span id="dvPa7"></span>		
											</td>
										<td><i class="large material-icons"><image
													src="../img/taxi.png" class="img-rounded"
													style="height: 50px"></i></td>
										<td><input type="checkbox" id="icon0006"
											onclick="clicking5()" /></td>
										<td><div id="dvPassport15" style="display: none">
												<input type="text" maxlength="1" id="quantity7"
													placeholder="Enter Number"
													style="margin-top: 19px; width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 95px;" " />
											</div>
											<span id="dvPa17"></span>
											</td>
										<td><input type="text" id="itemAction0006"
											style="margin-top: 19px; width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 120px;" " /></td>
									</tr>
									<tr>
										<td><input type="checkbox" id="test0007"
											onclick="clicking0007()" /></td>
										<td id="menuDesc0007">Local Attractions</td>
										<td><div id="dvPassport0007" style="display: none">
												<input type="text" maxlength="1" id="quantity0007"
													placeholder="Enter Number"
													style="margin-top: 19px; width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 95px;" " />
											</div>
									<span id="dvPa8"></span>		
											</td>
										<td><i class="large material-icons"><image
													src="../img/map.png" class="img-rounded"
													style="height: 50px"></i></td>
										<td><input type="checkbox" id="icon0007"
											onclick="clicking6()" /></td>
										<td><div id="dvPassport17" style="display: none">
												<input type="text" maxlength="1" id="quantity8"
													placeholder="Enter Number"
													style="margin-top: 19px; width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 95px;" />
											</div>
											<span id="dvPa18"></span>
											</td>
										<td><input type="text" id="itemAction0007"
											style="margin-top: 19px; width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 120px;" " /></td>
									</tr>
									<tr>
										<td><input type="checkbox" id="test0008"
											onclick="clicking0008()" /></td>
										<td id="menuDesc0008">Hotel Directory</td>
										<td><div id="dvPassport0008" style="display: none">
												<input type="text" maxlength="1" id="quantity0008"
													placeholder="Enter Number"
													style="margin-top: 19px; width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 95px;" " />
											</div>
											<span id="dvPa9"></span>
											</td>
										<td><i class="large material-icons"><image
													src="../img/directory.png" class="img-rounded"
													style="height: 50px"></i></td>
										<td><input type="checkbox" id="icon0008"
											onclick="clicking7()" /></td>
										<td><div id="dvPassport" style="display: none">
												<input type="text" maxlength="1" id="quantity9"
													placeholder="Enter Number"
													style="margin-top: 19px; width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 95px;" " />
											</div>
											<span id="dvPa19"></span>
											</td>
										<td><input type="text" id="itemAction0008"
											style="margin-top: 19px; width: 170px; font-size: 14px; background: white; border: 1px solid #26a69a; border-radius: 5px; color: #666; outline: none; height: 23px; width: 120px;" " />
										</td>

									</tr>
								</tbody>
							</table>
						</div>
					</div>



					<!--  <input type="button" name="submit" value="submit" style="margin-left: 1146px;
    margin-top: -667px;"> -->
					<a id="" class="btn"
						onclick="admin_app(this.id)"
						style="margin-top: -698px; margin-left: 33px; width: 100px; color: white; margin-left: 75%; padding: 10PX;">SUBMIT</a>



				</div>
			

	</div> 
	 
	 
	 	 <script type="text/javascript">
      $(function () {
        $("#test1350").click(function () {
            if ($(this).is(":checked")) {
                $("#quantity20").show();
            } else {
                $("#quantity20").hide();
            }
        });
      });
    </script>
	 
	 <script type="text/javascript">
      $(function () {
        $("#test0000").click(function () {
            if ($(this).is(":checked")) {
                $("#quantity0000").show();
            } else {
                $("#quantity0000").hide();
            }
        });
      });
    </script>
	 
	 
	 
	 <script type="text/javascript">
      $(function () {
        $("#test0001").click(function () {
            if ($(this).is(":checked")) {
                $("#quantity0001").show();
            } else {
                $("#quantity0001").hide();
            }
        });
      });
    </script>
    <script type="text/javascript">
      $(function () {
        $("#test0002").click(function () {
            if ($(this).is(":checked")) {
                $("#quantity0002").show();
            } else {
                $("#quantity0002").hide();
            }
        });
      });
    </script>
    <script type="text/javascript">
      $(function () {
        $("#test0003").click(function () {
            if ($(this).is(":checked")) {
                $("#quantity0003").show();
            } else {
                $("#quantity0003").hide();
            }
        });
      });
    </script>
    <script type="text/javascript">
      $(function () {
        $("#test0004").click(function () {
            if ($(this).is(":checked")) {
                $("#quantity0004").show();
            } else {
                $("#quantity0004").hide();
            }
        });
      });
    </script>
    <script type="text/javascript">
      $(function () {
        $("#test0005").click(function () {
            if ($(this).is(":checked")) {
                $("#quantity0005").show();
            } else {
                $("#quantity0005").hide();
            }
        });
      });
    </script>
    <script type="text/javascript">
      $(function () {
        $("#test0006").click(function () {
            if ($(this).is(":checked")) {
                $("#quantity0006").show();
            } else {
                $("#quantity0006").hide();
            }
        });
      });
    </script>
    <script type="text/javascript">
      $(function () {
        $("#test0007").click(function () {
            if ($(this).is(":checked")) {
                $("#quantity0007").show();
            } else {
                $("#quantity0007").hide();
            }
        });
      });
    </script>
    <script type="text/javascript">
      $(function () {
        $("#test0008").click(function () {
            if ($(this).is(":checked")) {
                $("#quantity0008").show();
            } else {
                $("#quantity0008").hide();
            }
        });
      });
    </script>
    <script >
		function clicking0000(){
			
			$("#dvPassport0000").show();
		}
		
		</script>
    <script >
		function clicking0001(){
			
			$("#dvPassport0001").show();
		}
		
		</script>
		<script >
		function clicking0002(){
			
			$("#dvPassport0002").show();
		}
		
		</script>
		<script >
		function clicking0003(){
			
			$("#dvPassport0003").show();
		}
		
		</script>
		<script >
		function clicking0004(){
			
			$("#dvPassport0004").show();
		}
		
		</script>
		<script >
		function clicking0005(){
			
			$("#dvPassport0005").show();
		}
		
		</script>
		<script >
		function clicking0006(){
			
			$("#dvPassport0006").show();
		}
		
		</script>
		<script >
		function clicking0007(){
			
			$("#dvPassport0007").show();
		}
		
		</script>
		<script >
		function clicking0008(){
			
			$("#dvPassport0008").show();
		}
		
		</script>
			 
	 
	 <!-- shiva  -->
	 
	 <script type="text/javascript">
    $(function () {
        $("#test001").click(function () {
            if ($(this).is(":checked")) {
                $("#dvPassport123").show();
            } else {
                $("#dvPassport123").hide();
            }
        });
    });
</script>
	 
	 <!-- 10 -->
	  <script type="text/javascript">
    $(function () {
        $("#test119").click(function () {
            if ($(this).is(":checked")) {
                $("#dvPassport").show();
            } else {
                $("#dvPassport").hide();
            }
        });
    });
</script>
<script type="text/javascript">
    $(function () {
        $("#test103").click(function () {
            if ($(this).is(":checked")) {
                $("#dvPassport1").show();
            } else {
                $("#dvPassport1").hide();
            }
        });
    });
</script>
<script type="text/javascript">
$(function () {
    $("#test1350").click(function () {
        if ($(this).is(":checked")) {
            $("#quantity20").show();
        } else {
            $("#quantity20").hide();
        }
    });
});
</script>

<script type="text/javascript">
$(function () {
    $("#test135").click(function () {
        if ($(this).is(":checked")) {
            $("#quantity2").show();
        } else {
            $("#quantity2").hide();
        }
    });
});
</script>

<script type="text/javascript">
    $(function () {
        $("#test107").click(function () {
            if ($(this).is(":checked")) {
                $("#quantity3").show();
            } else {
                $("#quantity3").hide();
            }
        });
    });
</script>

<script type="text/javascript">
    $(function () {
        $("#test109").click(function () {
            if ($(this).is(":checked")) {
                $("#quantity4").show();
            } else {
                $("#quantity4").hide();
            }
        });
    });
</script>

<script type="text/javascript">
    $(function () {
        $("#test111").click(function () {
            if ($(this).is(":checked")) {
                $("#quantity5").show();
            } else {
                $("#dquantity5").hide();
            }
        });
    });
</script>

<script type="text/javascript">
    $(function () {
        $("#test113").click(function () {
            if ($(this).is(":checked")) {
                $("#quantity6").show();
            } else {
                $("#quantity6").hide();
            }
        });
    });
</script>

<script type="text/javascript">
    $(function () {
        $("#test115").click(function () {
            if ($(this).is(":checked")) {
                $("#quantity7").show();
            } else {
                $("#quantity7").hide();
            }
        });
    });
</script>

<script type="text/javascript">
    $(function () {
        $("#test117").click(function () {
            if ($(this).is(":checked")) {
                $("#quantity8").show();
            } else {
                $("#quantity8").hide();
            }
        });
    });
</script>
<script type="text/javascript">
    $(function () {
        $("#test119").click(function () {
            if ($(this).is(":checked")) {
                $("#quantity").show();
            } else {
                $("#quantity").hide();
            }
        });
    });
</script>
<script>
$(document).ready(function () {
  //called when key is pressed in textbox
  $("#quantity20").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });
});
</script> 
<script>
$(document).ready(function () {
  //called when key is pressed in textbox
  $("#quantity0000").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });
});
</script> 
<script>
$(document).ready(function () {
  //called when key is pressed in textbox
  $("#quantity0001").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });
});
</script> 
<script>
$(document).ready(function () {
  //called when key is pressed in textbox
  $("#quantity0002").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });
});
</script> 
<script>
$(document).ready(function () {
  //called when key is pressed in textbox
  $("#quantity0003").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });
});
</script> 
<script>
$(document).ready(function () {
  //called when key is pressed in textbox
  $("#quantity0004").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });
});
</script> 
<script>
$(document).ready(function () {
  //called when key is pressed in textbox
  $("#quantity0005").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });
});
</script> 
<script>
$(document).ready(function () {
  //called when key is pressed in textbox
  $("#quantity0006").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });
});
</script> 
<script>
$(document).ready(function () {
  //called when key is pressed in textbox
  $("#quantity0007").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });
});
</script> 

<script>
$(document).ready(function () {
  //called when key is pressed in textbox
  $("#quantity0008").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });
});
</script> 
<script>
$(document).ready(function () {
  //called when key is pressed in textbox
  $("#quantity").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });
});
</script> 


<script>
$(document).ready(function () {
  //called when key is pressed in textbox
  $("#quantity0").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg0").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });
});
</script> 
<script>
$(document).ready(function () {
  //called when key is pressed in textbox
  $("#quantity1").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg1").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });
});
</script> 
<script>
$(document).ready(function () {
  //called when key is pressed in textbox
  $("#quantity2").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg2").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });
});
</script> 
<script>
$(document).ready(function () {
  //called when key is pressed in textbox
  $("#quantity3").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg3").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });
});
</script> 
<script>
$(document).ready(function () {
  //called when key is pressed in textbox
  $("#quantity4").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg4").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });
});
</script> 
<script>
$(document).ready(function () {
  //called when key is pressed in textbox
  $("#quantity5").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg5").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });
});
</script> 
<script>
$(document).ready(function () {
  //called when key is pressed in textbox
  $("#quantity6").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg6").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });
});
</script> 
<script>
$(document).ready(function () {
  //called when key is pressed in textbox
  $("#quantity7").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg7").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });
});
</script> 
<script>
$(document).ready(function () {
  //called when key is pressed in textbox
  $("#quantity8").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg8").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });
});
</script>  
	 <!-- end of shiva popup -->
	 
	 
<!-- end Admin App -->

<!--  update Super admin popup -->

  
  <div id="updateAdmin" class="modal" style="overflow:auto">
  
  	
  
    <a href="#!" class=" modal-action modal-close right waves-effect waves-green btn-flat">Close</a>
       <div class="modal-content ubody">
       <center><h5 id="supertext"> </h5></center>
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
     
    
     
           
           <div class="row">
             <div class="input-field col s12">
               
               <button type="submit" id="updateAdminUser" class="btn waves-effect waves-light col s12">Update User</button>
             </div>
             
           </div>
          
       </div>
     
  </div>
 
 
<!--  end of the update Super admin popup -->


<!-- start change hotel popup -->
	
	<div id="modal1" class="modal" style="width:80%;margin-top:2% ; overflow: auto;">
	<a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat right">Close</a>
		
			
		
	    <div class="modal-content" style="padding:26px 30px 0 30px; height: 518px;">   
	    	
	    		<center ><h5 id="locationtext">Select Hotel</h5></center>
	
				  <nav style="width:50%;height:40px;margin:14px 0 25px 0px;line-height:45px !important;background-color:#00bcd4">
				    <div class="nav-wrapper">
				      
				        <div class="input-field">
				          <input id="search" type="search" required style="width:100%;font-size:16px;padding:11px 9px 0 50px;color:#fff;background-color:#00bcd4">
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
	    		<span id="noResults" style="margin-left:29%"></span>
	      		
	      		<center></center>	
				<table class="table bordered striped searchResults" >
					
				</table>
	    </div>
	    
	 </div>
	
	<!-- end of the change hotel popup -->
	
	
	<!-- start managing users popup -->
	
	<div id="modal4" class="modal" style="width:80%;overflow:auto">
	<a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat right">Close</a>
		
			
		
	    <div class="modal-content" style="padding:20px 30px 0 30px">  
	    	
	    	<center  style="margin-left:15%"><h5 id="locationtext">Manage Users</h5></center>
	
	  <nav style="width:50%;height:40px;margin:14px 0 27px 0px;line-height:45px !important;background-color:#00bcd4">
	    <div class="nav-wrapper">
	      
	        <div class="input-field">
	          <input id="userSearch" type="search" required style="width:100%;font-size:16px;padding:11px 9px 0 50px;color:#fff;background-color:#00bcd4">
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
	  	
	  	 		
	    		<span id="noUserResults" style="margin-left:44%"></span>
	      		
	      		<center></center>	
				<table class="table bordered striped" id="userSearchResults">
					<tbody id="userbody">
						
					</tbody>
				</table>
	    </div>
	    
	 </div>
	
	<!-- end of the managing users popup -->
	
	
	<!-- start change Group popup -->
 
	 <div id="modal3" class="modal" style="overflow:auto">
	  <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat right">Close</a>
	     <div class="modal-content">
	       <center><h5 id="locationtext">Select Group</h5></center>
	       
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
		    	
		    </tbody>	
	    </table>
	     </div>
	     
	 </div>
	 
	 <!-- end of the change Group popup -->
	 
	 <!-- start change template popup -->
 
	 <div id="modal2" class="modal" style="overflow:auto">
	  <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat right">Close</a>
	     <div class="modal-content">
	       <center><h5 id="locationtext">Select Template</h5></center>
	       
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
		    	
		    </tbody>	
	    </table>
	     </div>
	     
	 </div>
	 
	 <!-- end of the change template popup -->
		

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
     
     <input type="hidden" id="user" name="user" value="${user}">
     <input type="hidden" name="userName" id="userName" value="${userName }">
     
           
           <div class="row">
             <div class="input-field col s12">
               <button type="submit" id="createSuperAdmin" class="btn  waves-light col s12">Create Super Admin</button>
               <button type="submit" id="updateSuperAdmin" style="display:none" class="btn  waves-light col s12">Update Super Admin</button>
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
       <input  type="text" class="customFont" name="username" required id="csUsername"  style="padding: 0 10px 0 10px">
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
       <input  type="text" name="username" class="customFont" id="locationUsername" required style="padding: 0 10px 0 10px">
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



<!--  create template popup -->
 
  <div id="createTemplate" class="modal" style="width:30%;height:317px;margin-top:0%">
 
  <form:form action="addTemplate" method="post" name="addTemplate">
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
         <center ><h5 id="locationtext"> Create Template </h5></center>
         <div class="">
           <div class="input-field col s12">
          
             <input  type="text" class="validate customFont" required id="templateName" name="templateName" style="padding:0px 0px 0px 0px;margin-bottom:3px">
             <label for="name" class="customFont" style="padding:0px 0px 0px 0px">Template Name</label>
             <span id="templateNameErr" style="color:red;font-size:13px"></span>             
             <span id="templateExistErr" style="color:red;font-size:13px"></span>
           </div>
         </div>
         
         <div class="">
			<div class="input-field ">
				<select class="browser-default" required id="templateId" name="templateId">
					<option value="" disabled selected>Choose Template</option>
					
				</select>
				<span id="templateIdErr" style="color:red;font-size:13px"></span>
			</div>
		</div>
         
       	
       	<input type="hidden" value="${user }" name="user">
       	<input type="hidden" value="${userName }" name="userName">
       	<input type="hidden" value="${tempId }" name="tempId">
       	
       	
       <center style="margin-top:5%"><a href="javascript: submitform()" id="cTemplate"  class=" waves-light btn">Create Template</a></center>
       
      </div>
 	</form:form>  
 
  </div>
 
 <!-- end of the template popup -->
 
 <!--  create group hotel popup -->
 <div id="groupHotel" class="modal" style="height:317px;width:30%;margin-top:0%">
  
  <form:form action="addGroup" method="post" name="addGroup">
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
		
		
         <center><h5 id="locationtext"> Create Hotel Group </h5></center>
         <div class="">
           <div class="input-field col s12">
           
           <input type="hidden" name="user" value="${user }">
           <input type="hidden" name="userName" value="${userName }">
           <input type="hidden" value="${tempId }" name="tempId">
          
             <input  type="text" required name="groupName" class="customFont" id="addGroupName" style="margin-bottom:3px">
             <label for="name" class="customFont" style="padding:0 10px 0 10px">Group Name</label>
             <span id="groupExistErr" style="color:red;font-size:13px"></span>
             <span id="groupNameErr" style="color:red;font-size:13px"></span>
           </div>
           <div class="">
		    <div class="input-field ">
		     <select required  class="browser-default" name="templateId" id="addTemplateId">
		      <option value="" disabled selected>Choose Template</option>
		       
		     </select>
		     <span id="groupIdErr" style="color:red;font-size:13px"></span>
		    </div>
		   </div>
           
       </div>
        
        
        
       <center style="margin-top:5%"><a href="javascript: groupSubmitform()" class=" waves-light btn">Create Hotel Group</a></center>
       
      </div>
  </form:form>  
  
</div>
 <!-- end of the group hotel popup -->
 
 
 
 <!-- start add hotel popup -->
	
	<div id="addHotel" class="modal" style="overflow:auto">
	
	  <form:form action="addLocation" commandName="addLocation" name="addLocation"
							enctype="multipart/form-data">
	   <a href="#!" class=" modal-action modal-close right waves-effect waves-green btn-flat">Close</a>
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
	         		<center ><h5 > Create Hotel </h5></center>
	        		<div style="margin: 1% 3% 0px 3%">
						

							<!--hidden fields  -->
							<input type="hidden" value="${userName}" name="userName">
							<input type="hidden" value="${user}" name="user">
							<input type="hidden" value="${tempId }" name="tempId">
							
							 

							<div class="">
								<div class="input-field ">
									<input type="text" name="Name" required id="hotelName"
										style="font-size: 16px;padding-left:10px;margin-bottom:3px "> <label
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
									<span id="hotelGroupidErr" style="font-size:13px;color:red"></span>
								</div>
							</div>
							
							<div class="row">
								<div class="input-field col s6">
									<select  name="adminId" required id="adminId" class="locAdmin browser-default">
								      <option value="" disabled selected>Choose Location Admin</option>				
								    </select>
								  <span id="hotelLocationAdminErr" style="font-size:13px;color:red"></span>
									
								</div>

							</div>
							
							<div class="row">
							
								<div class="input-field">
									<input type="checkbox" id="checkBox" onclick = "Check()" />
      								<label for="checkBox">Group Hotel</label>
								</div>
								
								<div class="input-field col s6" id="showGroups" style="display:none">
									<select name="groupId" id="groupObjectId"  class="browser-default">
								      <option value="" selected disabled>Choose Group</option>
								       
								       
								    </select>
								    <span id="hotelGroupErr" style="font-size:13px;color:red"></span>
								</div>
								
							
								<div class="input-field col s6" >
									<select class="browser-default" required id="showTemplates" name="groupId">
								        <option value="" selected disabled>Choose Template</option>
										
								    </select>
								    <span id="hotelTemplateErr" style="font-size:13px;color:red"></span>
									
								</div>
								<div class="input-field col s6" style="margin-top:4%">
									<span id="l1"></span>
								</div>

							</div>
							
							
							
							<div class="">
								<div class="input-field ">
									<input type="text" name="Address1" id="Address1"
										style="font-size: 16px;padding-left:10px;margin-bottom:3px"> <label
										for="first_name2" style="font-size: 14px; font-weight: normal">Address1</label>
										
									<span id="hotelAddressErr" style="font-size:13px;color:red"></span>
								</div>
							</div>
							<div class="">
								<div class="input-field ">
									<input type="text" name="Address2" id="Address2"
										style="font-size: 16px;padding-left:10px;margin-bottom:3px"> <label
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
									<input type="text" id="zipcode" name="zipcode" onkeypress="return isNumber(event)"
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
								<div class="file-path-wrapper">
									<input class="file-path" type="text"
										placeholder="Upload Hotel Logo"
										style="font-weight: normal; font-size: 14px;">
								</div>
							</div>

							<div class="file-field input-field ">
								<div class="btn" style="padding: 0 10px 0 10px;">
									<span>Hotel Image</span> <input type="file" name="logo" multiple>
								</div>
								<div class="file-path-wrapper">
									<input class="file-path" type="text"
										placeholder="Upload Hotel Image"
										style="font-weight: normal; font-size: 14px;">
								</div>
							</div>
														
														<div class="file-field input-field ">
								<div class="btn" style="padding: 0 10px 0 10px;">
									<span>Hotel Footer</span> <input type="file" name="hotelFooter" multiple>
								</div>
								<div class="file-path-wrapper">
									<input class="file-path" type="text"
										placeholder="Upload Hotel Footer"
										style="font-weight: normal; font-size: 14px;">
								</div>
							</div>
							
							<div class="">
								<div class="input-field ">
									<a href="javascript: hotelSubmitform()" id="addNewHotel" class="btn ">Add Hotel</a>
									<button type="reset" class="btn ">Clear</button>
									<br> <br> <br>
								</div>
							</div>
						
					</div>
	       
	      </div>
	 	</form:form>
	  
	</div>
	
	<!-- end of the add hotel popup -->
	
	
	
	
	<div class="container" style="width: 95%; display: none">
		<div class="row">

			<div class="col col s4 m4 l4 ">
				<div class=" grey lighten-3"
					style="box-shadow: 0 2px 5px 0 #000, 0 2px 10px 0 #000; padding: 1% 0% 3% 6%">

					<div id="jstree-proton-1" class="proton-demo">
						<ul style="font-family: Roboto, sans-serif;">
							<li class="jstree-open"><b>Template</b> <c:forEach
									var="listOfEgsdTemplateObjects"
									items="${listOfEgsdTemplateObjects}">
									<ul>
										<li class="jstree-open"><a onclick="Temp_click(this.id)"
											id="${listOfEgsdTemplateObjects.objectId }"><b>${listOfEgsdTemplateObjects.name}</b></a>
											<c:forEach var="direcObjList" items="${direcObjList}">
												<ul>
													<c:if
														test="${listOfEgsdTemplateObjects.objectId eq direcObjList.directoryId }">
														<li class="jstree-open"
															style="font-family: 'Open Sans', sans-serif; font-size: 16px"><a
															id="${direcObjList.objectId}"
															onclick="reply_click(this.id)">${direcObjList.title}</a>
															<ul>
																<c:forEach var="subDirObj" items="${subDirObj}">
																	<c:if
																		test="${direcObjList.objectId eq subDirObj.directoryId }">
																		<li class="jstree-open"><a
																			onclick="reply_click(this.id)"
																			id="${subDirObj.objectId }">${subDirObj.title }</a>
																			<ul>
																				<c:forEach var="subsubDirObj"
																					items="${subsubDirObj }">
																					<c:if
																						test="${(subDirObj.objectId eq subsubDirObj.directoryId) }">


																						<c:if
																							test="${(subsubDirObj.directoryId eq subsubDirObj.directoryId) }">

																							<li class="jstree-open"><a
																								title="${subsubDirObj.title }"
																								id="${subsubDirObj.objectId }"
																								onclick="reply_click(this.id)">
																									${subsubDirObj.title } </a>
																								<ul>
																									<c:forEach var="DirObjId" items="${DirObjId }">
																										<c:if
																											test="${subsubDirObj.objectId eq DirObjId.directoryId }">
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
								</c:forEach> <!-- 	</li>
					</ul> --> <!-- <li> <a href="addLocation"><em>AddLocation</em></a></li> -->
					</li>
					</ul>
					</div>

				</div>
			</div>


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
						class=" waves-red btn-flat modal-action modal-close">Disagree</a>
					<a href="#"
						class=" waves-green btn-flat modal-action modal-close">Agree</a>
				</div>
			</div>


			<div class="col col s8 s8 l8">
				
				<div id="divSection"
					style="display:none;font-family: 'Open Sans', sans-serif; background-color: #fff; border-radius: 5px; box-shadow: 0 2px 5px 0 #000, 0 2px 10px 0 #000;">
					
					<div class="grey lighten-3"
									style="box-shadow: 0 2px 5px 0 #000, 0 2px 10px 0 #000; padding: 2% 5% 3% 5%">
									
									<div class="row" id="actionItems">
										  
										
									</div>

									<div class="divider"></div>
									
									<!-- Displaying Title -->
									<div id="displayDirectoryTitle">
										
									</div>

									<!-- Displaying Caption -->
									<div id="displayDirectoryCaption">
										
									</div>
									
									<br/>

									<!-- Displaying Timings -->
									<div id="displayDirectoryTimings">
										
									</div>
									

									<!-- Displaying Discription-->
									<div id="displayDirectoryDesc">
									
									</div>
									
									<!-- Displaying Image-->
									<div id="displayDirectoryImage">
									
									</div>
									
									<table class="table table-hover" style="background-color:#EEEEEE">
									     
									     <tbody id="displayDirectoryMenuList"></tbody>
									     
									    
									
									</table>
						
									
					</div>
					
				</div>
				
				
				<!--Start of displaying Location Details  -->
				
				
				<div class="locPopup">
					<div class="row"
						style="border-radius: 5px; box-shadow: 0 2px 5px 0 #000, 0 2px 10px 0 #000;">

						<c:forEach var="listOfEgsdTemplateObjects"
							items="${listOfEgsdTemplateObjects }">

											<div
								class="${listOfEgsdTemplateObjects.objectId } grey lighten-3"
								style="display: none; box-shadow: 0 2px 5px 0 #000, 0 2px 10px 0 #000; padding: 2% 5% 3% 5%">



								



								<div class="row">
									<a id="${listOfEgsdTemplateObjects.objectId }"
										onclick="preview_Directory_click(this.id)"
										class=" waves-light btn right"
										style="margin: 0 7px">Preview</a>
										<%-- <a id="${listOfEgsdTemplateObjects.objectId }"
									    onclick="edit_Template_click(this.id)" class=" waves-light btn modal-trigger right"
									    href="#editTemplate" style="margin: 0 7px">Edit Template</a>  --%>
										 <a
										id="${listOfEgsdTemplateObjects.objectId }"
										onclick="del_Loc_click(this.id)"
										class=" waves-light btn modal-trigger right"
										href="#deleteLocation" style="margin: 0 7px">Delete this
										Template</a> <a id="${listOfEgsdTemplateObjects.objectId }"
										onclick="add_DirectoryItems_click(this.id)"
										class=" waves-light btn modal-trigger right"
										href="#add" style="margin: 0 7px">Add Directory Item</a>
								</div>

								<div class="divider"></div>

								<br />
								<div class="row"></div>
								

							</div>

						</c:forEach>

						
					</div>
					<!--End of Displaying location Details  -->


				</div>

			</div>
		</div>
		
		<!--  Popup code  -->


		
		
			<!--Deleting Location  -->
		<div class="deleteLocation"
			style="display: none; opacity: 1; top: 10%; max-height: 50%; padding: 0 25px 0 25px;">
			<div id="deleteLocation" class="modal">
				<a href="#"
					class="waves-effect waves-green btn-flat modal-action modal-close right">Close</a>
				<div class="modal-content">

					<center>
						<h5>Delete Template</h5>
					</center>
					<c:forEach var="listOfEgsdTemplateObjects"
						items="${listOfEgsdTemplateObjects}">

						<div class=${listOfEgsdTemplateObjects.objectId }
							style="display: none; padding: 60px; text-align: justify">

							<a>Are you Sure To delete the Following Template
								</a>


							<form action="deleteTemplate" method="post">

								"${listOfEgsdTemplateObjects.name}" <input type="hidden"
									value="${listOfEgsdTemplateObjects.objectId}"
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
		
		
		<div id="jstreeSpin" class="modal" style="height:36%">
				<div class="modal-content">
					
					<h5 style="text-align:center"><b >Working....</b></h5>
					<br/>
					<div class="preloader-wrapper small active groupSpin" style="margin:-2% 0 0 46%">
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
					
				</div>
				
			</div>
		
		

		<a href="#jstreeSpin" class="modal-trigger" id="spinTree"
	    style="font-size: 1rem; display:none;padding: 0.5rem 0.5rem;"></a>

		
		<a href="#add" class="modal-trigger" id="addDirItem"
	    style="font-size: 1rem; display:none;padding: 0.5rem 0.5rem;"></a>
	    
	    <a href="#delete" class="modal-trigger" id="delDirItem"
	    style="font-size: 1rem; display:none;padding: 0.5rem 0.5rem;"></a>


		<!--start of Add Diretory  -->
		
			<div class="addDirectoryItemsPopup"
			style="display: none; opacity: 1; top: 10%; max-height: 50%">
			<div id="add" class="modal" style="width:91%;margin-top:36px;overflow: auto;">
				<a href="#"
					class="waves-effect waves-green btn-flat modal-action modal-close right  waves-effect waves-light btn"style="margin-right:34px;margin-top:20px;background-color:#20B2AA;padding:12px; color:white">CANCEL</a>
				<div class="modal-content directorySpin">
					<center><h2 style="margin-left: 76px;margin-top:-40px;" ><span  id="dirItemTitle"></span>  </h2></center>
					<a href="javascript: directorySubmitForm()" class="btn" style="margin-top:10px;margin-left:33px;width:100px;color:white;margin-left: 827px;margin-top:-80px; padding: 10PX;" >Save</a>
<button type="reset" class="btn clearData" id="reset1" onclick="reset1()" style="margin-top:10px;width:100px;color:white;margin-top:-80px;">RESET</button>
					<form:form class="col s12" id="alwaysEnableButtonForm" action="addDirectoryItems" name="addDirectory"
											method="post" commandName="addLocation"
											enctype="multipart/form-data">
											
					<input type="hidden" id="dirObjectId" name="objectId"/>
					<input type="hidden" id="directoryDirectoryId" name="directoryId"/>
					<input type="hidden" id="directoryStyleId" name="styleId"/>
					<input type="hidden" id="directoryLocationId" name="locationId"/>
					<input type="hidden" id="dirTempId" name="tempId"/>
					<input type="hidden" id="objectIdOfLocation" name="objectIdOfLocation"/>
					<input type="hidden" value="${userName}" name="userName">
					<input type="hidden" value="${user}" name="user">
					<div class="row" >
    <div class="col s2" style="
    margin-left: -39px;
    margin-top: -21px;
">
      <ul class="tabs tabs-left"style="margin-top: 45px;">
        <li class="tab col s12"><a class="active" href="#test1"style="color:white !important">Title</a></li>
        <li class="tab col s12"><a href="#test2"style="color:white !important">Caption</a></li>
        <li class="tab col s12"><a href="#test3"style="color:white !important">Timings</a></li>
        <li class="tab col s12"><a href="#test4"style="color:white !important">Description</a></li> 
        <li class="tab col s12"><a href="#test5"style="color:white !important">Image</a></li>
        <li class="tab col s12"><a href="#test6"style="color:white !important">Addmenu</a></li>
        <li class="tab col s12"><a href="#test7"style="color:white !important">AddContact</a></li>
<!--        <li class="tab col s12"><a href="#test8"style="color:white !important">AddContact</a></li>
 -->      </ul>
    </div>
    <div id="test1" class="col s10"style="margin-top: 40px;">
    	<div class="row">
												<div class="input-field col s3">
													<input type="text" style="font-weight: normal; font-size: 14px"  required="" id="dirTitle0"  class="title" name="title"> <label style="font-weight: normal; font-size: 14px" class="active">Title</label>

												</div>
												<div class="input-field col s3">
													<input type="text" style="font-weight: normal; font-size: 14px; background-image: none; color: rgb(54, 35, 219)" value="3623DB" id="dirTitleColor0" name="titleColor" class="color" autocomplete="off"> <label style="font-weight: normal; font-size: 14px;" class="active">Color</label>
												</div>
												<div class="input-field col s3">
													<select name="titleFont" id="dirTitleFont0" class="browser-default">
														<option style="font-size: initial" value="initial">initial</option>
														<option style="font-size: xx-small" value="xx-small">xx-small</option>
														<option style="font-size: x-small" value="x-small">x-small</option>
														<option style="font-size: small" value="small">small</option>
														<option style="font-size: medium" value="medium">medium</option>
														<option style="font-size: large" value="large">large</option>
														<option style="font-size: x-large" value="x-large">x-large</option>
														<option style="font-size: xx-large" value="xx-large">xx-large</option>
														<option style="font-size: smaller" value="smaller">smaller</option>
														<option style="font-size: larger" value="larger">larger</option>
													</select>
												</div>
												<div class="input-field col s3">
													<select name="titleFamily" id="dirTitleFamily0" class="browser-default">
														<option style="font-family:Courier New" value="Courier New">Courier New</option>
														<option style="font-family:Lucida Console" value="Lucida Console">Lucida Console</option>
														<option style="font-family:Verdana" value="Verdana">Verdana</option>
														<option style="font-family:Trebuchet MS" value="Trebuchet MS">sans-serif</option>
														<option style="font-family:Tahoma" value="Tahoma">Tahoma</option>
														<option style="font-family:Lucida Sans Unicode" value="Lucida Sans Unicode">Lucida Grande</option>
														<option style="font-family:Charcoal" value="Charcoal">Charcoal</option>
														<option style="font-family:Comic Sans MS" value="Comic Sans MS">Comic Sans MS</option>
														<option style="font-family:Arial Black" value="Arial Black">Arial Black</option>
														<option style="font-family:Arial" value="Arial">Arial</option>
														<option style="font-family:Times New Roman" value="Times New Roman">Times New Roman</option>
														<option style="font-family:Palatino Linotype" value="Palatino Linotype">Palatino Linotype</option>
														<option style="font-family:Georgia" value="Georgia">Georgia</option>
													</select>
												</div>
		</div>
		
    </div>
    <div id="test2" class="col s10" style="margin-top: 40px;">
    	<div class="row">
												<div class="input-field col s3">
													<input type="text" style="font-weight: normal; font-size: 14px" required="" class="title" id="dirCaption0" name="caption"> <label style="font-weight: normal; font-size: 14px" class="active">Caption</label>
												</div>
												<div class="input-field col s3">
													<input type="text" style="font-weight: normal; font-size: 14px; background-image: none; color: rgb(54, 35, 219);" id="dirCaptionColor0" value="3623DB" name="captionColor" class="color" autocomplete="off"> <label style="font-weight: normal; font-size: 14px;" class="active">Color</label>
												</div>
												<div class="input-field col s3">
													<select name="captionFont" id="dirCaptionFont0" class="browser-default">
														<option style="font-size: initial" value="initial">initial</option>
														<option style="font-size: xx-small" value="xx-small">xx-small</option>
														<option style="font-size: x-small" value="x-small">x-small</option>
														<option style="font-size: small" value="small">small</option>
														<option style="font-size: medium" value="medium">medium</option>
														<option style="font-size: large" value="large">large</option>
														<option style="font-size: x-large" value="x-large">x-large</option>
														<option style="font-size: xx-large" value="xx-large">xx-large</option>
														<option style="font-size: smaller" value="smaller">smaller</option>
														<option style="font-size: larger" value="larger">larger</option>
													</select>
												</div>
												<div class="input-field col s3">
													<select name="captionFamily" id="dirCaptionFamily0" class="browser-default">
														<option style="font-family:Courier New" value="Courier New">Courier New</option>
														<option style="font-family:Lucida Console" value="Lucida Console">Lucida Console</option>
														<option style="font-family:Verdana" value="Verdana">Verdana</option>
														<option style="font-family:Trebuchet MS" value="Trebuchet MS">sans-serif</option>
														<option style="font-family:Tahoma" value="Tahoma">Tahoma</option>
														<option style="font-family:Lucida Sans Unicode" value="Lucida Sans Unicode">Lucida Grande</option>
														<option style="font-family:Charcoal" value="Charcoal">Charcoal</option>
														<option style="font-family:Comic Sans MS" value="Comic Sans MS">Comic Sans MS</option>
														<option style="font-family:Arial Black" value="Arial Black">Arial Black</option>
														<option style="font-family:Arial" value="Arial">Arial</option>
														<option style="font-family:Times New Roman" value="Times New Roman">Times New Roman</option>
														<option style="font-family:Palatino Linotype" value="Palatino Linotype">Palatino Linotype</option>
														<option style="font-family:Georgia" value="Georgia">Georgia</option>
													</select>
												</div>
		</div>
    </div>
    <div id="test3" class="col s10" style="margin-top: 40px;">
    	<div class="row">
												<div class="input-field col s3">
													<input type="text" style="font-weight: normal; font-size: 14px" id="dirTimings0" required="" class="title" name="timings"> <label style="font-weight: normal; font-size: 14px" class="active">Timings</label>
												</div>
												<div class="input-field col s3">
													<input type="text" style="font-weight: normal; font-size: 14px; background-image: none; color: rgb(54, 35, 219);" id="dirTimingsColor0" value="3623DB" name="timingsColor" class="color" autocomplete="off"> <label style="font-weight: normal; font-size: 14px" class="active">Color</label>
												</div>
												<div class="input-field col s3">
													<select name="timingsFont" id="dirTimingsFont0" class="browser-default">
														<option style="font-size: initial" value="initial">initial</option>
														<option style="font-size: xx-small" value="xx-small">xx-small</option>
														<option style="font-size: x-small" value="x-small">x-small</option>
														<option style="font-size: small" value="small">small</option>
														<option style="font-size: medium" value="medium">medium</option>
														<option style="font-size: large" value="large">large</option>
														<option style="font-size: x-large" value="x-large">x-large</option>
														<option style="font-size: xx-large" value="xx-large">xx-large</option>
														<option style="font-size: smaller" value="smaller">smaller</option>
														<option style="font-size: larger" value="larger">larger</option>
													</select>
												</div>
												<div class="input-field col s3">
													<select name="timingsFamily" id="dirTimingsFamily0" class="browser-default">
														<option style="font-family:Courier New" value="Courier New">Courier New</option>
														<option style="font-family:Lucida Console" value="Lucida Console">Lucida Console</option>
														<option style="font-family:Verdana" value="Verdana">Verdana</option>
														<option style="font-family:Trebuchet MS" value="Trebuchet MS">sans-serif</option>
														<option style="font-family:Tahoma" value="Tahoma">Tahoma</option>
														<option style="font-family:Lucida Sans Unicode" value="Lucida Sans Unicode">Lucida Grande</option>
														<option style="font-family:Charcoal" value="Charcoal">Charcoal</option>
														<option style="font-family:Comic Sans MS" value="Comic Sans MS">Comic Sans MS</option>
														<option style="font-family:Arial Black" value="Arial Black">Arial Black</option>
														<option style="font-family:Arial" value="Arial">Arial</option>
														<option style="font-family:Times New Roman" value="Times New Roman">Times New Roman</option>
														<option style="font-family:Palatino Linotype" value="Palatino Linotype">Palatino Linotype</option>
														<option style="font-family:Georgia" value="Georgia">Georgia</option>
													</select>
												</div>
		</div>
    </div>
    
    <div id="test4" class="col s10">
   
    <div class="row" style="width:100%;margin:23px 0 0 16px">
    
    		<textarea ></textarea>
    		<input type="hidden" id="dirDescption0" name="description" />
    		
						<!-- <div class="card" >
                        <div class="card-body card-padding">
                            <div class="html-editor" ></div>
                            <input type="hidden" id="dirDescption0" name="description" />
                        </div>
                    </div>	 -->					
		</div>
    </div>
    
    
    <div id="test5" class="col s10">
    		<div class="row">

    <div class="file-field input-field" >
      <div class="btn" style="width:133px;height:39px;margin-top: 87px;
    margin-left: 180px; color:white;">
        <span>Upload Image</span>
        <input type="file" name="logo">
      </div>
      <div class="file-path-wrapper" >
        <input class="file-path validate" id="imgUrl" type="text" style="font-size:20px;width:400px;height:39px; margin-top: 87px;
    margin-left: 3px;">
      </div>
    </div> 
								
		</div>
    </div>
    <div id="test6" class="col s10">
   <div class="input-field col s12"
						style="margin: 10px 0 0 0px;padding:0 0 0 0">
			
									          
									          

 	<div class="row" style="margin-left:17px;">
												
												<div class="input-field col s3">
													<input type="text" style="font-weight: normal; font-size: 14px; background-image: none; color: rgb(54, 35, 219);" value="3623DB" id="dirPriceColor" name="priceColor" class="color" autocomplete="off"> <label style="font-weight: normal; font-size: 14px;margin-top:-17px;" class="">Color</label>
												</div>
												<div class="input-field col s3">
													<select name="priceFont" id="dirPriceFont" class="browser-default">
														<option style="font-size: initial" value="initial">initial</option>
														<option style="font-size: xx-small" value="xx-small">xx-small</option>
														<option style="font-size: x-small" value="x-small">x-small</option>
														<option style="font-size: small" value="small">small</option>
														<option style="font-size: medium" value="medium">medium</option>
														<option style="font-size: large" value="large">large</option>
														<option style="font-size: x-large" value="x-large">x-large</option>
														<option style="font-size: xx-large" value="xx-large">xx-large</option>
														<option style="font-size: smaller" value="smaller">smaller</option>
														<option style="font-size: larger" value="larger">larger</option>
													</select>
												</div>
												<div class="input-field col s3">
													<select name="priceFamily" id="dirPriceFamily" class="browser-default">
														<option style="font-family:Courier New" value="Courier New">Courier New</option>
														<option style="font-family:Lucida Console" value="Lucida Console">Lucida Console</option>
														<option style="font-family:Verdana" value="Verdana">Verdana</option>
														<option style="font-family:Trebuchet MS" value="Trebuchet MS">sans-serif</option>
														<option style="font-family:Tahoma" value="Tahoma">Tahoma</option>
														<option style="font-family:Lucida Sans Unicode" value="Lucida Sans Unicode">Lucida Grande</option>
														<option style="font-family:Charcoal" value="Charcoal">Charcoal</option>
														<option style="font-family:Comic Sans MS" value="Comic Sans MS">Comic Sans MS</option>
														<option style="font-family:Arial Black" value="Arial Black">Arial Black</option>
														<option style="font-family:Arial" value="Arial">Arial</option>
														<option style="font-family:Times New Roman" value="Times New Roman">Times New Roman</option>
														<option style="font-family:Palatino Linotype" value="Palatino Linotype">Palatino Linotype</option>
														<option style="font-family:Georgia" value="Georgia">Georgia</option>
													</select>
												</div>
		</div>
		
		<div class="TextBoxesGroup" style="margin-left:12px;">
													<div class="TextBoxDiv0">
														
														<div class="row" id="menuDiv" style="margin-left:4px;">
															
															<div class="input-field col s4">
																<input type="text" class="description0" name="menuDescription0" style="font-weight: normal; font-size: 14px"> <label class="active" for="first_name2" style="font-weight: normal; font-size: 14px">MenuItem Description</label>
															</div>
															
															
															
															<div class="input-field col s2">
																<input type="text" class="price0" name="menuPrice0" onkeypress="return isNumber(event)" style="font-weight: normal; font-size: 14px"> <label class="active" for="first_name2" style="font-weight: normal; font-size: 14px">Price</label>
															</div>
															
															
																<input type="button" value="Delete" style="width:70px;color:white;margin-left:10px;margin-top:16px;"class="removeButton btn input-field col s1">
															
															
															
															
															
															
														  </div>
														  
														  <div id="menuItemsDetails"></div>
													</div>
		</div>
<div class="left">
														<input type="button" value="Add Menu Item" class="addButton btn" style="padding:0 47px 0 47px;color:white;margin-left:23px;">
														
													</div>


			
			
			
</div>

    </div>
   
   
    
    
    
    
 <div id="test7" class="col s10">
    <div class="input-field col s12"
						style="margin: 10px 0 17px 0px;padding:0 0 0 0">
  <div class="col s12" id="contactHBFJRBdxRo" style="padding: 0px;margin-top:2%; display: block;">
												
												<!-- <div class="manageTextBoxDiv1"></div> -->
												
												
												<div class="manageTextBoxesGroup" style="margin-left:16px;">
													<div class="manageTextBoxDiv0">
														
														<div class="row" id="phoneDiv" style="margin-left:10px;">
															<div class="input-field col s3">
																<select class="browser-default type0" name="manageType0">
																	<option value="" disabled="" selected="">
																		Phone/Email/Website</option>
																	<option value="phone">Phone</option>
																	<option value="email">Email</option>
																	<option value="website">Website</option>
																</select>
															</div>
															
															<div class="input-field col s2">
																<input type="text" name="manageDetails0" class="details0" style="font-size:14px;font-weight:normal"> <label for="textbox1">
																	</label>
															</div>
															<input type="button" value="Delete" style="width:70px;color:white;margin-left:10px;margin-top:16px;"class="manageRemoveButton btn input-field col s1">
															
														</div>
														
														<div id="phoneItemsDetails"></div>
														
													</div>
												</div>
											<input type="button" value="Add Contacts" class="manageAddButton btn" style="width:203px;margin-left:34px;color:white;">
											 
											</div>
											<input type="hidden" class="counter" name="counter" value="0" />
											<input type="hidden" value="0" name="manageCount" class="manageCount"/>
											</div>
	<br/>

			
	
	
	
	
    </div>
  
   
    </div></form:form>
   </div>
		</div>
		
		
		</div>
		
		
		<!-- End of Add Directory -->
		
		
		
		<!--start of Add Diretory  -->
		
			<div class="editTemplatePopup"
			style="display: none; opacity: 1; top: 10%; max-height: 50%">
			<div id="editTemplate" class="modal" style="width:91%;margin-top:36px;overflow: auto;">
				<a href="#"
					class="waves-effect waves-green btn-flat modal-action modal-close right  waves-effect waves-light btn"style="margin-right:34px;margin-top:20px;background-color:#20B2AA;padding:12px; color:white">CANCEL</a>
				<div class="modal-content directorySpin">
					<center><h2 style="margin-left: 76px;margin-top:-40px;" ><span  id="dirItemTitle"></span>  </h2></center>
					<a href="javascript: directorySubmitForm()" class="btn" style="margin-top:10px;margin-left:33px;width:100px;color:white;margin-left: 827px;margin-top:-80px; padding: 10PX;" >Save</a>
<button type="reset" class="btn clearData" id="reset1" onclick="reset1()" style="margin-top:10px;width:100px;color:white;margin-top:-80px;">RESET</button>
					<form:form class="col s12" id="alwaysEnableButtonForm" action="addDirectoryItems" name="addDirectory"
											method="post" commandName="addLocation"
											enctype="multipart/form-data">
											
					<input type="hidden" id="dirObjectId" name="objectId"/>
					<input type="hidden" id="directoryDirectoryId" name="directoryId"/>
					<input type="hidden" id="directoryStyleId" name="styleId"/>
					<input type="hidden" id="directoryLocationId" name="locationId"/>
					<input type="hidden" id="dirTempId" name="tempId"/>
					<input type="hidden" id="objectIdOfLocation" name="objectIdOfLocation"/>
					<input type="hidden" value="${userName}" name="userName">
					<input type="hidden" value="${user}" name="user">
					<div class="row" >
    <div class="col s2" style="
    margin-left: -39px;
    margin-top: -21px;
">
      <ul class="tabs tabs-left"style="margin-top: 45px;">
        <li class="tab col s12"><a class="active" href="#test111"style="color:white !important">Title</a></li>
        <li class="tab col s12"><a href="#test222"style="color:white !important">Caption</a></li>
        <li class="tab col s12"><a href="#test333"style="color:white !important">Timings</a></li>
        <li class="tab col s12"><a href="#test444"style="color:white !important">Description</a></li> 
        <li class="tab col s12"><a href="#test555"style="color:white !important">Image</a></li>
       
<!--        <li class="tab col s12"><a href="#test8"style="color:white !important">AddContact</a></li>
 -->      </ul>
    </div>
    <div id="test111" class="col s10"style="margin-top: 40px;">
    	<div class="row">
												<div class="input-field col s3">
													<input type="text" style="font-weight: normal; font-size: 14px"  required="" id="dirTitle0"  class="title" name="title"> <label style="font-weight: normal; font-size: 14px" class="active">Title</label>

												</div>
												<div class="input-field col s3">
													<input type="text" style="font-weight: normal; font-size: 14px; background-image: none; color: rgb(54, 35, 219)" value="3623DB" id="dirTitleColor0" name="titleColor" class="color" autocomplete="off"> <label style="font-weight: normal; font-size: 14px;" class="active">Color</label>
												</div>
												<div class="input-field col s3">
													<select name="titleFont" id="dirTitleFont0" class="browser-default">
														<option style="font-size: initial" value="initial">initial</option>
														<option style="font-size: xx-small" value="xx-small">xx-small</option>
														<option style="font-size: x-small" value="x-small">x-small</option>
														<option style="font-size: small" value="small">small</option>
														<option style="font-size: medium" value="medium">medium</option>
														<option style="font-size: large" value="large">large</option>
														<option style="font-size: x-large" value="x-large">x-large</option>
														<option style="font-size: xx-large" value="xx-large">xx-large</option>
														<option style="font-size: smaller" value="smaller">smaller</option>
														<option style="font-size: larger" value="larger">larger</option>
													</select>
												</div>
												<div class="input-field col s3">
													<select name="titleFamily" id="dirTitleFamily0" class="browser-default">
														<option style="font-family:Courier New" value="Courier New">Courier New</option>
														<option style="font-family:Lucida Console" value="Lucida Console">Lucida Console</option>
														<option style="font-family:Verdana" value="Verdana">Verdana</option>
														<option style="font-family:Trebuchet MS" value="Trebuchet MS">sans-serif</option>
														<option style="font-family:Tahoma" value="Tahoma">Tahoma</option>
														<option style="font-family:Lucida Sans Unicode" value="Lucida Sans Unicode">Lucida Grande</option>
														<option style="font-family:Charcoal" value="Charcoal">Charcoal</option>
														<option style="font-family:Comic Sans MS" value="Comic Sans MS">Comic Sans MS</option>
														<option style="font-family:Arial Black" value="Arial Black">Arial Black</option>
														<option style="font-family:Arial" value="Arial">Arial</option>
														<option style="font-family:Times New Roman" value="Times New Roman">Times New Roman</option>
														<option style="font-family:Palatino Linotype" value="Palatino Linotype">Palatino Linotype</option>
														<option style="font-family:Georgia" value="Georgia">Georgia</option>
													</select>
												</div>
		</div>
		
    </div>
    <div id="test222" class="col s10" style="margin-top: 40px;">
    	<div class="row">
												<div class="input-field col s3">
													<input type="text" style="font-weight: normal; font-size: 14px" required="" class="title" id="dirCaption0" name="caption"> <label style="font-weight: normal; font-size: 14px" class="active">Caption</label>
												</div>
												<div class="input-field col s3">
													<input type="text" style="font-weight: normal; font-size: 14px; background-image: none; color: rgb(54, 35, 219);" id="dirCaptionColor0" value="3623DB" name="captionColor" class="color" autocomplete="off"> <label style="font-weight: normal; font-size: 14px;" class="active">Color</label>
												</div>
												<div class="input-field col s3">
													<select name="captionFont" id="dirCaptionFont0" class="browser-default">
														<option style="font-size: initial" value="initial">initial</option>
														<option style="font-size: xx-small" value="xx-small">xx-small</option>
														<option style="font-size: x-small" value="x-small">x-small</option>
														<option style="font-size: small" value="small">small</option>
														<option style="font-size: medium" value="medium">medium</option>
														<option style="font-size: large" value="large">large</option>
														<option style="font-size: x-large" value="x-large">x-large</option>
														<option style="font-size: xx-large" value="xx-large">xx-large</option>
														<option style="font-size: smaller" value="smaller">smaller</option>
														<option style="font-size: larger" value="larger">larger</option>
													</select>
												</div>
												<div class="input-field col s3">
													<select name="captionFamily" id="dirCaptionFamily0" class="browser-default">
														<option style="font-family:Courier New" value="Courier New">Courier New</option>
														<option style="font-family:Lucida Console" value="Lucida Console">Lucida Console</option>
														<option style="font-family:Verdana" value="Verdana">Verdana</option>
														<option style="font-family:Trebuchet MS" value="Trebuchet MS">sans-serif</option>
														<option style="font-family:Tahoma" value="Tahoma">Tahoma</option>
														<option style="font-family:Lucida Sans Unicode" value="Lucida Sans Unicode">Lucida Grande</option>
														<option style="font-family:Charcoal" value="Charcoal">Charcoal</option>
														<option style="font-family:Comic Sans MS" value="Comic Sans MS">Comic Sans MS</option>
														<option style="font-family:Arial Black" value="Arial Black">Arial Black</option>
														<option style="font-family:Arial" value="Arial">Arial</option>
														<option style="font-family:Times New Roman" value="Times New Roman">Times New Roman</option>
														<option style="font-family:Palatino Linotype" value="Palatino Linotype">Palatino Linotype</option>
														<option style="font-family:Georgia" value="Georgia">Georgia</option>
													</select>
												</div>
		</div>
    </div>
    <div id="test333" class="col s10" style="margin-top: 40px;">
    	<div class="row">
												<div class="input-field col s3">
													<input type="text" style="font-weight: normal; font-size: 14px" id="dirTimings0" required="" class="title" name="timings"> <label style="font-weight: normal; font-size: 14px" class="active">Timings</label>
												</div>
												<div class="input-field col s3">
													<input type="text" style="font-weight: normal; font-size: 14px; background-image: none; color: rgb(54, 35, 219);" id="dirTimingsColor0" value="3623DB" name="timingsColor" class="color" autocomplete="off"> <label style="font-weight: normal; font-size: 14px" class="active">Color</label>
												</div>
												<div class="input-field col s3">
													<select name="timingsFont" id="dirTimingsFont0" class="browser-default">
														<option style="font-size: initial" value="initial">initial</option>
														<option style="font-size: xx-small" value="xx-small">xx-small</option>
														<option style="font-size: x-small" value="x-small">x-small</option>
														<option style="font-size: small" value="small">small</option>
														<option style="font-size: medium" value="medium">medium</option>
														<option style="font-size: large" value="large">large</option>
														<option style="font-size: x-large" value="x-large">x-large</option>
														<option style="font-size: xx-large" value="xx-large">xx-large</option>
														<option style="font-size: smaller" value="smaller">smaller</option>
														<option style="font-size: larger" value="larger">larger</option>
													</select>
												</div>
												<div class="input-field col s3">
													<select name="timingsFamily" id="dirTimingsFamily0" class="browser-default">
														<option style="font-family:Courier New" value="Courier New">Courier New</option>
														<option style="font-family:Lucida Console" value="Lucida Console">Lucida Console</option>
														<option style="font-family:Verdana" value="Verdana">Verdana</option>
														<option style="font-family:Trebuchet MS" value="Trebuchet MS">sans-serif</option>
														<option style="font-family:Tahoma" value="Tahoma">Tahoma</option>
														<option style="font-family:Lucida Sans Unicode" value="Lucida Sans Unicode">Lucida Grande</option>
														<option style="font-family:Charcoal" value="Charcoal">Charcoal</option>
														<option style="font-family:Comic Sans MS" value="Comic Sans MS">Comic Sans MS</option>
														<option style="font-family:Arial Black" value="Arial Black">Arial Black</option>
														<option style="font-family:Arial" value="Arial">Arial</option>
														<option style="font-family:Times New Roman" value="Times New Roman">Times New Roman</option>
														<option style="font-family:Palatino Linotype" value="Palatino Linotype">Palatino Linotype</option>
														<option style="font-family:Georgia" value="Georgia">Georgia</option>
													</select>
												</div>
		</div>
    </div>
    
    <div id="test444" class="col s10">
   
    <div class="row" style="width:100%;margin:23px 0 0 16px">
    
    		<textarea ></textarea>
    		<input type="hidden" id="dirDescption0" name="description" />
    		
						<!-- <div class="card" >
                        <div class="card-body card-padding">
                            <div class="html-editor" ></div>
                            <input type="hidden" id="dirDescption0" name="description" />
                        </div>
                    </div>	 -->					
		</div>
    </div>
    
    
    <div id="test5" class="col s10">
    		<div class="row">

    <div class="file-field input-field" >
      <div class="btn" style="width:133px;height:39px;margin-top: 87px;
    margin-left: 180px; color:white;">
        <span>Upload Image</span>
        <input type="file" name="logo">
      </div>
      <div class="file-path-wrapper" >
        <input class="file-path validate" id="imgUrl" type="text" style="font-size:20px;width:400px;height:39px; margin-top: 87px;
    margin-left: 3px;">
      </div>
    </div> 
								
		</div>
    </div>
    
    </div></form:form>
   </div>
		</div>
		
		
		</div>
		
		
		<!-- End of edit template -->



		<!--Displaying Deleted files -->
		<div class="delPopup"
			style="display: none; margin-top: 10px; padding: 40px 20px 40px 20px;">


			<div id="delete" class="modal">
				<a href="#"
					class="waves-effect waves-green btn-flat modal-action modal-close right">Close</a>
				<div class="modal-content">
					<center><h5 > Delete Directory Item </h5></center>
					<c:forEach var="showDiscriptionObjId"
						items="${showDiscriptionObjId }">
						<div>

							<div class=${showDiscriptionObjId.objectId }
								style="display: none; text-align: justify">

								<a>Are you sure to delete?</a>

								<form action="delete">

									${showDiscriptionObjId.title} <input type="hidden"
										value="${showDiscriptionObjId.objectId}"
										name="objectIdForDelete"> <input type="hidden"
										value="${showDiscriptionObjId.directoryId}" name="directoryId">
									<input type="hidden"
										value="${showDiscriptionObjId.parentDirectoryId}"
										name="parentDirectoryId"> <input type="hidden"
										value="${showDiscriptionObjId.locationId}" name="locationId">
										<input type="hidden"
										value="${showDiscriptionObjId.locationId}" name="tempId">
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
			

		

		<a class="waves-effect waves-light btn modal-trigger" style="display:none" id="narshimha" href="#modal6">Modal</a>
			<div id="modal6" class="modal">
			    <div class="modal-content">
			     	 <p><span id="userType"></span> has been created successfully. Notification email has been sent to the email id entered with user credentials.</p>
				 
			    </div>
			    <div class="modal-footer">
			      <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat">Ok</a>
			    </div>
			  </div>
 



		 <script type="text/javascript" src="../js/materialize.js"></script>
		 <script type="text/javascript" src="../js/plugins.js"></script>
		 <script type="text/javascript" src="../styles/js/materialize.js"></script>
	 <script type="text/javascript" src="../styles/js/materialize.min.js"></script>
<script src="../styles/vendors/summernote/dist/summernote-updated.min.js"></script>
<script type="text/javascript" src="../styles/js/fun.js"></script>
	
		
		<script>
				  
				  function directorySubmitForm() {				  
						 
					 /*  var editor = $('.note-editable').last().html();
					 editor = "<p>"+editor+"</p>";
					  $('#dirDescption0').val(editor); */
					  
					  
					  var editor = $('#mce_0_ifr').contents().find("body").html();						
						 
					  $('#dirDescption0').val(editor);
					  document.addDirectory.submit();
					  
				  }		    	  
				  
				 
			  function directorySubmitForm1() {				  
				 // $('.note-editable').last().remove();
				 /* var count = $('#editCount').val();
				 if(count == 0)
				 {
					 $('.note-editable').last().remove();
					 var editor = $('.note-editable').last().html();
					 
					  $('#112244').val(editor);
				 }
				 else
				 {
					 var editor = $('.note-editable').last().html();
					 
					  $('#112244').val(editor);
				 }
				 
				 count++;
				 $('#editCount').val(count); */
				 
				 var editor = $('#mce_0_ifr').contents().find("body").html();
				 
				 $('#112244').val(editor);
				  document.editLocation.submit();
				  
			  }
			  
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
					/* for(var i=2;i<20;i++)
					{
						$('.TextBoxDiv'+i).hide();
						
					} */	
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
				'<input type="button" value="Delete" class="editmenuremoveButton btn input-field col s1"style="margin-left:10px;margin-top:16px;">'+
			
				        
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
				
    	var counter = parseInt($('.counter').val());
		if(counter == 0)
		{
			counter = counter+1;
		}
	var newTextBoxDiv = $(document.createElement('div'))
	     .attr("class", 'TextBoxDiv' + counter);
                
	newTextBoxDiv.after().html('<div class="row" style="margin-left:4px">'+
			
			'<div class="input-field col s4">'+
				'<input type="text" class="description'+counter+' " name="menuDescription'+counter+'" style="font-weight: normal; font-size: 14px">'+
				'<label class="active" style="font-weight: normal; font-size: 14px">MenuItem Description</label></div>'+
			'<div class="input-field col s2">'+
				'<input type="text" class="price'+counter+' " name="menuPrice'+counter+'" onkeypress="return isNumber(event)" style="font-weight: normal; font-size: 14px">'+
				'<label class="active" style="font-weight: normal; font-size: 14px">Price</label></div>'+
				'<input type="button" value="Delete" class="removeButton btn input-field col s1" style="margin-left:10px;margin-top:16px;">'+
			
				        
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
		        '<input type="button" value="Delete" class="editmanageremoveButton btn input-field col s1" style="margin-left:10px;margin-top:16px;">'+
		        
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


			$('.modal-action').click(function(){
			
				$('.lean-overlay').css({display:'none'});
			
			});
		    
				
		    $(".manageAddButton").click(function () {
						
		    	var counter = parseInt($('.manageCount').val());
				if(counter == 0)
				{
					counter = counter+1;
				}
			var newTextBoxDiv = $(document.createElement('div'))
			     .attr("class", 'manageTextBoxDiv' + counter);
		                
			newTextBoxDiv.after().html('<div class="row" style="margin-left:10px">'+
				'<div class="input-field col s3"><select name="manageType'+counter+'" style="display:-webkit-inline-box;" class="type'+counter+'"><option value="" disabled selected>Phone/Email/Website</option>'+
						  '<option value="phone">Phone</option>'+
						  '<option value="email">Email</option>'+
						  '<option value="website">Website</option></select></div>'+
				
		        '<div class="input-field col s2">'+
		          '<input class="details'+counter+'" type="text" style="font-size:14px;font-weight:normal" name="manageDetails'+counter+'">'+
		          '<label for="first_name"></label>'+
		        '</div>'+
		        '<input type="button" value="Delete" class="manageRemoveButton btn input-field col s1"style="margin-left:10px;margin-top:16px;">'+
		        
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
		
$('#updateAdminDetails').click(function(){
			
			$('#updateAdminhref').click();
			var email1 = $('#updateHideEmail').val();
			
			$('#supertext').text('Update User Details');
			$('#updateAdmin').val('Update Admin User');
			var fname = $('#updateFname').val();
	    	var lname = $('#UpdateLname').val();
	    	var uname = $('#updateUname').val();
	    	var email = $('#updateEmail').val();
			var user = "${user}";
			var data = {
				"user":user,
				"fname" : fname,
				"lname" : lname,					
				"email" :email
				
			};
			
			if(email1 != ""  )
			{
				$.ajax({
				      type: "POST",
				      url: "updateAdminDetails",
				      async: true,
				      data : data,
				     
				      success :function(results) {			    	  
				    	  
				    	  console.log(results);
				    	  $('.lean-overlay').css({display:'none'});
				    	 
				     },
				     error : function(error) {
				    	 console.log(error);
				    	
				     }
				  });	
			}
			else
			{
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
				    	 
				     },
				     error : function(error) {
				    	 console.log(error);
				    	
				     }
				  });	
			}
			
			
			
			
		});
		
		$('#updateAdminUser').click(function(){
			
			var sEmail = $('#updateHideEmail').val();
			var fname = $('#updateFname').val();
			var lname = $('#UpdateLname').val();
			var uname = $('#updateUname').val();
			var email = $('#updateEmail').val();
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
			
			
			var data = {
					
					"firstname":fname,
					"lastname":lname,
					"username":uname,
					"email":email,
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
				    	  $('.lean-overlay').css({display:'none'});
				    	
				    	
				     },
				     error : function(error) {
				    	 console.log(error);
				    	
				     }
				  });
			}
			
			
			
			
		});
		
			$('.modal-action').click(function(){
				
				$('.lean-overlay').css({display:'none'});
				
			});
			
		
			var lastUsed = null;
			
			$(".locAdmin").click(function(){
				
				var admin = $(this).val();
				//alert(admin);
				
			});

			function reply_click(clicked_id) {
				
				$('#divSection').hide();
				$('.locPopup').hide();
				
				var searchElement = {
		    			"searchId" : clicked_id			    			
		    	};
				$.ajax({
				      type: "POST",
				      url: "editDirectoryDetails",
				      async: true,
				      data : searchElement,
				          
				      success :function(result) {
				    	  	  $('#divSection').show();
				    	  	  debugger;
				    	  	  console.log(result);
				    	  	  localStorage.setItem("TotalDirectoryDetails", JSON.stringify(result));
				    	  	  $('#actionItems').empty();
				    	  	  $('#displayDirectoryTitle').empty();
				    		  $('#displayDirectoryCaption').empty();
				    		  $('#displayDirectoryTimings').empty();
				    		  $('#displayDirectoryDesc').empty();
				    		  $('#displayDirectoryImage').empty();
				    		  $('#displayDirectoryMenuList').empty();
				    		  $('#displayDirectoryPhoneList').empty();
				    		  
				    		  var actionItems = '<a id="'+clicked_id+'" class=" waves-light btn modal-trigger right"'+
										        'onclick="edit_DirectoryItems_click(this.id)" '+
										        'style="margin: 0 7px;width:95px;padding:12px;color:white;">Edit</a>'+ 
												'<a	id="'+clicked_id+'" onclick="del_click(this.id)" class=" waves-light btn modal-trigger right"'+
												'href="#delete" style="margin: 0 7px;width:107px;padding:12px;color:white;">Delete</a>'+
												'<a	id="'+clicked_id+'" onclick="add_DirectoryItems_click(this.id)" class=" waves-light btn modal-trigger right"'+
												'href="#add" style="margin: 0 7px;width:225px; padding:12px;color:white;">ADD DIRECTORY ITEM</a>';
				    	  	  
				    	  	  var dirTitle = '<center style="color: #'+result.styleList[0].titleColor+' ; font-size: '+result.styleList[0].titleFont+';font-family:'+result.styleList[0].titleFamily+'">'+
											 '<b><u>'+result.directoryList[0].title+'</u></b>'+
								             '</center>';
								             
							  var dirCaption = '<center style="color: #'+result.styleList[0].captionColor+' ; font-size: '+result.styleList[0].captionFont+';font-family:'+result.styleList[0].captionFamily+'">'+
											 '<b><u>'+result.directoryList[0].caption+'</u></b>'+
								             '</center>';
								             
							  var dirTimings = '<center style="color: #'+result.styleList[0].timingsColor+' ; font-size: '+result.styleList[0].timingsFont+';font-family:'+result.styleList[0].timingsFamily+'">'+
											 '<b><u>'+result.directoryList[0].timings+'</u></b>'+
								             '</center>';
								             
							  var dirDesc = result.directoryList[0].description;
							  
							  if( result.directoryList[0].picture != "No Image To Display" )
							  {
								  var dirImg = '<center> <img alt="" style="width: 20%; height: 180px;" src="'+result.directoryList[0].picture+'"></center>';
							  }
							  
							  
							  
							  var menuListArray = [];
							  var menuList;
							  var totalDetails;
							  
							  var menuListLength = result.menuList;
							  for(var i=0;i<menuListLength.length;i++)
							  {
								  menuList = '<tr> <td style="padding:7px 0px;width:10%">'+
									 '<p style="margin-top: 0px;margin-bottom:0px;font-size:'+result.styleList[0].priceFont+'; color: #'+result.styleList[0].priceColor+';font-family:'+result.styleList[0].captionFamily+' ">'+result.menuList[i].description+'</p> </td>'+
									 '<td style="padding:7px 5px;width:15%">'+
									 '<div	style="font-size:'+result.styleList[0].priceFont+'; color: #'+result.styleList[0].priceColor+';font-family:'+result.styleList[0].captionFamily+'">'+														
									 '<b>'+result.menuList[i].price+'</b>'+
									 '</div> </td> </tr>';
								  menuListArray.push(menuList);
							  }						  
							  
							  console.log(menuListArray);
							  
							  var phoneListArray = [];
							  var phoneList;
							  var phoneListLength = result.phoneList;
							  
							  for(var i=0;i<phoneListLength.length;i++)
							  {
								  phoneList = '<tr>	<td style="padding:7px 0px;width:10%">'+
											  '<p style="margin-top: 0px;margin-bottom:0px;font-size:14px; font-family: Courier New, Courier, monospace">'+phoneListLength[i].type+'</p>'+
										      '</td>'+
											  '<td style="padding:7px 5px;width:15%">'+
											  '<div	style="font-family: Courier New, Courier, monospace;">'+												
											  '<b>'+phoneListLength[i].ext+'</b>'+						
											  '</div> </td></tr>';
								  
								  phoneListArray.push(phoneList);
							  }
							  
							  
							  
							  $('#actionItems').append(actionItems);
				    		  $('#displayDirectoryTitle').append(dirTitle);
				    		  $('#displayDirectoryCaption').append(dirCaption);
				    		  $('#displayDirectoryTimings').append(dirTimings);
				    		  $('#displayDirectoryDesc').append(dirDesc);
				    		  $('#displayDirectoryImage').append(dirImg);
				    		  totalDetails = menuListArray+phoneListArray;
				    		  $('#displayDirectoryMenuList').append(totalDetails);
				    		  //$('#displayDirectoryPhoneList').append(phoneListArray);
				    		  
				    		  
					    	  
					    	  
					    	  
					    	  
					    	  
					    	  /* var menuLength = result.menuList;
					    	  console.log(menuLength.length);
					    	  $('#menuDiv').remove();
					    	  var menuDetails = "";
					    	  var menuItems = "";
					    	  for(var i=0;i<menuLength.length;i++)
					    	  {
					    		  
					    		  menuItems = '<input type="hidden" value="'+result.menuList[i].objectId+'" name="editmenuObject'+i+'"><div class="row" style="margin-left:4px">'+								
									'<div class="input-field col s4">'+
										'<input type="text" style="font-size:14px;font-weight:normal" name="menuDescription'+i+'" value="'+result.menuList[i].description+'" class="materialize-textarea validate valid" style="height: 22px;"> <label class="active" for="first_name2" style="font-size:14px;font-weight:normal">MenuItem Description</label>'+
									'</div>'+
									'<div class="input-field col s2">'+
										'<input type="text" style="font-size:14px;font-weight:normal" value="'+result.menuList[i].price+'" name="menuPrice'+i+'" class="materialize-textarea validate" style="height: 22px;"> <label class="active" for="first_name2" style="font-size:14px;font-weight:normal">Price</label>'+
									'</div>'+
									
									'<input type="button" value="Delete" style="margin-left:10px" class="editmenuremoveButton btn input-field col s1">'+
									
								'</div>';
					    		  menuDetails = menuDetails+menuItems;
					    		  
					    	  }
					    	  $('#menuItemsDetails').html(menuDetails);
					    	  $('.counter').val(menuLength.length);
					    	  
					    	  $('#phoneDiv').remove();
					    	  var phoneLength = result.phoneList;
					    	  var phoneDetails = "";
					    	  var phoneItems = "";
					    	  for(var i=0;i<phoneLength.length;i++)
					    	  {
					    		  
					    		  phoneItems = '<input type="hidden" name="editphoneObjectId'+i+'" value="'+result.phoneList[i].objectId+'"><div class="row" style="margin-left:10px">'+
								        '<div class="input-field col s3">'+
											'<select class="browser-default type'+i+'" name="manageType'+i+'">'+
												'<option value="'+result.phoneList[i].type+'" selected="">'+result.phoneList[i].type+'</option>'+
												'<option value="phone">Phone</option>'+
												'<option value="email">Email</option>'+
												'<option value="website">Website</option>'+
											'</select>'+
										'</div>'+												
																																
								'<div class="input-field col s2">'+
									'<input type="text" style="font-size:14px;font-weight:normal" value="'+result.phoneList[i].ext+'" name="manageDetails'+i+'" class="materialize-textarea validate" style="height: 22px;"> <label class="active" for="first_name2"></label>'+
								'</div>'+
								
								'<input type="button" value="Delete" style="margin-left:10px" class="editmanageremoveButton btn input-field col s1">'+
							'</div>';
					    		  
					    		phoneDetails = phoneDetails+phoneItems;  
					    		  
					    	  }
					    	  
					    	  $('#phoneItemsDetails').html(phoneDetails);
					    	  $('.manageCount').val(phoneLength.length);
					    	   
					    	  $('.addDirectoryItemsPopup').show(); */
				    	  
					    	  
				    	     	  
				     },
				     error : function(error) {
				    	console.log(error);
				     }
				  });

			}
			
			
			
			function preview_Directory_click(clicked_id) {
			    
			    //alert(clicked_id);
			    window.open("http://betabullsapp.github.io/eGSD/directories.html?id="+clicked_id, "_blank", "toolbar=yes, scrollbars=yes, resizable=yes,left=500, width=320, height=600");
			    
			   }
			
			function preview_Hotel_click(obj)	{
				
				var hId = $(obj).attr("class");
				window.open("http://betabullsapp.github.io/eGSD/directories.html?id="+hId, "_blank", "toolbar=yes, scrollbars=yes, resizable=yes,left=500, width=320, height=600");
			}

			function Loc_click_redirect(clicked_id) {
				
				/* alert(clicked_id); */
				window.location = clicked_id;
				

			}

			function Temp_click(clicked_id) {
				$('.addLocationDiv').hide();

				$('#divSection').hide();

				
				
				$('.locPopup').show();

				$("." + clicked_id).show();
				

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
				
				$('#delDirItem').click();
				$('#overlay').show();
				$('.popup').show();
				$('.selectLocation').hide();
				$('.save').hide();
				$('.addLocationForm').hide();

				$('.delPopup').show();
				prevClicked = lastUsed;
				$("." + prevClicked).hide();

				$("." + clicked_id).show();
				lastUsed = clicked_id;
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
				
				$('.locPopup').hide();
				$('#addDirItem').click();
				$('#dirTitle0').val('');
		    	$('#dirTitleColor0').val('3623DB');
		    	$('#dirTitleFont0').find('option:contains("initial")').attr("selected",true);
		    	$('#dirTitleFamily0').find('option:contains("Courier New")').attr("selected",true);
		    	$('#dirCaption0').val('');
		    	$('#dirCaptionColor0').val('3623DB');
		    	$('#dirCaptionFont0').find('option:contains("initial")').attr("selected",true);
		    	$('#dirCaptionFamily0').find('option:contains("Courier New")').attr("selected",true);
		    	$('#dirTimings0').val('');
		    	$('#dirTimingsColor0').val('3623DB');
		    	$('#dirTimingsFont0').find('option:contains("initial")').attr("selected",true);
		    	$('#dirTimingsFamily0').find('option:contains("Courier New")').attr("selected",true);
		    	
		    	$('#dirPriceColor').val('3623DB');
		    	$('#dirPriceFont').find('option:contains("initial")').attr("selected",true);
		    	$('#dirPriceFamily').find('option:contains("Courier New")').attr("selected",true);
		    			    	
		    	$('#mce_0_ifr').contents().find("body").empty();
							
				$('#menuItemsDetails').hide();
				$('#phoneItemsDetails').hide();
				
				
				$("#alwaysEnableButtonForm").attr("action", "addDirectoryItems");
	    		$('#dirItemTitle').text('Add Directory Item');
				
				$('#dirTitle').val('');
				
				$('#dirCaption').val('');
				
				$('#dirTimings').val('');
				
				$('#dirDescption').val('');
				$('#imgUrl').val('');
				$('#overlay').show();
				$('.popup').show();
				 $('input:checkbox').removeAttr('checked');
				 $('#menu'+clicked_id).hide();
				$('.addLocationDiv').hide();
				$('.addLocationForm').hide();
				var searchElement = {
		    			"searchId" : clicked_id			    			
		    	};
				$.ajax({
				      type: "POST",
				      url: "getDirectoryDetails",
				      async: true,
				      data : searchElement,
				      
				      success :function(result) {
				    	  console.log(result);
				    	  if(result == "" || result == null)
				    	  {
				    		  $('#objectIdOfLocation').val(clicked_id);
				    		  $('#dirTempId').val(clicked_id);
				    		  $('#dirObjectId').val('');
					    	  $('#directoryDirectoryId').val('');
					    	  $('#directoryStyleId').val('');
					    	  $('#directoryLocationId').val('');
					    	  $('.addDirectoryItemsPopup').show();
				    	  }
				    	  else
				    	  {
				    		  //$("#formAction").attr("action", "editDirectoryItem");
				    		  $('#dirObjectId').val(result[0].objectId);
				    		  $('#dirTempId').val(result[0].locationId);
					    	  $('#directoryDirectoryId').val(result[0].directoryId);
					    	  $('#directoryStyleId').val(result[0].styleId);
					    	  $('#directoryLocationId').val(result[0].locationId);
					    	  $('#objectIdOfLocation').val('');
					    	  $('.addDirectoryItemsPopup').show();
				    	  }
				    	  
				    	     	  
				     },
				     error : function(error) {
				    	console.log(error);
				     }
				  }); 

				 
			}
			
			
			function edit_Template_click(clicked_id)
			
			{
				$('.editTemplatePopup').show();
			}
			
			
			function edit_DirectoryItems_click(clicked_id) {
				
				
				
				$('#addDirItem').click();
				$('#menuItemsDetails').show();
				$('#phoneItemsDetails').show();
				
				    $('#dirItemTitle').text('Edit Directory Item');
				    $('#dirTitle0').val('');
			    	$('#dirTitleColor0').val('3623DB');
			    	
			    	$('#dirCaption0').val('');
			    	$('#dirCaptionColor0').val('3623DB');
			    	
			    	$('#dirTimings0').val('');
			    	$('#dirTimingsColor0').val('3623DB');
			    	
			    	$('#dirPriceColor').val('3623DB');
			    			    	
			    	$('#mce_0_ifr').contents().find("body").empty();
				$('#imgUrl').val('');
				$('#overlay').show();
				$('.popup').show();
				 $('input:checkbox').removeAttr('checked');
				 $('#menu'+clicked_id).hide();
				$('.addLocationDiv').hide();
				$('.addLocationForm').hide();
				$("#alwaysEnableButtonForm").attr("action", "edit");
				var result = JSON.parse(localStorage.getItem('TotalDirectoryDetails'));
				    		  $('#dirObjectId').val(result.directoryList[0].objectId);
					    	  $('#directoryDirectoryId').val(result.directoryList[0].directoryId);
					    	  $('#dirTempId').val(result.directoryList[0].locationId);
					    	  $('#directoryStyleId').val(result.directoryList[0].styleId);
					    	  $('#directoryLocationId').val(result.directoryList[0].locationId);
					    	  $('#objectIdOfLocation').val('');
					    	  $('#dirTitle0').val(result.directoryList[0].title);
					    	  $('#dirTitleColor0').val(result.styleList[0].titleColor);
					    	  $('#dirTitleFont0').val(result.styleList[0].titleFont);					    	  
					    	  $('#dirTitleFamily0').val(result.styleList[0].titleFamily);
					    	  $('#dirCaption0').val(result.directoryList[0].caption);
					    	  $('#dirCaptionColor0').val(result.styleList[0].captionColor);
					    	  $('#dirCaptionFont0').val(result.styleList[0].captionFont);
					    	  $('#dirCaptionFamily0').val(result.styleList[0].captionFamily);
					    	  $('#dirTimings0').val(result.directoryList[0].timings);
					    	  $('#dirTimingsColor0').val(result.styleList[0].timingsColor);
					    	  $('#dirTimingsFont0').val(result.styleList[0].timingsFont);
					    	  $('#dirTimingsFamily0').val(result.styleList[0].timingsFamily);
					    	  $('#dirPriceColor').val(result.styleList[0].priceColor);
					    	  $('#dirPriceFont').val(result.styleList[0].priceFont);
					    	  $('#dirPriceFamily').val(result.styleList[0].priceFamily);
					    	  $('#mce_0_ifr').contents().find("body").html(result.directoryList[0].description);
					    	  
					    	  
					    	  var menuLength = result.menuList;
					    	  console.log(menuLength.length);
					    	  $('#menuDiv').remove();
					    	  var menuDetails = "";
					    	  var menuItems = "";
					    	  for(var i=0;i<menuLength.length;i++)
					    	  {
					    		  
					    		  menuItems = '<input type="hidden" value="'+result.menuList[i].objectId+'" name="editmenuObject'+i+'"><div class="row" style="margin-left:4px">'+								
									'<div class="input-field col s4">'+
										'<input type="text" style="font-size:14px;font-weight:normal" name="menuDescription'+i+'" value="'+result.menuList[i].description+'" class="materialize-textarea validate valid" style="height: 22px;"> <label class="active" for="first_name2" style="font-size:14px;font-weight:normal">MenuItem Description</label>'+
									'</div>'+
									'<div class="input-field col s2">'+
										'<input type="text" style="font-size:14px;font-weight:normal" value="'+result.menuList[i].price+'" name="menuPrice'+i+'" class="materialize-textarea validate" style="height: 22px;"> <label class="active" for="first_name2" style="font-size:14px;font-weight:normal">Price</label>'+
									'</div>'+
									
									'<input type="button" value="Delete" style="margin-left:10px" class="editmenuremoveButton btn input-field col s1">'+
									
								'</div>';
					    		  menuDetails = menuDetails+menuItems;
					    		  
					    	  }
					    	  $('#menuItemsDetails').html(menuDetails);
					    	  $('.counter').val(menuLength.length);
					    	  
					    	  $('#phoneDiv').remove();
					    	  var phoneLength = result.phoneList;
					    	  var phoneDetails = "";
					    	  var phoneItems = "";
					    	  for(var i=0;i<phoneLength.length;i++)
					    	  {
					    		  
					    		  phoneItems = '<input type="hidden" name="editphoneObjectId'+i+'" value="'+result.phoneList[i].objectId+'"><div class="row" style="margin-left:10px">'+
								        '<div class="input-field col s3">'+
											'<select class="browser-default type'+i+'" name="manageType'+i+'">'+
												'<option value="'+result.phoneList[i].type+'" selected="">'+result.phoneList[i].type+'</option>'+
												'<option value="phone">Phone</option>'+
												'<option value="email">Email</option>'+
												'<option value="website">Website</option>'+
											'</select>'+
										'</div>'+												
																																
								'<div class="input-field col s2">'+
									'<input type="text" style="font-size:14px;font-weight:normal" value="'+result.phoneList[i].ext+'" name="manageDetails'+i+'" class="materialize-textarea validate" style="height: 22px;"> <label class="active" for="first_name2"></label>'+
								'</div>'+
								
								'<input type="button" value="Delete" style="margin-left:10px" class="editmanageremoveButton btn input-field col s1">'+
							'</div>';
					    		  
					    		phoneDetails = phoneDetails+phoneItems;  
					    		  
					    	  }
					    	  
					    	  $('#phoneItemsDetails').html(phoneDetails);
					    	  $('.manageCount').val(phoneLength.length);
					    	   
					    	  $('.addDirectoryItemsPopup').show();     	  
				   

				  childWindow.location.reload();
			}
			
			
			
			function add_Directory_click(clicked_id) {
				$('#overlay').show();
				$('.popup').show();
				$('.addLocationDiv').hide();
				$('.addLocationForm').hide();
				$('.addDirectoryPopup').show();
				$('#add').modal('show');
				$('#directoryLocationId').val(clicked_id);
				//$("." + clicked_id).show();

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
					debugger;
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
				window.onbeforeunload = function() {};

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
		
		
		$('#asAdmin').click(function(){
			$('#superFirstname').val('');
			$('#superLastname').val('');
			$('#superUsername').val('');
			$('#superEmail').val('');
			$('#saEmail').val('');
			$('#supertext').text('Create Super Admin User');
			$('#createSuperAdmin').text('Create Super Admin');
			//$('#createSuperAdmin').show();
			//$('#updateSuperAdmin').hide();
			$('#sfnameErr').empty();
			$('.userExisted').empty();
			$('#slnameErr').empty();
			$('#sunameErr').empty();
			$('#semailErr').empty();
			
			$('#asAdminhref').click();
			
		});
		
		$('#acAdmin').click(function(){
			$('#csFirstname').val('');
			$('#csLastname').val('');
			$('#csUsername').val('');
			$('#csEmail').val('');
			$('#caEmail').val('');
			$('#cstext').text('Create CS Admin User');
			$('#createCSAdmin').text('Create CS Admin');
			//$('#createCSAdmin').show();
			//$('#updateCSAdmin').hide();
			$('#cfnameErr').empty();
			$('.userExisted').empty();
			$('#clnameErr').empty();
			$('#cunameErr').empty();
			$('#cemailErr').empty();
			
			$('#csAdminhref').click();
			
		});
		
		$('#alAdmin').click(function(){
			$('#locationFirstname').val('');
			$('#locationLastname').val('');
			$('#locationUsername').val('');
			$('#locationEmail').val('');
			$('#laEmail').val('');
			$('#locationtext').text('Create Location Admin User');
			$('#createLocationAdmin').text('Create Location Admin');
			//$('#createLocationAdmin').show();
			//$('#updateLocationAdmin').hide();
			$('#lfnameErr').empty();
			$('.userExisted').empty();
			$('#lfnameErr').empty();
			$('#llnameErr').empty();
			$('#lunameErr').empty();
			$('#lemailErr').empty();			
			$('#locationAdmin').click();
			
		});
		
	$('#agroup').click(function(){
		$('#addGroupName').val('');
		$('#addTemplateId').val('');
		$('#groupNameErr').empty();
		$('#groupExistErr').empty();
		$('#groupIdErr').empty();		
		$('#grouphref').click();
		
		$.ajax({
		      type: "POST",
		      url: "getTemplates",
		      async: true,
		      		      
		      success :function(result) {
		    	  
		    	  console.log(result);
		    	  var templates;
		    	  var templatesArray = [];
		    	  
		    	  for(var i=0;i<result.length;i++)
		    	  {
		    		  templates = "<option value="+result[i].objectId+"> "+result[i].name+" </option>"; 
		    		  templatesArray.push(templates);
		    	  }
		    	  
		    	  $('#addTemplateId').append(templatesArray);
		    	     	  
		     },
		     error : function(error) {
		    	console.log(error);
		     }
		  });	
		
	});
	
	$('#ahotel').click(function(){
		$('#checkBox').attr("checked",false);
		$('#hotelName').val('');
		$('#Address1').val('');
		$('#Address2').val('');
		$('#adminId').val('');
		$('#showTemplates').val('');
		$('#groupObjectId').val('');
		$('#Street').val('');
		$('#groupId').val('');
		
		
		$('#State').val('');
		$('.file-path').val('');
		$('#zipcode').val('');
		$('#country').val('');
		$('#hotelNameErr').empty();
		$('#hotelExistErr').empty();
		$('#hotelLocationAdminErr').empty();
		$('#hotelTemplateErr').empty();
		$('#hotelGroupErr').empty();
		$('#hotelAddressErr').empty();
		$('#hotelCityErr').empty();
		$('#hotelStateErr').empty();
		$('#hotelZipcodeErr').empty();
		$('#hotelCountryErr').empty();
		
		$('#hotelhref').click();
		
		$.ajax({
		      type: "POST",
		      url: "getLocationAdmins",
		      async: true,
		      		      
		      success :function(result) {
		    	  
		    	  console.log(result);
		    	  var admins;
		    	  var adminsArray = [];
		    	  
		    	  for(var i=0;i<result.length;i++)
		    	  {
		    		  admins = "<option value="+result[i].objectId+"> "+result[i].username+"-"+result[i].firstname+" "+result[i].lastname+" </option>"; 
		    		  adminsArray.push(admins);
		    	  }
		    	  
		    	  $('#adminId').append(adminsArray);
		    	     	  
		     },
		     error : function(error) {
		    	console.log(error);
		     }
		  });
		
		$.ajax({
		      type: "POST",
		      url: "getTemplates",
		      async: true,
		      		      
		      success :function(result) {
		    	  
		    	  console.log(result);
		    	  var templates;
		    	  var templatesArray = [];
		    	  
		    	  for(var i=0;i<result.length;i++)
		    	  {
		    		  templates = "<option value="+result[i].objectId+"> "+result[i].name+" </option>"; 
		    		  templatesArray.push(templates);
		    	  }
		    	  
		    	  $('#showTemplates').append(templatesArray);
		    	     	  
		     },
		     error : function(error) {
		    	console.log(error);
		     }
		  });
		
		$.ajax({
		      type: "POST",
		      url: "getGroups",
		      async: true,
		      		      
		      success :function(result) {
		    	  
		    	  console.log(result);
		    	  
		    	  var groups;
		    	  var groupsArray = [];
		    	  
		    	  for(var i=0;i<result.length;i++)
		    	  {
		    		  groups = "<option value="+result[i].objectId+"> "+result[i].name+" </option>"; 
		    		  groupsArray.push(groups);
		    	  }
		    	  
		    	  $('#groupObjectId').append(groupsArray);
		    	     	  
		     },
		     error : function(error) {
		    	console.log(error);
		     }
		  });
		
	});
	
	$('#ctemplate').click(function(){
		$('#templateName').val('');
		$('#templateId').val('');
		$('#templateNameErr').empty();
		$('#templateExistErr').empty();
		$('#templateIdErr').empty();
		
		$('#templatehref').click();
		
		$.ajax({
		      type: "POST",
		      url: "getTemplates",
		      async: true,
		      		      
		      success :function(result) {
		    	  
		    	  console.log(result);
		    	  var templates;
		    	  var templatesArray = [];
		    	  
		    	  for(var i=0;i<result.length;i++)
		    	  {
		    		  templates = "<option value="+result[i].objectId+"> "+result[i].name+" </option>"; 
		    		  templatesArray.push(templates);
		    	  }
		    	  
		    	  $('#templateId').append(templatesArray);
		    	     	  
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
					    		  $('.tspin').hide();
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
				 $("#groupExistErr").empty();
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
				    		  $("#groupExistErr").empty();				    		  
				    		  document.addGroup.submit();
				    		  $('.gspin').hide();
				    		  groupResult = 0;  
				          }
				    	 
				     },
				     error : function(error) {
				    	 console.log(error);
				    	
				     }
				  });
				
				
			}
		}
		
		
		
		function hotelSubmitform()
		{
			var hotelResult = 0;
			var hName = $('#hotelName').val();
			$('#addNewHotel').attr('disabled','disabled');
			var hAddress1 = $('#Address1').val();
			var locId = $('#adminId').val();
			var tempId = $('#showTemplates').val();
			var groupId = $('#groupObjectId').val();			
			var hCity = $('#Street').val();
			var hState = $('#State').val();
			var hZipcode = $('#zipcode').val();
			var hCountry = $('#country').val();
			
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
			
			if(hAddress1 == "" || hAddress1 == null)
			{
				$('#hotelAddressErr').text("Address is required");
				hotelResult++;
			}
			else
			{
				$('#hotelAddressErr').empty();				
				
			}
			
			if(locId == "" || locId == null)
			{
				$('#hotelLocationAdminErr').text("Please select Location Admin from the list");
				hotelResult++;
			}
			else
			{
				$('#hotelLocationAdminErr').empty();				
				
			}
			
			
			
					
			if(hCity == "" || hCity == null)
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
			}
			
			
			
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
			var sEmail = $('#saEmail').val();
			var fname = $('#superFirstname').val();
			var lname = $('#superLastname').val();
			var uname = $('#superUsername').val();
			var email = $('#superEmail').val();
			
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
		        }
		        else {
		        	$('#sunameErr').empty();
		        }
			}
			
			var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
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
			
			if(result == 0)
			{
				var data = {
						
						"firstname":fname,
						"lastname":lname,
						"username":uname,
						"email":email,
						"sEmail":sEmail,
						"user": $('#user').val(),
						"userName": $('#userName').val()
						
						
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
						    	$('#userType').text("Super Admin");
						    	$('#superFirstname').val('');
						    	$('#superLastname').val('');
						    	$('#superUsername').val('');
						    	$('#superEmail').val('');
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
			var cEmail = $('#caEmail').val();
			
			
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
		        }
		        else {
		        	$('#cunameErr').empty();
		        }
			}
			
			var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
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
			
			if(result == 0)
			{
				var data = {
						
						"firstname":fname,
						"lastname":lname,
						"username":uname,
						"email":email,
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
			var lEmail = $('#laEmail').val();
			
			$("#locationUsername").on("keydown", function (e) {
			    return e.which !== 32;
			});
			
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
		        }
		        else {
		        	$('#lunameErr').empty();
		        }
			}
			
			var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
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
			
			
			
			if(result == 0)
			{
				var data = {
						
						"firstname":fname,
						"lastname":lname,
						"username":uname,
						"email":email,
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
							  $('#adminId').html(a);
					    	$('#locationFirstname').val('');
					    	$('#locationLastname').val('');
					    	$('#locationUsername').val('');
					    	$('#locationEmail').val('');
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
				     }
				  });
			}
			
			
			
		});
			function Check() {
				$('#hotelTemplateErr').empty();	
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
				jQuery(window).bind(
			     	"beforeunload",
			    	$('.lean-overlay').css('dispaly','none')   
			 )
		</script>
		
		<script type="text/javascript">
		
		
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
					    			  $('#superEmail').val(result[i].email);
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
					    			  $('#superEmail').val(result[i].email);
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
					    			  $('#csEmail').val(result[i].email);
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
					    			  $('#locationEmail').val(result[i].email);
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
					$('#modal4').hide();
	    			$('.lean-overlay').css({display:'none'});
					$('#deleteAdmin').click();
					$('#deleteUserId').val(objId);
					
				}
				
				$('#deleteAdminDetails').click(function(){
					
					var userId = $('#deleteUserId').val();
					var searchElement = {
			    			"searchId" : userId			    			
			    	};
					$(".deletebody").append("<div style='margin:0 0 0 30%' class='preloader-wrapper small active'><div class='spinner-layer spinner-green-only'><div class='circle-clipper left'><div class='circle></div></div><div class='gap-patch'><div class='circle'></div></div><div class='circle-clipper right'><div class='circle'></div></div></div></div>");
					$.ajax({
					      type: "POST",
					      url: "deleteUser",
					      async: true,
					      data : searchElement,
					      
					      success :function(result) {
					    	  
					    	  $('#modal5').hide();
				    		  $('.lean-overlay').css({display:'none'});
					    	     	  
					     },
					     error : function(error) {
					    	console.log(error);
					     }
					  });
					
					
				});
		
		
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
							    	  $('.mbody').hide();
						    	  }    	  
						     },
						     error : function(error) {
						    	console.log(error);
						     }
						  });
				   
				    
				});
		
		</script>
		
		
		<script>
			$('#search').keyup(function(e){
				
				if(e.keyCode == 13)
			    {	    	
			    	var searchElement = {
			    			"searchId" : $('#search').val(),
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
					    		  $('#noResults').text('Search results not found');
					    		  $('.mbody').hide();
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
						    	  $(".searchResults").append(tableDetails);
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
						    	  var tableDetails = "<tbody><tr>"+
										"<td style='padding: 6px 0px 0px 30px;''><b style='color:#337ab7;font-size:18px'>Template Name</b></td>"+
										"<td style='padding:10px 0'><b style='color:#337ab7;font-size:18px'>Template Id</b></td>"+
									"</tr>";
						    	  for(var i=0;i<result.length;i++)
						    	  {
						    		  var table = "<tr>"+
						    		  "<td style='padding: 6px 0px 0px 30px;''> <a style='color:#337ab7' href='viewTemplates?user=${user}&userName=${userName}&tempId="+result[i].templateId+"'>"+
								   	      ""+result[i].templateName+"</a>"+
								   	  "</td>"+
								   	  "<td style='padding:10px 0'> <a  href='viewTemplates?user=${user}&userName=${userName}&tempId="+result[i].templateIId+"' style='color:#337ab7'>"+
								   	     ""+result[i].templateId+"</a>"+
								   	  "</td>"+
											
										"</tr><tbody>";
						    		  tableDetails = tableDetails+table;
						    		  
						    	  }
						    	  console.log(tableDetails);
						    	  $("#templateSearchResults").append(tableDetails);
						    	  $('.templateSpin').hide();
					    	  }
					    	 
					    	  
					     },
					     error : function(error) {
					    	console.log(error);
					     }
					  });
			    }
			    
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
						    	  var tableDetails = "<tbody><tr>"+
										"<td style='padding: 6px 0px 0px 30px;''><b style='color:#337ab7;font-size:18px'>Group Name</b></td>"+
										"<td style='padding:10px 0'><b style='color:#337ab7;font-size:18px'>Group Id</b></td>"+
									"</tr>";
						    	  for(var i=0;i<result.length;i++)
						    	  {
						    		  var table = "<tr>"+
						    		  "<td style='padding: 6px 0px 0px 30px;''> <a style='color:#337ab7' href='viewGroups?user=${user}&userName=${userName}&tempId="+result[i].templateId+"'>"+
								   	      ""+result[i].templateName+"</a>"+
								   	  "</td>"+
								   	  "<td style='padding:10px 0'> <a  href='viewGroups?user=${user}&userName=${userName}&tempId="+result[i].templateIId+"' style='color:#337ab7'>"+
								   	     ""+result[i].templateId+"</a>"+
								   	  "</td>"+
											
										"</tr><tbody>";
						    		  tableDetails = tableDetails+table;
						    		  
						    	  }
						    	  console.log(tableDetails);
						    	  $("#groupSearchResults").append(tableDetails);
						    	  $('.groupSpin').hide();
					    	  }
					    	 
					    	  
					     },
					     error : function(error) {
					    	console.log(error);
					     }
					  });
			    }
			    
			});
			
			
			
			
			
			
			 /* $('#quantity0000').keyup(function()
			    		{
			    	
			    	
			    	var v1 = $('#quantity0000').val();
			    	var v2 = $('#quantity0001').val();
			    	var v3 = $('#quantity0002').val();
			    	var v4 = $('#quantity0003').val();
			    	var v5 = $('#quantity0004').val();
			    	var v6 = $('#quantity0005').val();
			    	var v7 = $('#quantity0006').val();
			    	var v8 = $('#quantity0007').val();
			    	var v9 = $('#quantity0008').val();
			    	
			    	
			    	
			    	if(v1 == v2 || v1 === v3 || v1 == v4 || v1 == v5 || v1 == v6 || v1 == v7 || v1 == v8 || v1 == v9)
			    		{
			    		
			    		$('#quantity0000').val('');
			    		 $('#dvPa1').text('number exist');
			    		}
			    	else{
			    		
			    		$('#dvPa1').empty();
			    	}
			    		   
			    }) 
			    
			
		
			    $('#quantity0001').keyup(function()
			    		{
			    	
			    	
			    	var v1 = $('#quantity0000').val();
			    	var v2 = $('#quantity0001').val();
			    	var v3 = $('#quantity0002').val();
			    	var v4 = $('#quantity0003').val();
			    	var v5 = $('#quantity0004').val();
			    	var v6 = $('#quantity0005').val();
			    	var v7 = $('#quantity0006').val();
			    	var v8 = $('#quantity0007').val();
			    	var v9 = $('#quantity0008').val();
			    	
			    	
			    	
			    	if(v2 == v1 || v2 === v3 || v2 == v4 || v2 == v5 || v2 == v6 || v2 == v7 || v2 == v8 || v2 == v9)
			    		{
			    		
			    		$('#quantity0001').val('');
			    		 $('#dvPa2').text('number exist');
			    		}
			    	else{
			    		
			    		$('#dvPa2').empty();
			    	}
			    		   
			    }) 
			    
			    
			     $('#quantity0002').keyup(function()
			    		{
			    	
			    	
			    	var v1 = $('#quantity0000').val();
			    	var v2 = $('#quantity0001').val();
			    	var v3 = $('#quantity0002').val();
			    	var v4 = $('#quantity0003').val();
			    	var v5 = $('#quantity0004').val();
			    	var v6 = $('#quantity0005').val();
			    	var v7 = $('#quantity0006').val();
			    	var v8 = $('#quantity0007').val();
			    	var v9 = $('#quantity0008').val();
			    	
			    	
			    	
			    	if(v3 == v1 || v3 === v2 || v3 == v4 || v3 == v5 || v3 == v6 || v3 == v7 || v3 == v8 || v3 == v9)
			    		{
			    		
			    		$('#quantity0002').val('');
			    		 $('#dvPa3').text('number exist');
			    		}
			    	else{
			    		
			    		$('#dvPa3').empty();
			    	}
			    		   
			    }) 
			    
			    
			    $('#quantity0003').keyup(function()
			    		{
			    	
			    	
			    	var v1 = $('#quantity0000').val();
			    	var v2 = $('#quantity0001').val();
			    	var v3 = $('#quantity0002').val();
			    	var v4 = $('#quantity0003').val();
			    	var v5 = $('#quantity0004').val();
			    	var v6 = $('#quantity0005').val();
			    	var v7 = $('#quantity0006').val();
			    	var v8 = $('#quantity0007').val();
			    	var v9 = $('#quantity0008').val();
			    	
			    	
			    	
			    	if(v4 == v1 || v4 === v2 || v4 == v3 || v4 == v5 || v4 == v6 || v4 == v7 || v4 == v8 || v4 == v9)
			    		{
			    		
			    		$('#quantity0003').val('');
			    		 $('#dvPa4').text('number exist');
			    		}
			    	else{
			    		
			    		$('#dvPa4').empty();
			    	}
			    		   
			    }) 
			    
			    
			    $('#quantity0004').keyup(function()
			    		{
			    	
			    	
			    	var v1 = $('#quantity0000').val();
			    	var v2 = $('#quantity0001').val();
			    	var v3 = $('#quantity0002').val();
			    	var v4 = $('#quantity0003').val();
			    	var v5 = $('#quantity0004').val();
			    	var v6 = $('#quantity0005').val();
			    	var v7 = $('#quantity0006').val();
			    	var v8 = $('#quantity0007').val();
			    	var v9 = $('#quantity0008').val();
			    	
			    	
			    	
			    	if(v5 == v1 || v5 === v2 || v5 == v3 || v5 == v4 || v5 == v6 || v5 == v7 || v5 == v8 || v5 == v9)
			    		{
			    		
			    		$('#quantity0004').val('');
			    		 $('#dvPa5').text('number exist');
			    		}
			    	else{
			    		
			    		$('#dvPa5').empty();
			    	}
			    		   
			    }) 
			    
			    $('#quantity0005').keyup(function()
			    		{
			    	
			    	
			    	var v1 = $('#quantity0000').val();
			    	var v2 = $('#quantity0001').val();
			    	var v3 = $('#quantity0002').val();
			    	var v4 = $('#quantity0003').val();
			    	var v5 = $('#quantity0004').val();
			    	var v6 = $('#quantity0005').val();
			    	var v7 = $('#quantity0006').val();
			    	var v8 = $('#quantity0007').val();
			    	var v9 = $('#quantity0008').val();
			    	
			    	
			    	
			    	if(v6 == v1 || v6 === v2 || v6 == v3 || v6 == v4 || v6 == v5 || v6 == v7 || v6 == v8 || v6 == v9)
			    		{
			    		
			    		$('#quantity0005').val('');
			    		 $('#dvPa6').text('number exist');
			    		}
			    	else{
			    		
			    		$('#dvPa6').empty();
			    	}
			    		   
			    }) 
			    
			    
			     $('#quantity0006').keyup(function()
			    		{
			    	
			    	
			    	var v1 = $('#quantity0000').val();
			    	var v2 = $('#quantity0001').val();
			    	var v3 = $('#quantity0002').val();
			    	var v4 = $('#quantity0003').val();
			    	var v5 = $('#quantity0004').val();
			    	var v6 = $('#quantity0005').val();
			    	var v7 = $('#quantity0006').val();
			    	var v8 = $('#quantity0007').val();
			    	var v9 = $('#quantity0008').val();
			    	
			    	
			    	
			    	if(v7 == v1 || v7 === v2 || v7 == v3 || v7 == v4 || v7 == v5 || v7 == v6 || v7 == v8 || v7 == v9)
			    		{
			    		
			    		$('#quantity0006').val('');
			    		 $('#dvPa7').text('number exist');
			    		}
			    	else{
			    		
			    		$('#dvPa7').empty();
			    	}
			    		   
			    }) 
			    
			     $('#quantity0007').keyup(function()
			    		{
			    	
			    	
			    	var v1 = $('#quantity0000').val();
			    	var v2 = $('#quantity0001').val();
			    	var v3 = $('#quantity0002').val();
			    	var v4 = $('#quantity0003').val();
			    	var v5 = $('#quantity0004').val();
			    	var v6 = $('#quantity0005').val();
			    	var v7 = $('#quantity0006').val();
			    	var v8 = $('#quantity0007').val();
			    	var v9 = $('#quantity0008').val();
			    	
			    	
			    	
			    	if(v8 == v1 || v8 === v2 || v8 == v3 || v8 == v4 || v8 == v5 || v8 == v6 || v8 == v7 || v8 == v9)
			    		{
			    		
			    		$('#quantity0007').val('');
			    		 $('#dvPa8').text('number exist');
			    		}
			    	else{
			    		
			    		$('#dvPa8').empty();
			    	}
			    		   
			    }) 
			    
			    
			     $('#quantity0008').keyup(function()
			    		{
			    	
			    	
			    	var v1 = $('#quantity0000').val();
			    	var v2 = $('#quantity0001').val();
			    	var v3 = $('#quantity0002').val();
			    	var v4 = $('#quantity0003').val();
			    	var v5 = $('#quantity0004').val();
			    	var v6 = $('#quantity0005').val();
			    	var v7 = $('#quantity0006').val();
			    	var v8 = $('#quantity0007').val();
			    	var v9 = $('#quantity0008').val();
			    	
			    	
			    	
			    	if(v9 == v1 || v9 === v2 || v9 == v3 || v9 == v4 || v9 == v5 || v9 == v6 || v9 == v7 || v9 == v8)
			    		{
			    		
			    		$('#quantity0008').val('');
			    		 $('#dvPa9').text('number exist');
			    		}
			    	else{
			    		
			    		$('#dvPa9').empty();
			    	}
			    		   
			    }) 
			    
			    
			    
			    
			    
			    
			    
			    $('#quantity1').keyup(function()
			    		{
			    	
			    	
			    	var v1 = $('#quantity1').val();
			    	var v2 = $('#quantity2').val();
			    	var v3 = $('#quantity3').val();
			    	var v4 = $('#quantity4').val();
			    	var v5 = $('#quantity5').val();
			    	var v6 = $('#quantity6').val();
			    	var v7 = $('#quantity7').val();
			    	var v8 = $('#quantity8').val();
			    	var v9 = $('#quantity9').val();
			    	
			    	
			    	
			    	if(v1 == v2 || v1 === v3 || v1 == v4 || v1 == v5 || v1 == v6 || v1 == v7 || v1 == v8 || v1 == v9)
			    		{
			    		
			    		$('#quantity1').val('');
			    		 $('#dvPa11').text('number exist');
			    		}
			    	else{
			    		
			    		$('#dvPa11').empty();
			    	}
			    		   
			    }) 
			    
			
		
			    $('#quantity2').keyup(function()
			    		{
			    	
			    	
			    	var v1 = $('#quantity1').val();
			    	var v2 = $('#quantity2').val();
			    	var v3 = $('#quantity3').val();
			    	var v4 = $('#quantity4').val();
			    	var v5 = $('#quantity5').val();
			    	var v6 = $('#quantity6').val();
			    	var v7 = $('#quantity7').val();
			    	var v8 = $('#quantity8').val();
			    	var v9 = $('#quantity9').val();
			    	
			    	
			    	
			    	if(v2 == v1 || v2 === v3 || v2 == v4 || v2 == v5 || v2 == v6 || v2 == v7 || v2 == v8 || v2 == v9)
			    		{
			    		
			    		$('#quaquantity2').val('');
			    		 $('#dvPa12').text('number exist');
			    		}
			    	else{
			    		
			    		$('#dvPa12').empty();
			    	}
			    		   
			    }) 
			    
			    
			     $('#quantity3').keyup(function()
			    		{
			    	
			    	
			    	var v1 = $('#quantity0000').val();
			    	var v2 = $('#quantity2').val();
			    	var v3 = $('#quantity3').val();
			    	var v4 = $('#quantity4').val();
			    	var v5 = $('#quantity5').val();
			    	var v6 = $('#quantity6').val();
			    	var v7 = $('#quantity7').val();
			    	var v8 = $('#quantity8').val();
			    	var v9 = $('#quantity9').val();
			    	
			    	
			    	
			    	if(v3 == v1 || v3 === v2 || v3 == v4 || v3 == v5 || v3 == v6 || v3 == v7 || v3 == v8 || v3 == v9)
			    		{
			    		
			    		$('#quantity3').val('');
			    		 $('#dvPa13').text('number exist');
			    		}
			    	else{
			    		
			    		$('#dvPa13').empty();
			    	}
			    		   
			    }) 
			    
			    
			    $('#quantity4').keyup(function()
			    		{
			    	
			    	
			    	var v1 = $('#quantity1').val();
			    	var v2 = $('#quantity2').val();
			    	var v3 = $('#quantity3').val();
			    	var v4 = $('#quantity4').val();
			    	var v5 = $('#quantity5').val();
			    	var v6 = $('#quantity6').val();
			    	var v7 = $('#quantity7').val();
			    	var v8 = $('#quantity8').val();
			    	var v9 = $('#quantity9').val();
			    	
			    	
			    	
			    	if(v4 == v1 || v4 === v2 || v4 == v3 || v4 == v5 || v4 == v6 || v4 == v7 || v4 == v8 || v4 == v9)
			    		{
			    		
			    		$('#quantit4').val('');
			    		 $('#dvPa14').text('number exist');
			    		}
			    	else{
			    		
			    		$('#dvPa14').empty();
			    	}
			    		   
			    }) 
			    
			    
			    $('#quantity5').keyup(function()
			    		{
			    	
			    	
			    	var v1 = $('#quantity1').val();
			    	var v2 = $('#quantity2').val();
			    	var v3 = $('#quantity3').val();
			    	var v4 = $('#quantity4').val();
			    	var v5 = $('#quantity5').val();
			    	var v6 = $('#quantity6').val();
			    	var v7 = $('#quantity7').val();
			    	var v8 = $('#quantity8').val();
			    	var v9 = $('#quantity9').val();
			    	
			    	
			    	
			    	if(v5 == v1 || v5 === v2 || v5 == v3 || v5 == v4 || v5 == v6 || v5 == v7 || v5 == v8 || v5 == v9)
			    		{
			    		
			    		$('#quantity5').val('');
			    		 $('#dvPa15').text('number exist');
			    		}
			    	else{
			    		
			    		$('#dvPa15').empty();
			    	}
			    		   
			    }) 
			    
			    $('#quantity6').keyup(function()
			    		{
			    	
			    	
			    	var v1 = $('#quantity1').val();
			    	var v2 = $('#quantity2').val();
			    	var v3 = $('#quantity3').val();
			    	var v4 = $('#quantity4').val();
			    	var v5 = $('#quantity5').val();
			    	var v6 = $('#quantity6').val();
			    	var v7 = $('#quantity7').val();
			    	var v8 = $('#quantity8').val();
			    	var v9 = $('#quantity9').val();
			    	
			    	
			    	
			    	if(v6 == v1 || v6 === v2 || v6 == v3 || v6 == v4 || v6 == v5 || v6 == v7 || v6 == v8 || v6 == v9)
			    		{
			    		
			    		$('#quantity6').val('');
			    		 $('#dvPa16').text('number exist');
			    		}
			    	else{
			    		
			    		$('#dvPa16').empty();
			    	}
			    		   
			    }) 
			    
			    
			     $('#quantity7').keyup(function()
			    		{
			    	
			    	
			    	var v1 = $('#quantity1').val();
			    	var v2 = $('#quantity2').val();
			    	var v3 = $('#quantity3').val();
			    	var v4 = $('#quantity4').val();
			    	var v5 = $('#quantity5').val();
			    	var v6 = $('#quantity6').val();
			    	var v7 = $('#quantity7').val();
			    	var v8 = $('#quantity8').val();
			    	var v9 = $('#quantity9').val();
			    	
			    	
			    	
			    	if(v7 == v1 || v7 === v2 || v7 == v3 || v7 == v4 || v7 == v5 || v7 == v6 || v7 == v8 || v7 == v9)
			    		{
			    		
			    		$('#quantity7').val('');
			    		 $('#dvPa17').text('number exist');
			    		}
			    	else{
			    		
			    		$('#dvPa17').empty();
			    	}
			    		   
			    }) 
			    
			     $('#quantity8').keyup(function()
			    		{
			    	
			    	
			    	var v1 = $('#quantity1').val();
			    	var v2 = $('#quantity2').val();
			    	var v3 = $('#quantity3').val();
			    	var v4 = $('#quantity4').val();
			    	var v5 = $('#quantity5').val();
			    	var v6 = $('#quantity6').val();
			    	var v7 = $('#quantity7').val();
			    	var v8 = $('#quantity8').val();
			    	var v9 = $('#quantity9').val();
			    	
			    	
			    	
			    	if(v8 == v1 || v8 === v2 || v8 == v3 || v8 == v4 || v8 == v5 || v8 == v6 || v8 == v7 || v8 == v9)
			    		{
			    		
			    		$('#quantity8').val('');
			    		 $('#dvPa18').text('number exist');
			    		}
			    	else{
			    		
			    		$('#dvPa18').empty();
			    	}
			    		   
			    }) 
			    
			    
			     $('#quantity9').keyup(function()
			    		{
			    	
			    	
			    	var v1 = $('#quantity1').val();
			    	var v2 = $('#quantity2').val();
			    	var v3 = $('#quantity3').val();
			    	var v4 = $('#quantity4').val();
			    	var v5 = $('#quantity5').val();
			    	var v6 = $('#quantity6').val();
			    	var v7 = $('#quantity7').val();
			    	var v8 = $('#quantity8').val();
			    	var v9 = $('#quantity9').val();
			    	
			    	
			    	
			    	if(v9 == v1 || v9 === v2 || v9 == v3 || v9 == v4 || v9 == v5 || v9 == v6 || v9 == v7 || v9 == v8)
			    		{
			    		
			    		$('#quantity9').val('');
			    		 $('#dvPa19').text('number exist');
			    		}
			    	else{
			    		
			    		$('#dvPa19').empty();
			    	}
			    		   
			    })  */
			   
			
				






			
			
			
			
			
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
						    	  var tableDetails = "<tbody><td style='padding: 6px 0px 0px 0px;text-align:left;''><b style='color:#337ab7;font-size:18px'>User Name</b></td>"+
									"<td style='padding:10px 0;text-align:left;'><b style='color:#337ab7;font-size:18px'>First Name</b></td>"+
									"<td style='padding:10px 0;text-align:left;'><b style='color:#337ab7;font-size:18px'>Last Name</b></td>"+
									"<td style='padding: 6px 0px 0px 0px;text-align:left;'><b style='color:#337ab7;font-size:18px'>Email</b></td>"+
									"<td style='padding:10px 0;text-align:left;'><b style='color:#337ab7;font-size:18px'>Role</b></td>"+
									"<td style='padding:10px 0;text-align:left;'><b style='color:#337ab7;font-size:18px'>Actions</b></td>"+
									"</tr>";
						    	  for(var i=0;i<result.length;i++)
						    	  {
						    		  var table = "<tr>"+
											"<td style='padding: 6px 0px 0px 0px;text-align:left;''> <a style='color:#337ab7' href='#'>"+											
											""+result[i].username+"</a>"+
											"</td>"+
											"<td style='padding:10px 0;text-align:left;'> <a  href='#' style='color:#337ab7'>"+										
											""+result[i].firstname+"</a>"+
											"</td>"+
											"<td style='padding:10px 0;text-align:left;'> <a  href='#' style='color:#337ab7'>"+											
											""+result[i].lastname+"</a>"+
											"</td>"+
											"<td style='padding: 6px 0px 0px 0px;text-align:left;''> <a style='color:#337ab7' href='#'>"+											
											""+result[i].email+"</a>"+
											"</td>"+
											"<td style='padding:10px 0;text-align:left;'> <a  href='#' style='color:#337ab7'>"+											
											""+result[i].user+"</a>"+
											"</td>"+
											"<td style='padding:10px 0;text-align:left'> <a  href='#' style='color:#337ab7'>"+
											"<span id='edit:"+result[i].email+"' onclick='editUser(this.id)'>Edit </span > &nbsp <span id='delete:"+result[i].objectId+"' onclick='deleteUser(this.id)'> Delete </span>"+
											"</a>"+
											"</td>"+								
										"</tr> <tbody>";
						    		  tableDetails = tableDetails+table;
						    		  
						    	  }
						    	  console.log(tableDetails);
						    	  $("#userSearchResults").append(tableDetails);
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
						    	  var tableDetails = "<tbody><td style='padding: 6px 0px 0px 0px;text-align:left;''><b style='color:#337ab7;font-size:18px'>User Name</b></td>"+
									"<td style='padding:10px 0;text-align:left;'><b style='color:#337ab7;font-size:18px'>First Name</b></td>"+
									"<td style='padding:10px 0;text-align:left;'><b style='color:#337ab7;font-size:18px'>Last Name</b></td>"+
									"<td style='padding: 6px 0px 0px 0px;text-align:left;'><b style='color:#337ab7;font-size:18px'>Email</b></td>"+
									"<td style='padding:10px 0;text-align:left;'><b style='color:#337ab7;font-size:18px'>Role</b></td>"+
									"<td style='padding:10px 0;text-align:left;'><b style='color:#337ab7;font-size:18px'>Actions</b></td>"+
									"</tr>";
						    	  for(var i=0;i<result.length;i++)
						    	  {
						    		  var table = "<tr>"+
											"<td style='padding: 6px 0px 0px 0px;text-align:left;''> <a style='color:#337ab7' href='#'>"+											
											""+result[i].username+"</a>"+
											"</td>"+
											"<td style='padding:10px 0;text-align:left;'> <a  href='#' style='color:#337ab7'>"+										
											""+result[i].firstname+"</a>"+
											"</td>"+
											"<td style='padding:10px 0;text-align:left;'> <a  href='#' style='color:#337ab7'>"+											
											""+result[i].lastname+"</a>"+
											"</td>"+
											"<td style='padding: 6px 0px 0px 0px;text-align:left;''> <a style='color:#337ab7' href='#'>"+											
											""+result[i].email+"</a>"+
											"</td>"+
											"<td style='padding:10px 0;text-align:left;'> <a  href='#' style='color:#337ab7'>"+											
											""+result[i].user+"</a>"+
											"<td style='padding:10px 0;text-align:left'> <a  href='#' style='color:#337ab7'>"+
											"<span id='edit:"+result[i].email+"' onclick='editUser(this.id)'>Edit </span > &nbsp <span id='delete:"+result[i].objectId+"' onclick='deleteUser(this.id)'> Delete </span>"+
											"</a>"+
											"</td>"+
											
										"</tr> <tbody>";
						    		  tableDetails = tableDetails+table;
						    		  
						    	  }
						    	  console.log(tableDetails);
						    	  $("#userSearchResults").append(tableDetails);
						    	  $('.userSpin').hide();
					    	  }
					    	 
					    	  
					     },
					     error : function(error) {
					    	console.log(error);
					     }
					  });
			    
			    
			});
			
			
			
			$('.manageUsers').click(function(e){
				
				$('#userSearch').val('');
				
				var searchElement = {
			    			"searchId" : ""			    			
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
						    	  var tableDetails = "<tbody><td style='padding: 6px 0px 0px 30px;''><b style='color:#337ab7;font-size:18px'>User Name</b></td>"+
									"<td style='padding:10px 0'><b style='color:#337ab7;font-size:18px'>First Name</b></td>"+
									"<td style='padding:10px 0'><b style='color:#337ab7;font-size:18px'>Last Name</b></td>"+
									"<td style='padding: 6px 0px 0px 30px;'><b style='color:#337ab7;font-size:18px'>Email</b></td>"+
									"<td style='padding:10px 0'><b style='color:#337ab7;font-size:18px'>Role</b></td>"+
									"<td style='padding:10px 0'><b style='color:#337ab7;font-size:18px'>Actions</b></td>"+
									"</tr>";
						    	  for(var i=0;i<result.length;i++)
						    	  {
						    		  var table = "<tr>"+
											"<td style='padding: 6px 0px 0px 30px;''> <a style='color:#337ab7' href='dfgdfg'>"+											
											""+result[i].username+"</a>"+
											"</td>"+
											"<td style='padding:10px 0'> <a  href='dfgdfg' style='color:#337ab7'>"+										
											""+result[i].firstname+"</a>"+
											"</td>"+
											"<td style='padding:10px 0'> <a  href='dfgdfg' style='color:#337ab7'>"+											
											""+result[i].lastname+"</a>"+
											"</td>"+
											"<td style='padding: 6px 0px 0px 30px;''> <a style='color:#337ab7' href='dfgdfg'>"+											
											""+result[i].email+"</a>"+
											"</td>"+
											"<td style='padding:10px 0'> <a  href='dfgdfg' style='color:#337ab7'>"+											
											""+result[i].user+"</a>"+
											"</td>"+
											"<td style='padding:10px 0'> <a  href='dfgdfg' style='color:#337ab7'>"+
											"Edit &nbsp Delete	</a>"+
											"</td>"+								
										"</tr> <tbody>";
						    		  tableDetails = tableDetails+table;
						    		  
						    	  }
						    	  console.log(tableDetails);
						    	  $("#userSearchResults").append(tableDetails);
						    	  $('.userSpin').hide();
					    	  }
					    	 
					    	  
					     },
					     error : function(error) {
					    	console.log(error);
					     }
					  });
			    
			    
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
						    	  var tableDetails = "<tbody><tr>"+
										"<td style='padding: 6px 0px 0px 30px;''><b style='color:#337ab7;font-size:18px'>Template Name</b></td>"+
										"<td style='padding:10px 0'><b style='color:#337ab7;font-size:18px'>Template Id</b></td>"+
									"</tr>";
						    	  for(var i=0;i<result.length;i++)
						    	  {
						    		  var table = "<tr>"+
						    		  "<td style='padding: 6px 0px 0px 30px;''> <a style='color:#337ab7' href='viewTemplates?user=${user}&userName=${userName}&tempId="+result[i].templateId+"'>"+
								   	      ""+result[i].templateName+"</a>"+
								   	  "</td>"+
								   	  "<td style='padding:10px 0'> <a  href='viewTemplates?user=${user}&userName=${userName}&tempId="+result[i].templateIId+"' style='color:#337ab7'>"+
								   	     ""+result[i].templateId+"</a>"+
								   	  "</td>"+
											
										"</tr><tbody>";
						    		  tableDetails = tableDetails+table;
						    		  
						    	  }
						    	  console.log(tableDetails);
						    	  $("#templateSearchResults").append(tableDetails);
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
						    	  var tableDetails = "<tbody><tr>"+
										"<td style='padding: 6px 0px 0px 30px;''><b style='color:#337ab7;font-size:18px'>Group Name</b></td>"+
										"<td style='padding:10px 0'><b style='color:#337ab7;font-size:18px'>Group Id</b></td>"+
									"</tr>";
						    	  for(var i=0;i<result.length;i++)
						    	  {
						    		  var table = "<tr>"+
						    		  "<td style='padding: 6px 0px 0px 30px;''> <a style='color:#337ab7' href='viewGroups?user=${user}&userName=${userName}&tempId="+result[i].templateId+"'>"+
								   	      ""+result[i].templateName+"</a>"+
								   	  "</td>"+
								   	  "<td style='padding:10px 0'> <a  href='viewGroups?user=${user}&userName=${userName}&tempId="+result[i].templateIId+"' style='color:#337ab7'>"+
								   	     ""+result[i].templateId+"</a>"+
								   	  "</td>"+
											
										"</tr><tbody>";
						    		  tableDetails = tableDetails+table;
						    		  
						    	  }
						    	  console.log(tableDetails);
						    	  $("#groupSearchResults").append(tableDetails);
						    	  $('.groupSpin').hide();
					    	  }
					    	 
					    	  
					     },
					     error : function(error) {
					    	console.log(error);
					     }
					  });
			    
			    
			});
			
		$('.clearData').click(function(){
			
			$('#dirTitle').val('');
			
			$('#dirCaption').val('');
			
			$('#dirTimings').val('');
			
			$('#dirDescption').val('');
			$('#imgUrl').val('');
			$('#mce_0_ifr').contents().find("body").empty();
			
			
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
		</script>
		
		<!-- <script>
			function isNumber(evt) {
			    evt = (evt) ? evt : window.event;
			    var charCode = (evt.which) ? evt.which : evt.keyCode;
			    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
			        return false;
			    }
			    return true;
			}
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
		</script>		 -->
		
		<script>
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
		
		<script>
		function adminApp1(id){
			
			$('#modal29').show();
			
			for(var i=0;i<9;i++)
			{
				$('#dvPassport500').hide();
				$('#dvPassport50').hide();
				$('#dvPassport7').hide();
				$('#dvPassport9').hide();
				$('#dvPassport11').hide();
				$('#dvPassport13').hide();
				$('#dvPassport17').hide();
				$('#dvPassport').hide();
				$('#dvPassport15').hide();
				
				
				$('#dvPassport000'+i).hide();				
				document.getElementById("quantity000"+i).value = "";
				document.getElementById("itemAction000"+i).value = "";
				document.getElementById("test000"+i).checked = false;
				document.getElementById("icon000"+i).checked = false;
				i++;
				document.getElementById("quantity"+i).value = "";
				i--;
			}
			
			
		
			$.ajax({
			      type: "POST",
			      url: "findHotelMenuList",
			      async: true,
			      data : {id:id},
			     
			      success :function(results) {
			    	  console.log(results);
			    	  if(results=="")
			    	  {
			    		  $('#hotelMenuId').val('');
			    	  }
			    	  else
			    	  {
			    		  $('#hotelMenuId').val(id);
			    		  for(var i=0;i<results.length;i++)
			    		  {
			    			  if(results[i].menuDesc == "House Phone")
			    			  {
			    				  $('#quantity0000').val(results[i].menuQuan);
			    				  $('#quantity0000').show();
			    				  $('#itemAction0000').val(results[i].itemAction);
			    				  if(results[i].itemQuan == 0)
			    				  {
			    					  results[i].itemQuan = ''; 
			    					  $('#icon0000').prop('checked', false);
			    					  $('#dvPassport500').hide();
			    				  }
			    				  else
			    				  {
			    					  $('#icon0000').prop('checked', true);
			    					  $('#dvPassport500').show();
			    				  }
			    					  
			    				  $('#quantity1').val(results[i].itemQuan);
			    				  $('#test0000').prop('checked', true);
			    				  
			    				  clicking0000();
			    				  clicking00();
			    			  }
			    			  
			    			  if(results[i].menuDesc == "Service/Front Desk")
			    			  {
			    				  $('#quantity0001').val(results[i].menuQuan);
			    				  $('#itemAction0001').val(results[i].itemAction);
			    				  $('#quantity0001').show();
			    				  if(results[i].itemQuan == 0)
			    				  {
			    					  results[i].itemQuan = ''; 
			    					  $('#icon0001').prop('checked', false);
			    					  $('#dvPassport50').hide();
			    				  }
			    				  else
			    				  {
			    					  $('#icon0001').prop('checked', true);
			    					  $('#dvPassport50').show();
			    				  }
			    				  $('#quantity2').val(results[i].itemQuan);
			    				  $('#test0001').prop('checked', true);
			    				  
			    				  clicking0001();
			    				  clicking();
			    			  }
			    			  
			    			  if(results[i].menuDesc == "Bellman/Baggage")
			    			  {
			    				  $('#quantity0002').val(results[i].menuQuan);
			    				  $('#itemAction0002').val(results[i].itemAction);
			    				  $('#quantity0002').show();
			    				  if(results[i].itemQuan == 0)
			    				  {
			    					  results[i].itemQuan = ''; 
			    					  $('#icon0002').prop('checked', false);
			    					  $('#dvPassport7').hide();
			    				  }
			    				  else
			    				  {
			    					  $('#icon0002').prop('checked', true);
			    					  $('#dvPassport7').show();
			    				  }
			    				  $('#quantity3').val(results[i].itemQuan);
			    				  $('#test0002').prop('checked', true);
			    				  
			    				  clicking0002();
			    				  clicking1();
			    			  }
			    			  
			    			  if(results[i].menuDesc == "Maid Service")
			    			  {
			    				  $('#quantity0003').val(results[i].menuQuan);
			    				  $('#itemAction0003').val(results[i].itemAction);
			    				  $('#quantity0003').show();
			    				  if(results[i].itemQuan == 0)
			    				  {
			    					  results[i].itemQuan = ''; 
			    					  $('#icon0003').prop('checked', false);
			    					  $('#dvPassport9').hide();
			    				  }
			    				  else
			    				  {
			    					  $('#icon0003').prop('checked', true);
			    					  $('#dvPassport9').show();
			    				  }
			    				  $('#quantity4').val(results[i].itemQuan);
			    				  $('#test0003').prop('checked', true);
			    				  
			    				  clicking0003();
			    				  clicking2();
			    			  }
			    			  
			    			  if(results[i].menuDesc == "Emergency")
			    			  {
			    				  $('#quantity0004').val(results[i].menuQuan);
			    				  $('#itemAction0004').val(results[i].itemAction);
			    				  $('#quantity0004').show();
			    				  if(results[i].itemQuan == 0)
			    				  {
			    					  results[i].itemQuan = ''; 
			    					  $('#icon0004').prop('checked', false);
			    					  $('#dvPassport11').hide();
			    				  }
			    				  else
			    				  {
			    					  $('#icon0004').prop('checked', true);
			    					  $('#dvPassport11').show();
			    				  }
			    				  $('#quantity5').val(results[i].itemQuan);
			    				  $('#test0004').prop('checked', true);
			    				  
			    				  clicking0004();
			    				  clicking3();
			    			  }
			    			  
			    			  if(results[i].menuDesc == "Food and Beverage")
			    			  {
			    				  $('#quantity0005').val(results[i].menuQuan);
			    				  $('#itemAction0005').val(results[i].itemAction);
			    				  $('#quantity0005').show();
			    				  if(results[i].itemQuan == 0)
			    				  {
			    					  results[i].itemQuan = ''; 
			    					  $('#icon0005').prop('checked', false);
			    					  $('#dvPassport13').hide();
			    				  }
			    				  else
			    				  {
			    					  $('#icon0005').prop('checked', true);
			    					  $('#dvPassport13').show();
			    				  }
			    				  $('#quantity6').val(results[i].itemQuan);
			    				  $('#test0005').prop('checked', true);
			    				  
			    				  clicking0005();
			    				  clicking4();
			    			  }
			    			  
			    			  if(results[i].menuDesc == "Taxi")
			    			  {
			    				  $('#quantity0006').val(results[i].menuQuan);
			    				  $('#itemAction0006').val(results[i].itemAction);
			    				  $('#quantity0006').show();
			    				  if(results[i].itemQuan == 0)
			    				  {
			    					  results[i].itemQuan = ''; 
			    					  $('#icon0006').prop('checked', false);
			    					  $('#dvPassport15').hide();
			    				  }
			    				  else
			    				  {
			    					  $('#icon0006').prop('checked', true);
			    					  $('#dvPassport15').show();
			    				  }
			    				  $('#quantity7').val(results[i].itemQuan);
			    				  $('#test0006').prop('checked', true);
			    				  
			    				  clicking0006();
			    				  clicking5();
			    			  }
			    			  
			    			  if(results[i].menuDesc == "Local Attractions")
			    			  {
			    				  $('#quantity0007').val(results[i].menuQuan);
			    				  $('#itemAction0007').val(results[i].itemAction);
			    				  $('#quantity0007').show();
			    				  if(results[i].itemQuan == 0)
			    				  {
			    					  results[i].itemQuan = ''; 
			    					  $('#icon0007').prop('checked', false);
			    					  $('#dvPassport17').hide();
			    				  }
			    				  else
			    				  {
			    					  $('#icon0007').prop('checked', true);
			    					  $('#dvPassport17').show();
			    				  }
			    				  $('#quantity8').val(results[i].itemQuan);
			    				  $('#test0007').prop('checked', true);
			    				  
			    				  clicking0007();
			    				  clicking6();
			    			  }
			    			  
			    			  if(results[i].menuDesc == "Hotel Directory")
			    			  {
			    				  $('#quantity0008').val(results[i].menuQuan);
			    				  $('#itemAction0008').val(results[i].itemAction);
			    				  $('#quantity0008').show();
			    				  if(results[i].itemQuan == 0)
			    				  {
			    					  results[i].itemQuan = ''; 
			    					  $('#icon0008').prop('checked', false);
			    					  $('#dvPassport').hide();
			    				  }
			    				  else
			    				  {
			    					  $('#icon0008').prop('checked', true);
			    					  $('#dvPassport').show();
			    				  }
			    				  $('#quantity9').val(results[i].itemQuan);
			    				  $('#test0008').prop('checked', true);
			    				  
			    				  clicking0008();
			    				  clicking7();
			    			  }
			    			  
			    		  }
			    	  }
			    	 
			     },
			     error : function(error) {
			    	 console.log("error"+error);
			    	
			     }
			  });	
			
			
			
			
		}
		</script>
		<script >
		
		function admin_app(id){
			var hotelId = $('#hotelMenuId').val();
			 var json = [];
			 for(var i=0;i<9;i++)
			 {
				 var temp = {};
				 var testMenuCheck  = document.getElementById('test000'+i).checked;
				 if(testMenuCheck)
				 {
					 
					 var data = $('#menuDesc000'+i).text()+","+$('#quantity000'+i).val();
					 var action = $('#itemAction000'+i).val();
					 var testIconCheck = document.getElementById('icon000'+i).checked;
					 
					 if(testIconCheck)
					 {
						 i++;
						 var innerData = $('#quantity'+i).val();
						 i--;
					 }
					 else
					 {
						 i++;
						 var innerData = "";
						 i--;
					 }
					 temp["HotelId"] = id;
					 temp["MenuDesc"] = $('#menuDesc000'+i).text();
					 temp["MenuQuan"] = $('#quantity000'+i).val();
					 temp["ItemAction"] = $('#itemAction000'+i).val();
					 temp["ItemQuan"] = innerData;
					 json.push(temp);
					
				 }
				 
			 }	
			 
			 console.log(JSON.stringify(json));
			 
			// $(".menuBody").append("<div style='margin:' class='preloader-wrapper small active'><div class='spinner-layer spinner-green-only'><div class='circle-clipper left'><div class='circle></div></div><div class='gap-patch'><div class='circle'></div></div><div class='circle-clipper right'><div class='circle'></div></div></div></div>");
			 
			 $.ajax({
			      type: "POST",
			      url: "hotelMenuItems",			      
			      async: false,			      
			      contentType : 'application/json',
			      dataType : 'json',
			      data : JSON.stringify(json),
			      beforeSend: function(xhr) {  
                      xhr.setRequestHeader("Accept", "application/json");  
                      xhr.setRequestHeader("Content-Type", "application/json");  
                  },
			      success :function(result) {
			    	  console.log(result);
			    	  $('#modal29').hide();
			    	  $('.lean-overlay').css({display:'none'});
			    	  
			    	 
			    	  
			    	     	  
			     },
			     error : function(error) {
			    	console.log(error);
			    	$('#modal29').hide();
			    	$('.lean-overlay').css({display:'none'});
			     }
			  }); 
			 
			 
			 
		}
		
		
		function clicking00(){
			var clicking00 = document.getElementById("icon0000").checked;
			if(clicking00)
			{
				$("#dvPassport500").show();
			}
			else
			{
				$("#dvPassport500").hide();
				$().val('');
			}
			
		}
		
		function clicking(){
			
			var click0 = document.getElementById("icon0001").checked;
			if(click0)
			{
				$("#dvPassport50").show();
			}
			else
			{
				$("#dvPassport50").hide();
			}
			
			
		}		
		
		function clicking1(){
			var click1 = document.getElementById("icon0002").checked;
			if(click1)
			{
				$("#dvPassport7").show();
			}
			else
			{
				$("#dvPassport7").hide();
			}
			
		}		
		
		function clicking2(){
			var click2 = document.getElementById("icon0003").checked;
			if(click2)
			{
				$("#dvPassport9").show();
			}
			else
			{
				$("#dvPassport9").hide();
			}
			
		}		
		
		function clicking3(){
			var click3 = document.getElementById("icon0004").checked;
			if(click3)
			{
				$("#dvPassport11").show();
			}
			else
			{
				$("#dvPassport11").hide();
			}
			
		}
				
		function clicking4(){
			
			var click4 = document.getElementById("icon0005").checked;
			if(click4)
			{
				$("#dvPassport13").show();
			}
			else
			{
				$("#dvPassport13").hide();
			}
			
			
		}		
		
		function clicking5(){
			
			var click5 = document.getElementById("icon0006").checked;
			if(click5)
			{
				$("#dvPassport15").show();
			}
			else
			{
				$("#dvPassport15").hide();
			}
			
			
		}
		
		function clicking6(){
			var click6 = document.getElementById("icon0007").checked;
			if(click6)
			{
				$("#dvPassport17").show();
			}
			else
			{
				$("#dvPassport17").hide();
			}
			
		}
		
		function clicking7(){
			var click7 = document.getElementById("icon0008").checked;
			if(click7)
			{
				$("#dvPassport").show();
			}
			else
			{
				$("#dvPassport").hide();
			}
			
		}
		
		
		
		</script>
		<script >
		function closeDiv(){
// 			document.getElementById("quantity0000").value = "";
// 			document.getElementById("quantity0001").value = "";
// 			document.getElementById("quantity0002").value = "";
// 			document.getElementById("quantity0003").value = "";
// 			document.getElementById("quantity0004").value = "";
// 			document.getElementById("quantity0005").value = "";
// 			document.getElementById("quantity0006").value = "";
// 			document.getElementById("quantity0007").value = "";
// 			document.getElementById("quantity0008").value = "";
			

			 
			
			
// 			document.getElementById("quantity20").value = "";
// 			document.getElementById("quantity2").value = "";
// 			 document.getElementById("quantity3").value = "";
// 			 document.getElementById("quantity4").value = "";
// 			 document.getElementById("quantity5").value = "";
// 			 document.getElementById("quantity6").value = "";
// 			 document.getElementById("quantity7").value = "";
// 			 document.getElementById("quantity8").value = "";
// 			 document.getElementById("quantity").value = "";
// 			 document.getElementById("test1350").checked = false;
// 			 document.getElementById("test135").checked = false;
// 			 document.getElementById("test107").checked = false;
// 			 document.getElementById("test109").checked = false;
// 			 document.getElementById("test111").checked = false;
// 			 document.getElementById("test113").checked = false;
// 			 document.getElementById("test115").checked = false;
// 			 document.getElementById("test117").checked = false;
// 			 document.getElementById("test119").checked = false;
// 			 document.getElementById("test0000").checked = false;
// 			 document.getElementById("test0001").checked = false;
// 			 document.getElementById("test0002").checked = false;
// 			 document.getElementById("test0003").checked = false;
// 			 document.getElementById("test0004").checked = false;
// 			 document.getElementById("test0005").checked = false;
// 			 document.getElementById("test0006").checked = false;
// 			 document.getElementById("test0007").checked = false;
// 			 document.getElementById("test0008").checked = false;
			 /* $('#quantity0000').hide();
			 $('#quantity0001').hide();
			 $('#quantity0002').hide();
			 $('#quantity0003').hide();
			 $('#quantity0004').hide();
			 $('#quantity0005').hide();
			 $('#quantity0006').hide();
			 $('#quantity0007').hide();
			 $('#quantity0008').hide();
			 
			 
			 $('#quantity20').hide();
			 
			 $('#quantity2').hide();
	 			 $('#quantity3').hide();
				 $('#quantity4').hide();
				 $('#quantity5').hide();
	 			 $('#quantity6').hide();
				 $('#quantity7').hide();
	 			 $('#quantity8').hide();
	 			 $('#quantity').hide();  */
			 
			 
			 $('#modal29').hide();	
			
		}
		
		</script>
		
		<script >
		function clickings0(){
			
			$("#dvPassport5001").show();
		}
		
		
		
		
		</script>
		<script >
// 		$(function(){
// 		    $('#searchBar').val('hi')
// 		});
		/* $('#112233').change(function(){
			var x=(this).val();
			console.log(x);
			$('#112244').val($('#112233').last().html());
		}); */
		</script>
		<script >
		function reset1(){
			
			
			$('#dirTitle0').val('');
	    	$('#dirTitleColor0').val('3623DB');
	    	$('#dirTitleFont0').append('<option selected style="font-size:initial" value="initial">initial</option>');
	    	$('#dirTitleFamily0').append('<option selected style="font-family:Courier New" value="Courier New">Courier New</option>');
	    	$('#dirCaption0').val('');
	    	$('#dirCaptionColor0').val('3623DB');
	    	$('#dirCaptionFont0').append('<option selected style="font-size:initial" value="initial">initial</option>');
	    	$('#dirCaptionFamily0').append('<option selected style="font-family:Courier New" value="Courier New">Courier New</option>');
	    	$('#dirTimings0').val('');
	    	$('#dirTimingsColor0').val('3623DB');
	    	$('#dirTimingsFont0').append('<option selected style="font-size:initial" value="initial">initial</option>');
	    	$('#dirTimingsFamily0').append('<option selected style="font-family:Courier New" value="Courier New">Courier New</option>');
	    	$('#dirPriceColor').val('3623DB');
	    	$('#dirPriceFont').append('<option selected style="font-size:initial" value="initial">initial</option>');
	    	$('#dirPriceFamily').append('<option selected style="font-family:Courier New" value="Courier New">Courier New</option>');		    	
	    	$('#mce_0_ifr').contents().find("body").empty();
			$('#menuItemsDetails').hide();
			$('#phoneItemsDetails').hide();
		
		}
		
		</script>
		<script>
	
	
	
  //called when key is pressed in textbox
  $('.abc').keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });

</script>
		
</body>
</html>