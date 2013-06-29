// window.Towers = {
// 	Game: asdfsdfadsfsadf,
// 	UI: asdfasdfsdf
// }
jQuery.fn.reverse = [].reverse
Towers.UI =(function() {

  function UI(game){
  	this.game = game;
		this.fromIndex = null;
		this.toIndex = null;
  }

	UI.prototype.display = function() {
		var that = this;

		var $towers = $('.tower');

		_.each(that.game.towers, function(tower, i) {
			var $tower = $($towers[i]).children();
			_.each($tower.reverse(), function(spot, j) {
				$(spot).removeClass();
				$(spot).addClass('spot');
				if (that.game.towers[i][j] === 3) {
					$(spot).addClass('big-disk');
				}else if (that.game.towers[i][j] === 2) {
					$(spot).addClass('medium-disk');
				}else if (that.game.towers[i][j] === 1) {
					$(spot).addClass('small-disk');
				}
			})

		});
	};

	UI.prototype.startGame = function() {
		this.display();
	};

	UI.prototype.makeMove = function() {
		var that = this;

		$('.tower').on('click', function(){
			var index = $(this).index() + 1;
			if(!that.fromIndex) {
				that.fromIndex = index
			}else{
				that.toIndex = index
				that.game.moveDisc(that.fromIndex, that.toIndex);
				that.fromIndex = null;
				that.toIndex = null;
				that.display();
			}

		})

		// $('.tower').on('click', function(e) {
// 			var fromIndex = $(this).index() + 1;
// 			$('.tower').on('click', function() {
// 				var toIndex = $(this).index() + 1;
// 				console.log(fromIndex);
// 				console.log(toIndex);
// 				that.game.moveDisc(fromIndex, toIndex);
// 				that.display();
// 				fromIndex = null;
// 				toIndex = null;
// 			});
// 		});
			// console.log($(this).index());
			// console.log(e.target);
			// that.game.moveDisc(from, to);

	};
	return UI;
})();

$(function () {
	var game = new Towers.Game()
	var ui = new Towers.UI(game)
	ui.makeMove();
	ui.startGame();
});