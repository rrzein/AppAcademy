SnakeGame.Game = (function() {

  function Game(size){
		this.boardSize = size;
    this.snake = new SnakeGame.Snake();
    this.board = new SnakeGame.Board(this.snake, size);
		this.buildBoard();
    };

	Game.prototype.buildBoard = function () {
		$("#game").css('width', (this.boardSize * 10) + 'px');
		$("#game").css('height', (this.boardSize * 10) + 'px');

		_.times(this.boardSize, function(index) {
			$('#game').append($('<div class="row"></div>'));
		});

		_.times(this.boardSize, function(index) {
			$('.row').append($('<div class="square"></div>'));
		});

	};

	Game.prototype.step = function() {
		this.board.moveSnake();
		this.checkLoss();
		this.board.renderGrid();
	};

	Game.prototype.renderBoard = function() {
		var that = this;
		var $rows = $('.row');
		$rows.each(function(i) {
			$(this).children().each(function(j){
				if(that.board.grid[j][i] === "O"){
					$(this).addClass("snake-piece");
				} else if (that.board.grid[j][i] === "A"){
					$(this).addClass("apple");
				} else if (that.board.grid[j][i] === "_"){
					$(this).removeClass("snake-piece");
					$(this).removeClass("apple");
				}
			});
		});
	};


	Game.prototype.clearBoard = function() {
		var $rows = $('.row');
		$rows.each(function(i) {
			$(this).children().each(function(j){
				if(that.board.grid[j][i] === "O"){
					$(this).addClass("snake-piece");
				} else if (that.board.grid[j][i] === "A"){
					$(this).addClass("apple");
				} else if (that.board.grid[j][i] === "_"){
					$(this).removeClass("snake-piece");
					$(this).removeClass("apple");
				}
			});
		});
	};

	Game.prototype.checkLoss = function() {
		if (this.board.checkCrash() || this.board.checkSelfDestruct()){
			alert("You lost the game. Game over.");
			window.clearInterval(loop);
		};
	};

	Game.prototype.snakeKeys = function() {
		var that = this;

		$('html').keydown(function(event) {
			switch (event.keyCode) {
				// up
				case 38:
					that.snake.turn("n");
					return;
				// down
				case 40:
					that.snake.turn("s");
					return;
				//left
				case 37:
					that.snake.turn("w");
					return;
				//right
				case 39:
					that.snake.turn("e");
					return;
			}
		})
	};



  return Game;

})();

$(function () {
	var game = new SnakeGame.Game(50);
	function run_loop() {
	loop = window.setInterval(function() {
			game.step();
			console.log(game.snake.body);
			game.checkLoss();
			game.renderBoard();
		}, 100);
	};
	game.snakeKeys();
	run_loop();


});