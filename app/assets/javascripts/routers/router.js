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
      collection: this.boards
    });
    this._swapViews(view);
  },

  _swapViews: function (view) {
    this._currentView && this._currentView.remove();
    this.$rootEl.html(view.render().$el);
    this._currentView = view;
  }
});
