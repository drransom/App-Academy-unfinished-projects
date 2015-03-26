(function () {
  if(window.Game === "undefined") {
    window.Game = {};
  }

  Board = Game.Board = function (size) {
    this.snake = new Game.Snake();
    this.apples = [];
    this.size = size;
  };


})();
