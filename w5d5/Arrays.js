//REMOVE DUPS

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

//Better way of removeDups *****
Array.prototype.removeDups = function() {
	var uniques = [];

	for (var i = 0; i < this.length; i++) {
		// if the uniques array is empty
		// or if the uniques array doesn't contain the item
		//Note the better equivalent of the includes? function
		if (uniques.length === 0 || uniques.indexOf(this[i]) === -1) {
			uniques.push(this[i]);
		}
	}
	return uniques;
};


console.log(uniq(array));

//TRANSPOSE
//original way:
var rows = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ];

console.log(rows);

var transpose = function(array) {
	var newArray = [];

	for (var i = 0; i < array[0].length; i++) {
		tColumn = [];
		for (var j = 0; j < array.length; j++) {
			tColumn.push(array[j][i]);
		}
		newArray.push(tColumn);
	}
	return newArray;
};

console.log(transpose(rows));

//BETTER WAY:
Array.prototype.transpose = function() {
	var matrix = [];
	for (var i = 0; i < this.length; i++) {
		matrix.push([]);
		for (var j = 0; j < this.length; j++) {
			matrix[i].push(this[j][i]);
		}
	}
	return matrix;
};