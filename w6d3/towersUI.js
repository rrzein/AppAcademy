// window.Towers = {
// 	Game: asdfsdfadsfsadf,
// 	UI: asdfasdfsdf
// }

Towers.UI =(function() {

  function UI(game){
  	this.game = game;
  }

	UI.prototype.display = function() {
		var that = this;
		var string = '';
		_.each(that.game.tower1, function (spot) {
				string = (spot + "\n" + string );
			});
		$('#tower1').html(string);

		string = '';
		_.each(that.game.tower2, function (spot) {
				string = (string + spot + "\n");
			});
		$('#tower2').html(string);

		string = '';
		_.each(that.game.tower3, function (spot) {
				string = (string + spot + "\n");
			});
		$('#tower3').html(string);
	};

	UI.prototype.startGame = function() {
		this.display();
	};

	UI.prototype.makeMove = function() {
		var that = this;

		$('#submit').on('click', function() {
			var from = $('#from').val();
			console.log(from);
			var to = $('#to').val();
			console.log(to);
			that.game.moveDisc(from, to);
			that.display();
	})
	};
	return UI;
})();

$(function () {
	var game = new Towers.Game()
	var ui = new Towers.UI(game)
	ui.makeMove();
	ui.startGame();
});