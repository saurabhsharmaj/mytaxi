'use strict';

App.controller('UserController', [
		'$scope',
		'User',
		'$q',
		'$modal',
		'toaster',
		function($scope, User, $q,$modal, toaster) {
			$scope.search = "";
			$scope.order = "username";
			$scope.selectedUser = null;
			$scope.selectedIndex = null;

			$scope.loadMore = function() {
				console.log("Load More!!!");
				$scope.ctrl.loadMore();
			};
			
			$scope.showCreateModal = function () {
				$scope.ctrl.selectedUser = {};
				$scope.createModal = $modal({
					scope: $scope,
					template: 'static/templates/modal.create.tpl.html',
					show: true
				})
			};

			$scope.selectUser = function(user, index) {				
				$scope.selectedIndex = index;
				$scope.selectedUser = user;
			};

			$scope.sensitiveSearch = function(user) {
				if ($scope.search) {
					return user.username.indexOf($scope.search) == 0
							|| user.email.indexOf($scope.search) == 0;
				}
				return true;
			};

			var self = this;
			self.user = new User();
			self.page = 1;
			self.hasMore = true;
			self.isLoading = false;
			self.isSaving = false;
			self.selectedUser = null;
			self.users = [];

			self.search = null;

			self.doSearch = function(search) {
				self.hasMore = true;
				self.page = 1;
				self.users = [];
				self.search = search;
				self.loadUsers();
			};

			self.doOrder = function(order) {
				self.hasMore = true;
				self.page = 1;
				self.users = [];
				self.ordering = order;
				self.loadUsers();
			};

			self.loadMore = function() {
				if (self.hasMore && !self.isLoading) {
					self.page += 1;
					self.loadUsers();
				}
			};

			self.loadUsers = function() {
				if (self.hasMore && !self.isLoading) {
					self.isLoading = true;

					var params = {
						'page' : self.page,
						'search' : self.search,
						'ordering' : self.ordering
					};

					User.get(params, function(data) {
						console.log(data);
						angular.forEach(data.results, function(user) {
							console.log(JSON.stringify(user));
							self.users.push(new User(user));
						});

						if (!data.next) {
							self.hasMore = false;
						}
						self.isLoading = false;
					});
				}

			};

			self.fetchAllUsers = function() {
				self.users = User.query();
			};

			self.createUser = function (user) {
				var d = $q.defer();
				self.isSaving = true;
				User.save(user).$promise.then(function () {
					self.isSaving = false;
					self.selectedPerson = null;
					self.hasMore = true;
					self.page = 1;
					self.users = [];
					toaster.pop('success', 'Created ' + user.username);
					d.resolve()
				});
				return d.promise;
			};

			self.updateUser = function(user) {
				self.isSaving = true;
				user.$update(function() {
					self.isSaving = false;
					
				});
			};

			self.deleteUser = function(identity) {
				self.isDeleting = true;
				var user = User.get({
					id : identity
				}, function() {
					user.$delete(function() {
						self.isDeleting = false;
						var index = self.users.indexOf(user);
						self.users.splice(index, 1);
						self.selectedUser = null;
						
						console.log('Deleting user with id ', identity);
						toaster.pop('success', 'Deleted ' + user.username);
						
					});
				});
			};

			self.loadUsers();

			self.submit = function() {
				if (self.user.id == null) {
					console.log('Saving New User', self.user);
					toaster.pop('success', 'Created ' + self.user.username);
					self.createUser(self.user);
				} else {
					console.log('Upddating user with id ', self.user.id);
					self.updateUser(self.user);
					console.log('User updated with id ', self.user.id);
					toaster.pop('success', 'Updated ' + self.user.username);
				}
				self.reset();
			};

			self.edit = function(id) {
				console.log('id to be edited', id);
				for (var i = 0; i < self.users.length; i++) {
					if (self.users[i].id === id) {
						self.user = angular.copy(self.users[i]);
						break;
					}
				}
			};

			self.remove = function(id) {
				console.log('id to be deleted', id);
				if (self.user.id === id) {//If it is the one shown on screen, reset screen
					self.reset();
				}
				self.deleteUser(id);
			};

			self.reset = function() {
				self.user = new User();
				$scope.myForm.$setPristine(); //reset Form
			};

		} ]);
