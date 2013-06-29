var tower1 = [ 2, 1];
var tower2 = [];
var tower3 = [];

var moveDisk = function(fromTower, toTower) {
	var disk = fromTower.pop();
	if (toTower[-1 + toTower.length] < disk) {
		fromTower.push(disk);
	} else {
		toTower.push(disk);
	}
};

console.log(tower1);
console.log(tower2);
console.log(tower3);
moveDisk(tower1, tower2);
console.log(tower1);
console.log(tower2);
console.log(tower3);
console.log("new move .................")
moveDisk(tower1, tower2);
console.log(tower1);
console.log(tower2);
console.log(tower3);
console.log("new move .................")
moveDisk(tower1, tower3);
console.log(tower1);
console.log(tower2);
console.log(tower3);
console.log("new move .................")
moveDisk(tower2, tower3);
console.log(tower1);
console.log(tower2);
console.log(tower3);
