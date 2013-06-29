var array = [1, 2, 3];

var multiples = function(array) {
	var newArray = [];
	for(var i = 0; i < array.length; i++) {
		newArray.push(array[i] * 2);
	};
	return newArray;
}

console.log(multiples(array));