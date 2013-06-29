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