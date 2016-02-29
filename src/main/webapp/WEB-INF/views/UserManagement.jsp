<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>  
    <title>AngularJS ngResource Example</title>  
    <style>
      .username.ng-valid {
          background-color: lightgreen;
      }
      .username.ng-dirty.ng-invalid-required {
          background-color: red;
      }
      .username.ng-dirty.ng-invalid-minlength {
          background-color: yellow;
      }

      .email.ng-valid {
          background-color: lightgreen;
      }
      .email.ng-dirty.ng-invalid-required {
          background-color: red;
      }
      .email.ng-dirty.ng-invalid-email {
          background-color: yellow;
      }

    </style>
    <link href="<c:url value='/static/css/main.css' />" rel="stylesheet"></link>
    <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
	<link href="<c:url value='/static/css/paper.css' />" rel="stylesheet"></link>
    <link href="<c:url value='/static/css/bootstrap.min.css' />" rel="stylesheet"></link>
    
    <link href="<c:url value='/static/js/libs/bootstrap-additions/dist/bootstrap-additions.min.css' />" rel="stylesheet"></link>
	<link href="<c:url value='/static/js/libs/angularjs-toaster/toaster.min.css' />" rel="stylesheet"></link>
	<link href="<c:url value='/static/js/libs/ladda/dist/ladda-themeless.min.css' />" rel="stylesheet"></link>
	<link href="<c:url value='/static/js/libs/font-awesome/css/font-awesome.min.css' />" rel="stylesheet"></link>
     
  </head>
  <body ng-app="myTaxi" class="ng-cloak"> 
  <nav class="navbar navbar-inverse navbar-fixed-top" >
		<div class="container" >
			<div class="navbar-header" >
				<a class="navbar-brand"
				   href="#" >Users
				</a >
			</div >
		</div >
	</nav >
 
    <div class="container main-content" >

		<toaster-container ></toaster-container >
	
		<div class="row" >
			<div class="col-md-8"
			     ng-controller="UserListController" >
				<div class="row" >
					<div class="col-md-12" >
						<form class="form-inline well well-sm" >
							<span class="fa fa-search" ></span >
	
							<div class="form-group" >
								<input type="text"
								       class="form-control"
								       id="name"
								       ng-model="search"
								       placeholder="Search name..."
										/>
							</div >
	
							<span class="fa fa-sort" ></span >
	
							<div class="form-group" >
								<select class="form-control"
								        ng-model="order" >
									<option value="username" >Name (ASC)</option >
									<option value="-username" >Name (DEC)</option >
									<option value="email" >Email (ASC)</option >
									<option value="-email" >Email (DEC)</option >
								</select >
							</div >
	
							<button class="btn btn-primary pull-right"
							        ng-click="showCreateModal()" >Create
							</button >
	
						</form >
	
						<table class="table table-bordered"
						       infinite-scroll="loadMore()"
						       infinite-scroll-immediate-check="false"
						       infinite-scroll-distance="1" >
	
							<tr >
								<th class="col-1">#</th >
								<th class="col-2">
									<div class="sortables" >
										<span ng-click="order = 'username'"
										      class="fa fa-sort-asc" ></span >
										<span ng-click="order = '-username'"
										      class="fa fa-sort-desc" ></span >
									</div >
									Name
								</th >
								
								<th class="col-3">									
									Address
								</th >
								
								<th class="col-4">
									<div class="sortables" >
										<span ng-click="order = 'email'"
										      class="fa fa-sort-asc" ></span >
										<span ng-click="order = '-email'"
										      class="fa fa-sort-desc" ></span >
									</div >
									Email
								</th >
								
								
							</tr >
	
							<tr ng-repeat="user in users.user"
							    ng-style="{
								 'background-color': user.email == users.selectedUser.email ? 'lightgray' : ''
							}"
							    ng-click="users.selectedUser = user" >
								
								<td >{{ user.id }}</td >
								<td >{{ user.username }}</td >
								<td >{{ user.address }}</td >
								<td >{{ user.email }}</td >
								
							</tr >
	
	
						</table >
	
						<div ng-show="users.user.length == 0 && !users.isLoading" >
							<div class="alert alert-info" >
								<p class="text-center" >No results found for search term '{{ search }}'</p >
							</div >
						</div >
	
						<div class="spinner"
						     ng-show="users.isLoading" >
							<span us-spinner="{radius:8, width:5, length: 3, lines:9}" ></span >
	
							<p >Loading...</p >
						</div >
	
					</div >
				</div >
	
			</div >
			<div class="col-md-4"
			     ng-controller="UserDetailController" >
	
				<div class="panel panel-default" >
					<div class="panel-heading" >Details
	
						<button class="btn btn-danger btn-sm pull-right"
						        ladda="users.isDeleting"
						        ng-click="remove()" >Delete
						</button >
						<div class="clearfix" ></div >
	
					</div >
					<div class="panel-body" >
						<form class="form-horizontal"
						      ng-submit="save()"
						      novalidate >
	
							<ng-include src="'static/templates/form.html'" ></ng-include >
	
						</form >
					</div >
				</div >
			</div >
		</div >
	</div >

	<script src="<c:url value='/static/js/libs/angular/angular.js' />"></script>
	<script src="<c:url value='/static/js/libs/angular/angular-resource.js' />"></script>
	<script src="<c:url value='/static/js/libs/angular-animate/angular-animate.min.js' />"></script>
	<script src="<c:url value='/static/js/libs/ngInfiniteScroll/build/ng-infinite-scroll.min.js' />"></script>
	<script src="<c:url value='/static/js/libs/spin.js/spin.js' />"></script>
	<script src="<c:url value='/static/js/libs/angular-spinner/angular-spinner.min.js' />"></script>
	
	<script src="<c:url value='/static/js/libs/ladda/dist/ladda.min.js' />"></script>
	<script src="<c:url value='/static/js/libs/angular-ladda/dist/angular-ladda.min.js' />"></script>
	<script src="<c:url value='/static/js/libs/angular-strap/dist/angular-strap.min.js' />"></script>
	<script src="<c:url value='/static/js/libs/angular-strap/dist/angular-strap.tpl.min.js' />"></script>
	<script src="<c:url value='/static/js/libs/angularjs-toaster/toaster.min.js' />"></script>	
	<script src="<c:url value='/static/js/app.js' />"></script>
	<script src="<c:url value='/static/js/factory.js' />"></script>
	<script src="<c:url value='/static/js/service/user_service.js' />"></script>
	<script src="<c:url value='/static/js/controller/user_list_controller.js' />"></script>
	<script src="<c:url value='/static/js/controller/user_detail_controller.js' />"></script>
  </body>
</html>