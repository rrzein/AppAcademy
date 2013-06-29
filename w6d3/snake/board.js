SnakeGame.Board = (function() {

  function Board(snake, size) {
		this.gridSize = size;
		this.snake = snake;
	  this.grid = this.buildGrid();
		this.apple = {};
		this.placeApple();
  };

	Board.prototype.buildGrid = function() {
		var grid = [];
		for(var i = 0; i < this.gridSize; i++){
			var row = [];
			for(var j = 0; j < this.gridSize; j++){
				row.push("_");
			}
			grid[i] = row;
		};
		return grid;
	};


	Board.prototype.placeApple = function() {
		var apple = "A";
		var placed = false

		while(!placed) {
			randX = Math.floor(Math.random() * this.gridSize);
			randY = Math.floor(Math.random() * this.gridSize);
			this.apple.x = randX;
			this.apple.y = randY;

			if (this.grid[randX][randY] === "_"){
				this.grid[randY][randX] = apple;
				placed = true;
			};
		};
	};

	Board.prototype.renderGrid = function() {
		this.grid = this.buildGrid();

		for (var i = 0; i < this.snake.body.length; i++) {
			var x = this.snake.body[i].x;
			var y = this.snake.body[i].y;
			this.grid[y][x] = "O";
		};

		this.grid[this.apple.y][this.apple.x] = "A";

		return this.grid;
	};

	Board.prototype.displayGrid = function() {
		for(var i = 0; i < this.grid.length; i++){
			console.log(this.grid[i]);
		};
	};

	Board.prototype.checkApple = function() {
		var new_x = this.snake.head.x + this.snake.direction.dx;
		var new_y = this.snake.head.y + this.snake.direction.dy;
		var approachingApple = (new_x == this.apple.x &&
			new_y == this.apple.y);
			if(approachingApple) {
				return true;
			};
			return false;
	};

	Board.prototype.checkCrash = function() {
		var max = this.gridSize - 1;

		var crash = (this.snake.head.y < 0 || this.snake.head.y > max
		|| this.snake.head.x < 0 || this.snake.head.x > max)

		if(crash) {
			return true;
		} else {
			return false;
		}
	};

	Board.prototype.checkSelfDestruct = function() {
		var that = this;
		var new_x = this.snake.head.x + this.snake.direction.dx;
		var new_y = this.snake.head.y + this.snake.direction.dy;

		_.each(this.snake.body, function(element, index) {
			if(index != 0) {
				console.log(index);
				console.log(that.snake.head.x);
				console.log(element.x);
				if(that.snake.head.x == element.x && that.snake.head.y == element.y){
					return true;
				};
			};
		});
			return false;
	};

	Board.prototype.moveSnake = function() {
		if(this.checkApple()) {
			this.snake.eatApple();
			this.placeApple();
		} else {
			this.snake.moveForward();
		}
	};

  return Board;

})();