'use strict';

app.service('UserService', function (User, $q, toaster) {


	var self = {
		'addUser': function (user) {
			this.users.push(user);
		},
		'page': 1,
		'hasMore': true,
		'isLoading': false,
		'isSaving': false,
		'selectedUser': null,
		'users': [],
		'search': null,
		'doSearch': function (search) {
			self.hasMore = true;
			self.page = 1;
			self.users = [];
			self.search = search;
			self.loadUsers();
		},
		'doOrder': function (order) {
			self.hasMore = true;
			self.page = 1;
			self.users = [];
			self.ordering = order;
			self.loadUsers();
		},
		'loadUsers': function () {
			if (self.hasMore && !self.isLoading) {
				self.isLoading = true;

				var params = {
					'page': self.page,
					'search': self.search,
					'ordering': self.ordering
				};

				User.get(params, function (data) {
					console.log(data);
					angular.forEach(data.results, function (user) {
						self.users.push(new User(user));
					});

					if (!data.next) {
						self.hasMore = false;
					}
					self.isLoading = false;
				});
			}

		},
		'loadMore': function () {
			if (self.hasMore && !self.isLoading) {
				self.page += 1;
				self.loadUsers();
			}
		},
		'updateUser': function (user) {
			console.log("Service Called Update");
			self.isSaving = true;
			user.$update().then(function () {
				self.isSaving = false;
				toaster.pop('success', 'Updated ' + user.username);
			});
		},
		'removeUser': function (user) {
			self.isDeleting = true;
			user.$remove().then(function () {
				self.isDeleting = false;
				var index = self.users.indexOf(user);
				self.users.splice(index, 1);
				self.selectedUser = null;
				toaster.pop('success', 'Deleted ' + user.username);
			});
		},
		'createUser': function (user) {
			var d = $q.defer();
			self.isSaving = true;
			User.save(user).$promise.then(function () {
				self.isSaving = false;
				self.selectedUser = null;
				self.hasMore = true;
				self.page = 1;
				self.users = [];
				self.loadUsers();
				toaster.pop('success', 'Created ' + user.username);
				d.resolve()
			});
			return d.promise;
		}


	};

	self.loadUsers();

	return self;

});