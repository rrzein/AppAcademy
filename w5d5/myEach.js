var myEach = function(array, fun) {
	for (var i = 0; i < array.length; i++) {
		fun(array[i]);
	}
	return array;
};

var multiples = function(value) {
	return value * 2;
};

myEach([1,2,3], multiples);
console.log(multiples);