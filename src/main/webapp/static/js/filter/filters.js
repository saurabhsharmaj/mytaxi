'use strict';

app.filter('defaultImage', function () {

	return function (input, param) {
		console.log(input);
		console.log(param);
		if (!input) {
			return param;
		}
		return input;
	};

});