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
    <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
	<link href="<c:url value='/static/css/paper.css' />" rel="stylesheet"></link>
    <link href="<c:url value='/static/css/bootstrap.min.css' />" rel="stylesheet"></link>
    
    <link href="<c:url value='/static/js/libs/bootstrap-additions/dist/bootstrap-additions.min.css' />" rel="stylesheet"></link>
	 <link href="<c:url value='/static/js/libs/angularjs-toaster/toaster.min.css' />" rel="stylesheet"></link>
	<link href="<c:url value='/static/js/libs/ladda/dist/ladda-themeless.min.css' />" rel="stylesheet"></link>
	<link href="<c:url value='/static/js/libs/font-awesome/css/font-awesome.min.css' />" rel="stylesheet"></link>
     
  </head>
  <body ng-app="myApp" class="ng-cloak">  
      <toaster-container ></toaster-container >
      <div class="generic-container" ng-controller="UserController as ctrl">
      
          <div class="panel panel-default">
              <div class="panel-heading"><span class="lead">User Registration Form </span></div>
              <div class="formcontainer">
                  <form ng-submit="ctrl.submit()" name="myForm" class="form-horizontal">
                      <input type="hidden" ng-model="ctrl.user.id" />
                      <div class="row">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" for="uname">Name</label>
                              <div class="col-md-7">
                                  <input type="text" ng-model="ctrl.user.username" id="uname" class="username form-control input-sm" placeholder="Enter your name" required ng-minlength="3"/>
                                  <div class="has-error" ng-show="myForm.$dirty">
                                      <span ng-show="myForm.uname.$error.required">This is a required field</span>
                                      <span ng-show="myForm.uname.$error.minlength">Minimum length required is 3</span>
                                      <span ng-show="myForm.uname.$invalid">This field is invalid </span>
                                  </div>
                              </div>
                          </div>
                      </div>
                        
                      
                      <div class="row">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" for="address">Address</label>
                              <div class="col-md-7">
                                  <input type="text" ng-model="ctrl.user.address" id="address" class="form-control input-sm" placeholder="Enter your Address. [This field is validation free]"/>
                              </div>
                          </div>
                      </div>

                      <div class="row">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" for="email">Email</label>
                              <div class="col-md-7">
                                  <input type="email" ng-model="ctrl.user.email" id="email" class="email form-control input-sm" placeholder="Enter your Email" required/>
                                  <div class="has-error" ng-show="myForm.$dirty">
                                      <span ng-show="myForm.email.$error.required">This is a required field</span>
                                      <span ng-show="myForm.email.$invalid">This field is invalid </span>
                                  </div>
                              </div>
                          </div>
                      </div>

                      <div class="row">
                          <div class="form-actions floatRight">
                              <input type="submit"  value="{{!ctrl.user.id ? 'Add' : 'Update'}}" class="btn btn-primary btn-sm" ng-disabled="myForm.$invalid">
                              <button type="button" ng-click="ctrl.reset()" class="btn btn-warning btn-sm" ng-disabled="myForm.$pristine">Reset Form</button>
                          </div>
                      </div>
                  </form>
              </div>
          </div>
          
          
          
          <div class="panel panel-default">
                <!-- Default panel contents -->
              <div class="panel-heading"><span class="lead">List of Users </span></div>
              
              <div class="row" >
				<div class="col-md-12" >
					<form class="form-inline well well-sm" >
						<span class="fm fm-search" ></span >
		
						<div class="form-group" >
								<input type="text"
								       class="form-control"
								       id="name"
								       ng-model="search"
								       placeholder="Search name & email"
										/>
						</div >
		
						<span class="fm fm-sort-by-attributes" ></span >
		
						<div class="form-group" >
							<select class="form-control"
											ng-model="order">
								<option value="username" >Name (ASC)</option >
								<option value="-username" >Name (DEC)</option >
								<option value="email" >Email (ASC)</option >
								<option value="-email" >Email (DEC)</option >
							</select >
						</div >
		
					</form >
				</div >
			</div >
	
	<div class="row" >
		<div class="col-md-8" >
              <div class="tablecontainer">              	  
                  <table class="table table-hover">
                      <thead>
                          <tr>
                              <th>ID.</th>
                              <th>Name
                              	<span ng-click="order = 'username'" class="fm fm-menu-up"></span>
						<span ng-click="order = '-username'" class="fm fm-menu-down"></span>
                              </th>
                              <th>Address</th>
                              <th>Email
                              	<span ng-click="order = 'email'" class="fm fm-menu-up"></span>
						<span ng-click="order = '-email'" class="fm fm-menu-down"></span>
                              </th>
                              <th width="20%"></th>
                          </tr>
                      </thead>
                      <tbody>
                          <tr ng-repeat="u in filteredUsers = (ctrl.users | filter:sensitiveSearch | orderBy:order)" 
                          ng-style="{
							 'background-color': $index == selectedIndex ? 'lightgray' : ''
						}"
				    ng-click="selectUser(u, $index)" >
                              <td><span ng-bind="u.id"></span></td>
                              <td><span ng-bind="u.username"></span></td>
                              <td><span ng-bind="u.address"></span></td>
                              <td><span ng-bind="u.email"></span></td>
                              <td>
                              <button type="button" ng-click="ctrl.edit(u.id)" class="btn btn-success custom-width">Edit</button>  <button type="button" ng-click="ctrl.remove(u.id)" class="btn btn-danger custom-width">Remove</button>
                              </td>
                          </tr>
                          <tr ng-show="filteredUsers.length == 0">
							<td colspan="4">
								<div class="alert alert-info">
									<p class="text-center">No results found for search term '{{ search }}'</p>
								</div>
							</td>
						</tr>
                      </tbody>
                  </table>
              </div>
             </div>
             <div class="col-md-4" >

			<div class="panel panel-default" >
				<div class="panel-heading" >User Details</div >
				<div class="panel-body" >

					<dl >
						<dt >Name</dt >
						<dd >{{selectedUser.username}}</dd >
						<dt >Email</dt >
						<dd >{{selectedUser.email}}</dd >
						<dt >Address</dt >
						<dd >{{selectedUser.address}}</dd >
					</dl >

				</div >
			</div >

		</div >
             
          </div>
      </div>

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
	<script src="<c:url value='/static/js/service/user_service.js' />"></script>
	<script src="<c:url value='/static/js/controller/user_controller.js' />"></script>
  </body>
</html>