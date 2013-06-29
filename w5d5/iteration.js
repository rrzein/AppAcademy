function bubbleSort (array) {
	var new_array = array
	var sorted = false;

	while (sorted === false) {
		sorted = true

		for (i = 0; i < array.length - 1; i++) {
			if (new_array[i] > new_array[i + 1]) {
				var temp = new_array[i];
				new_array[i] = new_array[i + 1];
				new_array[i + 1] = temp;
				sorted = false
			};
		};
	};
	return new_array;
}; n

function substrings (string) {
	var substring_arr = []
	for (var i = 0; i < string.length; i++) {
		for (var j = i + 1; j <= string.length; j++) {
			substring_arr.push(string.substring(i, j))
		};
	};
	return substring_arr;
}

array = [1,5,6,8,3,4,0];
console.log(bubbleSort(array));
console.log(substrings("manwhat"));