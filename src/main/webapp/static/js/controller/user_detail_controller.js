'use strict';

app.controller('UserDetailController', function ($scope, UserService) {
	$scope.users = UserService;


	$scope.save = function () {
		$scope.users.updateUser($scope.users.selectedUser)
	};

	$scope.remove = function () {
		$scope.users.removeUser($scope.users.selectedUser)
	}
});