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
			    	  $("#groupSearchResults").append(tableDetails);
			    	  $('.groupSpin').hide();
		    	  }
		    	 
		    	  
		     },
		     error : function(error) {
		    	console.log(error);
		     }
		  });
    
    
		});