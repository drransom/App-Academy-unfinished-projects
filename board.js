(function () {
  if(window.Game === undefined) {
    window.Game = {};
  }

  Board = Game.Board = function (size) {
    this.snake = new Game.Snake(size);
    this.apples = [];
    this.size = size;
  };

  Board.prototype.render = function () {
    var output = "";
    for (var i = 0; i < this.size[0]; i++) {
      for (var j = 0; j < this.size[1]; j++) {
        if (this.emptyPos([i, j])) {
          output += "_";
        } else {
          output += "*";
        }
      }
      output += "\n";
    }
    return output;
  };

  Board.prototype.renderGameOver = function () {
    return this.render() + "YOU LOSE";
  }

  Board.prototype.emptyPos = function (pos) {
    return !(this.snake.includesPos(pos) || this.apples.some(function(apple) {
      (apple[0] === pos[0] && apple[1] === pos[1])
    }));
  };

  Board.prototype.gameIsOver = function () {
    return (this.snake.selfCollide() || this.snake.offBoard());
  };

  Board.prototype.contents = function (pos) {
    if (this.snake.includesPos(pos)) {
      return "snake";
    } else if (Game.Coord.coordArrIncludes(this.apples, pos)) {
      return "apple";
    } else {
      return "unoccupied";
    };
  }


})();
