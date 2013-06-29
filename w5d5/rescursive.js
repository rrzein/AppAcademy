function myEach (array, fun) {
	this.new_array = []
	for (var i = 0; i < array.length; i++) {
		this.new_array[i] = fun(array[i])
	}
	return array;
};

Array.prototype.myEach = function (fun) {
	this.new_array = [];
	for (var i = 0; i < this.length; i++ ) {
		this.new_array[i] = fun(this[i]);
	};
	return this;
};

Array.prototype.myMap = function (fun) {
	this.new_array = [];
	for (var i = 0; i < this.length; i++ ) {
		this.new_array[i] = fun(this[i]);
	};
	return this.new_array;
};

var multiples = function(value) {
	return value * 2;
};


console.log([1,2,3,4,5].myMap(multiples));

function myMap (array,fun) {
	myEach(array,fun);
	return this.new_array;
};

function Range(start, end) {
  if (start === end) {
    return [start];
    } else {
			return [start].concat(Range(start + 1, end));
      };
};

function ArraySum(array) {
	if (array.length === 1) {
		return array[0];
	} else {
		return array[0] + ArraySum(array.slice(1));
	};
};

function Exponent(base, power) {
	if (power === 0) {
		return 1;
	} else {
		return base * Exponent(base, power - 1);
	};
};

function Exponent2(base, power) {
	if (power === 0) {
		return 1;
	} else {
		if (power % 2 === 0) {
			return Exponent2(base, power/2) * Exponent2(base, power/2);
		} else {
			return base * Exponent2(base, (power - 1)/2) * Exponent2(base, (power - 1)/2);
		}
	}
};

function RecursiveFibs(n) {
	if (n === 1) {
		return [0];
	} else if (n === 2) {
		return [0, 1];
	} else {
		var restFibs = RecursiveFibs(n-1);
		var newNum = [restFibs[restFibs.length - 1] + restFibs[restFibs.length - 2]];
		return RecursiveFibs(n - 1).concat(newNum);
	};
};

function binarySearch(array, target) {
	var median = Math.floor(array.length/2);

	var left = array.slice(0, median);
	var right = array.slice(median + 1);

	if (array[median] === target) {
		return median;
	} else if (array[median] > target) {
		return binarySearch(left, target);
	} else if (array[median] < target) {
		return binarySearch(right, target) + median + 1;
	} else {
		return null;
	};
};

function includes(array, target) {
	for (i = 0; i < array.length; i++) {
		if (array[i] === target) {
			return true;
		};
	};
	return false;
};

function merge(left, right) {
	var merged_arrays = [];

	while (left.length > 0 && right.length > 0) {
		if (left[0] < right[0]) {
			merged_arrays.push(left.shift());
		} else {
			merged_arrays.push(right.shift());
		};
	};

	return merged_arrays.concat(left).concat(right);
};

function mergeSort(arr) {
	if (arr.length < 2) {
		return arr;
	};

	var median = Math.floor(arr.length / 2);
	var left = arr.slice(0, median);
	var right = arr.slice(median);

	var sortedLeft = mergeSort(left);
	var sortedRight = mergeSort(right);

	return merge(sortedLeft, sortedRight);
};

function subsets(arr) {
	if (arr.length === 0) {
		return [[]];
	} else {
		var val = arr[0];
		var subs = subsets(arr.slice(1));
		var new_subs = subs.myMap( function (sub) {
			return [val].concat(sub);
		});
		return subs.concat(new_subs);
	}
};




console.log(Range(5,8));

console.log(ArraySum([1,2,3,4,5]));

console.log(Exponent(2,5));

console.log(Exponent2(2,5));

console.log(includes([2,4,8,13,15,19], 15));

console.log(binarySearch([2,4,8,13,15,19], 15));

console.log(mergeSort([5,2,6,7,1,8,9]));
// console.log("subsets");

// console.log(subsets([2,4,8,13,15,19]))