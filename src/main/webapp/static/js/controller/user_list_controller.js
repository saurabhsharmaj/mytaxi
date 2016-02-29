'use strict';

app.controller('UserListController', function ($scope, $modal, UserService) {

	$scope.search = "";
	$scope.order = "email";
	$scope.users = UserService;

	$scope.loadMore = function () {
		console.log("Load More!!!");
		$scope.users.loadMore();
	};

	$scope.showCreateModal = function () {
		$scope.users.selectedUser = {};
		$scope.createModal = $modal({
			scope: $scope,
			template: 'static/templates/modal.create.tpl.html',
			show: true
		})
	};

	$scope.createUser = function () {
		console.log("createUser");
		$scope.users.createUser($scope.users.selectedUser)
			.then(function () {
				$scope.createModal.hide();
			})
	};

	$scope.$watch('search', function (newVal, oldVal) {
		if (angular.isDefined(newVal)) {
			$scope.users.doSearch(newVal);
		}
	});

	$scope.$watch('order', function (newVal, oldVal) {
		if (angular.isDefined(newVal)) {
			$scope.users.doOrder(newVal);
		}
	})

});