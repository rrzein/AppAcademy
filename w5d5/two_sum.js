var array = [5, 6, 3, -6, 0, 0, -5];
var twoSum = function(array) {
	var pairs = [];
	for (var i = 0; i < array.length; i++) {
		var singlePair = [];
		for (var j = i + 1; j < array.length; j++) {
			if ((array[i] + array[j]) === 0) {
				singlePair[0] = i;
				singlePair[1] = j;
				pairs.push(singlePair);
			}
		}
	}
	return pairs;
}

console.log(twoSum(array));