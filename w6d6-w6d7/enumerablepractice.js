Array.prototype.myEach = function(fun) {
	this.new_array = [];
	for (i = 0; i < this.length; i++) {
		this.new_array[i] = fun(this[i])
	}
	return this;
}

Array.prototype.myMap = function(fun) {
	this.new_array = [];
	this.myEach(fun);
	return this.new_array;
}

function inject(array, fun){
	this.res = array[0]
	myEach(array, fun));
	return this.res;
}

function bubbleSort(array){
	var sorted = false
	var new_array = array.slice();

	while(!sorted) {
		var sorted = true;
		for (i = 0; i < array.length - 1; i++) {
			if (array[i] > array[i + 1]) {
				var temp = array[i];
				array[i] = array[i + 1];
				array[i + 1] = temp;
				var sorted = false;
			}
		}
	}

	return array;
}

function mergeSort(array) {
	if(array.count < 2){
		return array;
	}

	var median = Math.floor(array.length / 2);
	var left = array.slice(0,median);
	var right = array.slice(median);

	var sortedLeft = mergeSort(left);
	var sortedRight = mergeSort(right);

	return merge(sortedLeft, sortedRight);


}

function merge(sortedLeft, sortedRight) {
var new_array = []

	while(sortedLeft.length > 0 && sortedRight.length > 0){
		if (sortedLeft[0] < sortedRight[0]) {
			new_array.push(sortedLeft.shift());
		} else {
			new_array.push(sortedRight.shift());
		};
	};
	return new_array.concat(sortedLeft).concat(sortedRight);
};

function subsets(arr) {
	if (arr.length===0) {
		return [[]];
	} else {
		var val = arr[0];
		var subs = subsets(arr.slice(1));
		var newsubs = subs.myMap( function (sub){
			return [val].concat(sub);
		};
		return subs.concat(newsebs);
	}
};

function RecursiveFibs(n) {
	if (n === 1) {
		return [0];
	} else if (n === 2) {
		return [0, 1];
	} else {
		var last_num = RecursiveFibs(n - 1)[RecursiveFibs(n - 1).length - 1];
		var second_to_last = RecursiveFibs(n - 1)[RecursiveFibs(n - 1).length - 2];
		return RecursiveFibs(n - 1).concat[last_num + second_to_last];
	};
}