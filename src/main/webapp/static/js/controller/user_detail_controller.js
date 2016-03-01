'use strict';

app.controller('UserDetailController', function ($scope, UserService) {
	$scope.userService = UserService;


	$scope.save = function () {
		$scope.userService.updateUser($scope.userService.selectedUser)
	};

	$scope.remove = function () {
		$scope.userService.removeUser($scope.userService.selectedUser)
	}
});