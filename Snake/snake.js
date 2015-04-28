(function () {
  if (window.Game === undefined) {
    window.Game = {};
  }

  var Snake = Game.Snake = function (board) {
    this.dir = [0, 1];
    this.segments = this.createSegments();
    this.board = board;
    this.boardSize = this.board.size;
    this.max_size = this.segments.length;
  };

  Snake.prototype.createSegments = function () {
    return [new Coord([5, 5])];
  };

  Snake.prototype.move = function () {
    var newHeadPos = this.findNewHead();
    this.createHead(newHeadPos);
    if (this.board.isApple(newHeadPos)) {
      this.grow();
    }
    if (this.segments.length > this.max_size) {
      this.destroyTail();
    }
  };

  Snake.prototype.findNewHead = function () {
    return this.head().plus(this.dir);
  };

  Snake.prototype.wrap = function (arr) {
    var x = (arr[0] + this.boardSize[0]) % this.boardSize[0];
    var y = (arr[1] + this.boardSize[1]) % this.boardSize[1];
    return [x, y]
  }

  Snake.prototype.createHead = function (pos) {
    this.segments.unshift(new Coord(pos));
  };

  Snake.prototype.destroyTail = function () {
    this.segments.pop();
  };

  Snake.prototype.includesPos = function (pos) {
    return this.segments.some(function (segment) {
      return (segment.xCoord === pos[0] && segment.yCoord === pos[1]);
    })
  };

  Snake.prototype.selfCollide = function () {
    head = this.head();
    return this.segments.slice(1).some(function (segment) {
      return (segment.xCoord === head.xCoord && segment.yCoord === head.yCoord);
    });
  };

  Snake.prototype.offBoard = function () {
    return this.head().xCoord < 0 ||
           this.head().yCoord < 0 ||
           this.head().xCoord >= this.boardSize[0] ||
           this.head().yCoord >= this.boardSize[1];
  };

  Snake.prototype.eatDeathApple = function () {
    return this.board.isDeathApple([this.head().xCoord, this.head().yCoord]);
  }

  Snake.prototype.grow = function () {
    this.max_size += 3;
  };

  Snake.prototype.head = function () {
    return this.segments[0];
  }












  var Coord = Game.Coord = function (pos) {
    this.xCoord = pos[0];
    this.yCoord = pos[1];
  };

  Coord.prototype.plus = function (dir) {
    return [this.xCoord + dir[0], this.yCoord + dir[1]];
  };

  Coord.prototype.move = function (dir) {
    var newPos = this.plus(dir);
    this.xCoord = newPos[0];
    this.yCoord = newPos[1];
  };

  Coord.prototype.updatePosition = function (newPos) {
    this.xCoord = newPos[0];
    this.yCoord = newPos[1];
  };

  Coord.coordArrIncludes = function (cordArr, pos) {
    return cordArr.some (function (element) {
      return element.xCoord === pos[0] && element.yCoord === pos[1];
    });
  }

})();
