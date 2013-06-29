var array = [1, 2, 1, 3, 3];

var contains = function(array, value) {
	var i = array.length;
	while (i--) {
		if (array[i] == value) {
			return true;
		}
	}
	return false;
};

var uniq = function(array) {
	var newArray = [array[0]];

	for(var ii = 0; ii < array.length; ii++) {
		if (contains(newArray, array[ii])) {
		} else {
			newArray.push(array[ii]);
		}
	}
	return newArray;
};


console.log(uniq(array));