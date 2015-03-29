(function () {
  if (window.Game === undefined) {
    window.Game = {};
  }

  var View = Game.View = function (el, size) {
    if (!size) {
      size = [10, 10];
    }
    this.$el = $(el);
    this.board = new Game.Board(size);
    this.bindHandlers();
    this.playGame();
  };

  View.prototype.bindHandlers = function () {
    var snake = this.board.snake;
    key('up', function () {
      snake.dir = [-1, 0];
    });
    key('right', function () {
      snake.dir = [0, 1];
    });
    key('down', function () {
      snake.dir = [1, 0];
    });
    key('left', function () {
      snake.dir = [0, -1];
    });
  };

  View.prototype.step = function () {
    this.board.snake.move();
    var boardContents = this.board.render();
    this.$el.empty();
    this.$el.append(boardContents);
  };

  View.prototype.playGame = function () {
    var view = this;
    window.setInterval(view.step.bind(view), 1000);
  };

})();
