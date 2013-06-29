// Module pattern
// Towers = (function() {
// 	function Game() {}
// 	// asdfsdf
// 	function UI() {}
// 	// asdffasdf
//
//
// 	return {
// 		Game: Game,
// 		UI: UI
// 	}
// })();


// Namespacing method 2
// Towers = {}

// Towers.Game = (function () {
// 	function Game () {
//
// 	}
//
// 	// asdfsdf
//
//
// 	return Game;
// })();

// Towers.UI ....

Towers = {};

Towers.Game = (function(){

	function Game() {
		this.tower1 = [3,2,1];
		this.tower2 = [];
		this.tower3 = [];
		this.towers = [this.tower1, this.tower2, this.tower3]
	};

	Game.prototype.moveDisc = function (fromTower, toTower) {
		var disc = this.towers[fromTower - 1].pop();
		var fromTower = this.towers[fromTower - 1];
		var toTower = this.towers[toTower - 1];
		if(toTower[toTower.length - 1] < disc){
			console.log("Invalid Move");
			fromTower.push(disc);
			return false;
		}else{
			toTower.push(disc);
			return true;
		};
	};

	Game.prototype.display = function () {
		console.log(this.tower1);
		console.log(this.tower2);
		console.log(this.tower3);
	};

	Game.prototype.gameOver = function () {
		if(tower1.length == 0 && (tower2.count == 3 || tower3.count == 3)){
			console.log("You Win");
		};

	};

	return Game;
})();

// var game1 = new Game();
// game1.moveDisc(game1.tower1,game1.tower2);
// game1.display();
// game1.moveDisc(game1.tower1,game1.tower3);
// game1.display();
// game1.moveDisc(game1.tower2,game1.tower3);
// game1.display();
// game1.moveDisc(game1.tower1,game1.tower2);
// game1.display();
// game1.moveDisc(game1.tower3,game1.tower1);
// game1.display();
// game1.moveDisc(game1.tower3,game1.tower2);
// game1.display();
// game1.moveDisc(game1.tower1,game1.tower2);