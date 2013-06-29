var readline = require("readline");

var reader = readline.createInterface({
	input: process.stdin,
	output: process.stdout
});

function askLessThan(el1, el2, callback) {
	reader.question(
		"Is " + el1 + " bigger than " + el2 + "?", 
		function (answer) {
			if (answer == "yes") {
				callback(true);
			} else {
				callback(false);
			}
		}
	);
};

/* formula for loop with non-blocking IO: 
callbacks that recursively call original method. */

function crazySortHelper(arr, i, madeAnySwaps, passCompletionCallback) {
	console.log(arr);

	if (i == ((arr.length - 1)) {
		passCompletionCallback(madeAnySwaps);;
		return;
	}

	console.log("Next comparsion: " + i):

	askLessThan(arr[i], arr[i + 1], function (lessThan) {
		// lessThan is true or false---> see askLessThan above!
		console.log("Making swap");
		if (!lessThan) {
			var tmp = arr[i];
			arr[i] = arr[i + 1];
			arr[i + 1] = temp;
			madeAnySwaps = true;
		}

			crazySortHelper(arr, i + 1, madeAnySwaps, passCompletionCallback);
		});
};

function crazySort(arr, sortCompletionCallback) {
	console.log("Next pass: ")
	crazySortHelper(arr, 0, false, function(madeAnySwaps) {
		if (madeAnySwaps) {
			crazySort(arr, sortCompletionCallback);
		} else {
			sortCompletionCallback(arr);
		};
	});
};

/* The function passed as the second argument will be considered sortCompletionCallback, 
as  defined above */
crazySort([3,2,1], function (anySwaps) {
	console.log("We finished!");
	console.log(arr);
};

/* 
In JavaScript-- if you need input from the user, you NEED callbacks.
Asteroids--> when they press a key, call a callback so that it updates the game.

Re-do this.

You'll have to do a lot of passing around of functions that you won't know how they work yet.

Eloquent JavaScript
Javascript is Sexy
Effective Javascript

When starting out with the program:
	-Write one pass.
	-Then figure out how to get to the next pass if you still need to do sorting, or to end it.
*/

//More with recursive callbacks.

function addSomeNumbers(sum, numsLeft, callback) {
	if (numsLeft > 0) {
		reader.question("Give me num: ", function (numStr) {
			var thisNumber = parseInt(numStr);
			addSomeNumbers(sum + thisNumber, numsLeft - 1, callback);
		})
	} else {
		callback(sum);
	}
};

addSomeNumbers(0, 4, function (sum) {
	console.log("You made it!");
	console.log(sum);
});