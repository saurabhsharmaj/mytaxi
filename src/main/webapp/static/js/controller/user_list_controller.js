'use strict';

app.controller('UserListController', function ($scope, $modal, UserService) {

	$scope.search = "";
	$scope.order = "email";
	$scope.userService = UserService;

	$scope.loadMore = function () {
		console.log("Load More!!!");
		$scope.userService.loadMore();
	};

	$scope.showCreateModal = function () {
		$scope.userService.selectedUser = {};
		$scope.createModal = $modal({
			scope: $scope,
			template: 'static/templates/modal.create.tpl.html',
			show: true
		})
	};

	$scope.createUser = function () {
		console.log("createUser");
		$scope.userService.createUser($scope.userService.selectedUser)
			.then(function () {
				$scope.createModal.hide();
			})
	};

	$scope.$watch('search', function (newVal, oldVal) {
		if (angular.isDefined(newVal)) {
			$scope.userService.doSearch(newVal);
		}
	});

	$scope.$watch('order', function (newVal, oldVal) {
		if (angular.isDefined(newVal)) {
			$scope.userService.doOrder(newVal);
		}
	})

});