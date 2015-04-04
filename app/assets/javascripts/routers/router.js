"use strict"

TrelloClone.Routers.Router = Backbone.Router.extend({

  initialize: function (boards, $rootEl) {
    this.boards = boards;
    this.$rootEl = $rootEl;
  },

  routes: {
    '': 'index'
  },

  index: function () {
    // console.log('in the index');
    this.boards.fetch();
    var view = new TrelloClone.Views.BoardsIndex({
      collection: this.boards,
      $el: this.$rootEl,
    });
    view.render();
  }
});
