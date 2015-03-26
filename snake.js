(function () {
  if(window.Game === "undefined"){
    window.Game = {};
  }

  var Snake = Game.Snake = function () {
    this.dir = [0, 1]
    this.segments = Snake.createSegments();
  };

  Snake.prototype.createSegments = function () {
    return [];
  };

  Snake.prototype.move = function () {
    var newHeadPos = this.findNewHead();
    this.createHead(newHeadPos);
    this.destroyTail();
  }

  Snake.prototype.findNewHead = function () {
    var head = this.segments[0];
    return head.plus(this.dir);
  }

  Snake.prototype.createHead = function (pos) {
    this.segments.shift(new Coord(pos));
  }

  Snake.prototype.destroyTail = function () {
    this.segments.pop;
  }

  var Coord = Game.Coord = function (pos) {
    this.xCoord = pos[0];
    this.yCoord = pos[1];
  }

  Coord.prototype.plus = function (dir) {
    return [this.xCoord + dir[0], this.xCoord + dir[0]]
  };

  Coord.prototype.move = function (dir) {
    var newPos = this.plus(dir)
    this.xCoord = newPos[0];
    this.yCoord = newPos[1];
  };

  Coord.prototype.updatePosition = function (newPos)
    this.xCoord = newPos[0];
    this.yCoord = newPos[1];
  }

})();
