//MULTIPLES
//original way (same as better way!)
var array = [1, 2, 3];

var multiples = function(array) {
	var newArray = [];
	for(var i = 0; i < array.length; i++) {
		newArray.push(array[i] * 2);
	};
	return newArray;
}

console.log(multiples(array));

//myEach:
//Original Way;
var myEach = function(array, fun) {
	for (var i = 0; i < array.length; i++) {
		fun(array[i]);
	}
	return array;
};

//BETTER WAY!
Array.prototype.myEach = function(func) {
	for (var i=0; i < this.length; i++) {
		func(this[i]);
	}
	return this;
};

//inject
//Original Way:
function Inject(array, fun) {
	this.res = array[0]
	myEach(array, fun);
	return this.res;
};

//BETTER WAY:
Array.prototype.inject = function(element, func) {
	var injected = [];

	for (var i = 0; i < this.length; i++) {
		injected.push(func(element,this[i]));
	}

	return injected;
};