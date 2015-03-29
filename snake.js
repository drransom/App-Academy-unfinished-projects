(function () {
  if (window.Game === undefined) {
    window.Game = {};
  }

  var Snake = Game.Snake = function (boardSize) {
    this.dir = [0, 1];
    this.segments = this.createSegments();
    this.boardSize = boardSize;
  };

  Snake.prototype.createSegments = function () {
    return [new Coord([5, 5])];
  };

  Snake.prototype.move = function () {
    var newHeadPos = this.findNewHead();
    this.createHead(newHeadPos);
    this.destroyTail();
  };

  Snake.prototype.findNewHead = function () {
    var head = this.segments[0];
    return this.wrap(head.plus(this.dir));
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

  Snake.prototype.selfCollide = function (pos) {
    var head = this.segments[0];
    return this.segments.slice(1).some(function (segment) {
      return (segment.xCoord === head.xCoord && segment.yCoord === head.yCoord);
    });
  };












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

})();
