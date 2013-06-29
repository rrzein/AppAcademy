TicTacToe.UI = (function() {

	function UI(board) {
		this.board = board;
		this.currentMarker = "X";
	};

	UI.prototype.display = function() {
		var that = this;

		var $rows = $(".row");
		$rows.each( function (i) {
			$(this).children().each ( function (j) {
				console.log(this);
				$(this).html(that.board.grid[i][j])
			})
		})
	};

	UI.prototype.placeMarker = function() {
		var that = this;

		var $rows = $(".row");
		$rows.each(function(i){
			$(this).children().each (function(j){
				$(this).on("click", function(){
					var win = that.board.placeMarker(that.currentMarker, [i, j]);
					if(win === true) {
						alert(that.currentMarker + " wins!")
					}

					if(that.currentMarker === "X"){
						that.currentMarker = "O";
					}else{
						that.currentMarker = "X";
					}
					that.display();
				});
			});
		});
	}

	return UI;

})();

$(function() {
	var board = new TicTacToe.Board();
	var ui = new TicTacToe.UI(board);
	ui.placeMarker();
	ui.display();
});