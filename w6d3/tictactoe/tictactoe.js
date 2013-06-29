TicTacToe = {};

TicTacToe.Board = (function() {
	function Board() {
	var that = this
	that.grid = [["_", "_", "_"],["_", "_", "_"],["_", "_", "_"]];
};

Board.prototype.makeBoard = function() {
	for(var i = 0; i < this.grid.length; i++) {
		console.log(i);
		this.grid[i] = ["_", "_", "_"];
	};
};

Board.prototype.placeMarker = function(marker, position) {
	var x = position[0];
	var y = position[1];
	if(this.grid[x][y] === "_") {
		this.grid[x][y] = marker;
		return this.checkWin();
	} else {
		alert("Invalid move.");
		return this.checkWin();
	};
};

Board.prototype.checkWin = function() {
	if(this.checkHorizontal() || this.checkVertical() || this.checkDiagonal()) {
		return true;
	};
	return false;
};

Board.prototype.checkHorizontal = function() {
	for(var i = 0; i < this.grid.length; i++) {
		if(this.grid[i][0] === this.grid[i][1] && this.grid[i][0]=== this.grid[i][2]) {
			if(this.grid[i][0] != "_") {
				return true;
			};
		};
	};
	return false;
};

Board.prototype.checkVertical = function() {
	for(var i=0; i < this.grid.length; i++) {
		if(this.grid[0][i] === this.grid[1][i] && this.grid[0][i] === this.grid[2][i]) {
			if(this.grid[0][i] != "_") {
				return true;
			};
		};
	};
	return false;
};

Board.prototype.checkDiagonal = function() {
	var diagonal1 = [this.grid[0][0], this.grid[1][1], this.grid[2][2]];
	var diagonal2 = [this.grid[2][0], this.grid[1][1], this.grid[0][2]];
	var diagonals = [diagonal1, diagonal2];
	for (var i = 0; i < diagonals.length; i++) {
		if(diagonals[i][0] === diagonals[i][1] && diagonals[i][0] === diagonals[i][2]) {
			if(diagonals[i][0] != "_") {
				return true;
			};
		};
	};
	return false;
};

Board.prototype.displayBoard = function() {
	for(var i = 0; i < this.grid.length; i++){
		console.log(this.grid[i]);
	};
	console.log(" ");
};

Board.prototype.dupBoard = function() {
	var dup = [];
	for(var i = 0; i < this.grid.length; i++) {
		dup[i] = this.grid[i].slice(0);
	};
	var newBoard = new Board();
	newBoard.grid = dup;
	return newBoard;
};

return Board;

})();

function ComputerPlayer(board) {
	this.marker = "O";
	this.board = board;
	this.grid = board.grid;
};

ComputerPlayer.prototype.makeMove = function() {
	for(var i = 0; i < this.grid.length; i++) {
		for(var j = 0; j < this.grid[i].length; j++) {
			if (this.grid[i][j] === "_") {
				var move = [i, j];
				var dupBoard = this.board.dupBoard();
				dupBoard.placeMarker(this.marker, move);
				if (dupBoard.checkWin()) {
					this.board.placeMarker(this.marker, move);
					return true;
				};
			};
		};
	};
	this.board.placeMarker(this.marker, move);
};


// var board1 = new Board();
// var comp = new ComputerPlayer(board1);
// board1.makeBoard();
// board1.displayBoard();
//
// board1.placeMarker('O', [2, 0]);
// board1.displayBoard();
// board1.placeMarker('O', [1, 1]);
// board1.displayBoard();
// comp.makeMove();
// board1.displayBoard();
// console.log(board1.checkVertical());
// console.log(board1.checkHorizontal());
// console.log(board1.checkDiagonal());
// console.log(board1.checkWin());
//
//
