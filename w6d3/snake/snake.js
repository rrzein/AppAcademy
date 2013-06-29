SnakeGame = {};

SnakeGame.Snake = (function (){

  function Snake() {
		this.body = [{x: 25, y: 25}, {x: 25, y: 24}, {x: 25, y: 23}];
		this.head = this.body[0];
		this.tail = this.body[this.body.length - 1];
		this.direction = Snake.NORTH;
	};

	Snake.WEST = {
		dx: 0,
		dy: -1
	};

	Snake.SOUTH = {
		dx: 1,
		dy: 0
	};

	Snake.EAST = {
		dx: 0,
		dy: 1
	};

	Snake.NORTH = {
		dx: -1,
		dy: 0
	};

	Snake.prototype.newPart = function(x, y) {
		var part = {
			x: x,
			y: y
		};

		return part;
	};

	Snake.prototype.moveForward = function() {
		var new_x = this.head.x + this.direction.dx;
		var new_y = this.head.y + this.direction.dy;
		var newHead = this.newPart(new_x, new_y);
		this.body.unshift(newHead);
		this.body.pop();
		this.updateEnds();
	};

	Snake.prototype.eatApple = function() {
		var new_x = this.head.x + this.direction.dx;
		var new_y = this.head.y + this.direction.dy;
		var newHead = this.newPart(new_x, new_y);
		this.body.unshift(newHead);
		this.updateEnds();
	};

	Snake.prototype.turn = function(direction) {
		if(direction === "n"){
			switch (this.direction) {
			case Snake.EAST:
				this.direction = Snake.NORTH;
				break;
			case Snake.WEST:
				this.direction = Snake.NORTH;
				break;
			}
		} else if (direction === "s") {
			switch (this.direction) {
			case Snake.EAST:
				this.direction = Snake.SOUTH;
				break;
			case Snake.WEST:
				this.direction = Snake.SOUTH;
				break;
			}
		} else if (direction === "e") {
			switch (this.direction) {
			case Snake.NORTH:
				this.direction = Snake.EAST;
				break;
			case Snake.SOUTH:
				this.direction = Snake.EAST;
				break;
			}
		} else if (direction === "w") {
			switch (this.direction) {
			case Snake.NORTH:
				this.direction = Snake.WEST;
				break;
			case Snake.SOUTH:
				this.direction = Snake.WEST;
				break;
			}
		}
	};

	Snake.prototype.updateEnds = function() {
		this.head = this.body[0];
		this.tail = this.body[this.body.length - 1];
	};

	return Snake;

  })();