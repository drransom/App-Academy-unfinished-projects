(function () {
  if(window.Game === undefined) {
    window.Game = {};
  }

  Board = Game.Board = function (size) {
    this.apples = [];
    this.deathApples = [];
    this.size = size;
    this.snake = new Game.Snake(this);
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
    return (this.snake.selfCollide() || this.snake.offBoard() ||
            this.snake.eatDeathApple());
  };

  Board.prototype.contents = function (pos) {
    if (this.snake.includesPos(pos)) {
      return "snake";
    } else if (this.isApple(pos)) {
      return "apple";
    } else if (this.isDeathApple(pos)) {
      return "death-apple";
    } else {
      return "unoccupied";
    };
  }

  Board.prototype.newApple = function () {
    this.apples.push(new Game.Coord(this.randomPosition()));
  }

  Board.prototype.randomPosition = function () {
    while (true) {
      var x = Math.floor(Math.random() * this.size[0]);
      var y = Math.floor(Math.random() * this.size[1]);
      if (this.emptyPos([x, y])) {
        return [x, y];
      }
    }
  }

    Board.prototype.isApple = function (position) {
    return Game.Coord.coordArrIncludes(this.apples, position)
  }

  Board.prototype.isDeathApple = function (position) {
    return Game.Coord.coordArrIncludes(this.deathApples, position)
  }

  Board.prototype.spawnApple = function () {
    this.apples.push(new Game.Coord(this.randomPosition()));
  }

  Board.prototype.spawnDeathApple = function () {
    this.deathApples.push(new Game.Coord(this.randomPosition()));
  }


})();
