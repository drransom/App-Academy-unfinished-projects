(function () {
  if (window.Game === undefined) {
    window.Game = {};
  }

  var View = Game.View = function (el, size) {
    if (!size) {
      size = [20, 20];
    }
    this.size = size
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
    if (this.board.gameIsOver()) {
      this.gameOver();
    } else {
      this.renderView(this.constructBoard());
    }
    this.spawnApples(0.1);
  };

  View.prototype.gameOver = function () {
    $board = this.constructBoard();
    $board.prepend('<h1>YOU LOSE</h1>')
    this.renderView($board);

    clearInterval(this.intervalId);
  };

  View.prototype.renderView = function (boardContents) {
    this.$el.empty();
    this.$el.append(boardContents);
  }


  View.prototype.playGame = function () {
    var view = this;
    this.intervalId = window.setInterval(view.step.bind(view), 500);
  };

  View.prototype.constructBoard = function () {
    var $board = $('<ul></ul>')
    $board.addClass('board')
    for (var i = 0; i < this.size[0]; i++) {
      var $row = $('<ul></ul>');
      for (var j = 0; j < this.size[1]; j++) {
        var $grid_element = $('<li></li>')
        $grid_element.data("position", [i, j]);
        $grid_element.addClass(this.board.contents([i, j])).addClass("snake-grid");
        $row.append($grid_element);
      }
      $board.append($row);
    }
    return $board;
  }

  View.prototype.spawnApples = function (pct) {
    if (Math.random() < pct) {
      this.board.spawnApple();
    } else if (Math.random() < 0.5) {
      this.board.spawnDeathApple();
    }
  }

})();
