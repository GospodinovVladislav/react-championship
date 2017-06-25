<!-- Latest compiled and minified CSS -->
<%@page import="org.apache.shiro.SecurityUtils"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link href="<c:url value="/css/bootstrap.min.css" />" rel="stylesheet">
<link href="<c:url value="/css/mdb.css" />" rel="stylesheet">
<script type="text/javascript"  src="<c:url value="/js/jquery.min.js" />"></script>
<script type="text/javascript"  src="<c:url value="/js/bootstrap.min.js" />"></script>
<script type="text/javascript"  src="<c:url value="/js/mdb.js"/>" ></script>
</head>
<body style="padding-top: 70px">
	<nav class="navbar blue navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="/championship">Championship</a>
			</div>
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a class="dropdown-toggle waves-effect waves-light"
						href="/championship/app/users">Users</a></li>
					<li><a class="dropdown-toggle waves-effect waves-light"
						href="/championship/app/participants">Participants</a></li>
					<li><a class="dropdown-toggle waves-effect waves-light"
						href="/championship/app/groups">Groups</a></li>
					<li><a class="dropdown-toggle waves-effect waves-light"
						href="/championship/app/matches">Matches</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><shiro:guest>
							<a href="#" class="dropdown-toggle waves-effect waves-light"
								data-toggle="dropdown" role="button" aria-expanded="false">
								Hello, Guest!
							</a>
								<ul class="dropdown-menu" role="menu">
									<li><a href="/championship/app/login">Login</a></li>
									<li><a href="/championship/app/register">Register</a></li>
								</ul>
						</shiro:guest> <shiro:user>
							<a href="#" class="dropdown-toggle waves-effect waves-light"
								data-toggle="dropdown" role="button" aria-expanded="false">
								Hello, <shiro:principal property="firstName" />
							</a>
								<ul class="dropdown-menu" role="menu">
									<li><a href="/championship/app/editMyAccount">My
											Account</a></li>
									<shiro:hasRole name="admin">
										<li><a href="/championship/app/admin">Admin Panel</a></li>
									</shiro:hasRole>
									<li><a href="/championship/app/logout">Log out</a></li>
								</ul>
						</shiro:user></li>
				</ul>
			</div>
		</div>
	</nav>
</body>
	