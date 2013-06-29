SnakeGame.UI = (function() {

	function UI(size) {
		this.boardSize = size;
		this.game = new SnakeGame.Game(size);
		this.buildBoard();
	};

	UI.prototype.buildBoard = function () {
		$("#game").css('width', (this.boardSize * 10) + 'px');
		$("#game").css('height', (this.boardSize * 10) + 'px');

		_.times(this.boardSize, function(index) {
			$('#game').append($('<div class="row"></div>'));
		});

		_.times(this.boardSize, function(index) {
			$('.row').append($('<div class="square"></div>'));
		});

	}


	return UI;

})();

$(function () {
	var game = new SnakeGame.UI(50);
});