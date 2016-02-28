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
  <body ng-app="myApp" class="ng-cloak">  
      <toaster-container ></toaster-container >
      
      <div class="generic-container" ng-controller="UserController as ctrl">
          <div class="panel panel-default">
			<ng-include src="'static/templates/list.html'" ></ng-include >
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