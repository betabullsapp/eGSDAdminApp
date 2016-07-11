<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>

<title>eGSD</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="../css/materialize.css">
<link rel="stylesheet" href="../css/materialize.min.css">
<link rel="stylesheet" href="../css/style.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link rel="stylesheet" href="../dist/themes/proton/style.min.css" />
<script src="../dist/libs/jquery.js"></script>
<script src="../dist/jstree.min.js"></script>


<meta name="robots" content="index,follow" />
<!--    <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../assets/dist/themes/proton/style.css" />
    <link rel="stylesheet" href="../assets/docs.css" />
  -->
<!--[if lt IE 9]><script src="./assets/respond.js"></script><![endif]-->

<script src="../assets/jquery-1.10.2.min.js"></script>
<script src="../assets/dist/jstree.min.js"></script>

</head>
<body>

	<div class="navbar-fixed">
		<nav>
			<div class="nav-wrapper">
				<a href="#" class="brand-logo center"><img class="img"
					src="img/hotel.jpg" /> eGSD</a>
			</div>

		</nav>

	</div>

	<div class="row">
		<div class="col-md-4">
			<div id="jstree-proton-1" style="margin-top: 20px;"
				class="proton-demo">
				<ul>

					<li>Hotels <c:forEach var="locObj" items="${locObj}">
							<ul>
								<li>${locObj.name}
									<ul>
										<li>Diretory Items <c:forEach var="direcObjList"
												items="${direcObjList}">
												<ul>
													<c:if
														test="${locObj.directory eq direcObjList.directoryId }">
														<li>${direcObjList.title}<c:forEach var="subDirObj"
																items="${subDirObj}">
																<ul>
																	<c:if
																		test="${direcObjList.objectId eq subDirObj.parentDirectoryId }">
																		<li>${subDirObj.title }
																			<ul>
																				<c:forEach var="subsubDirObj" items="${subsubDirObj }">
																				<c:if test="${(subDirObj.objectId eq subsubDirObj.directoryId) }">
																				<c:if test="${(subsubDirObj.directoryId eq subsubDirObj.parentDirectoryId) }">
																				<li>${subsubDirObj.title }</li>
																				</c:if>
																				</c:if>
																				</c:forEach>
																			</ul>
																		</li>
																	</c:if>
																</ul>
															</c:forEach>
														</li>
													</c:if>
												</ul>
											</c:forEach>
										</li>
									</ul>
								</li>
							</ul>
						</c:forEach>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<script>
		$(function() {
			$('#jstree-proton-1').jstree({
				'core' : {
					'themes' : {
						'name' : 'proton',
						'responsive' : true
					}
				}
			});
		});
	</script>

</body>
</html>
