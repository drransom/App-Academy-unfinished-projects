"use strict"

TrelloClone.Routers.Router = Backbone.Router.extend({

  initialize: function (boards, $rootEl) {
    this.boards = boards;
    this.$rootEl = $rootEl;
    this.$content = this.initializeContent();
  },

  routes: {
    '': 'index',
    'api/boards/:id' : 'show'
  },

  index: function () {
    // console.log('in the index');
    this.boards.fetch();
    var view = new TrelloClone.Views.BoardsIndex({
      collection: this.boards
    });
    this._swapContentView(view);
  },

  show: function (id) {
    var model, showView;
    model = this.getOrFetch(id, this.boards);
    showView = new TrelloClone.Views.BoardShow(
      {model: model, collection: this.boards});
    this._swapContentView(showView)
  },

  _swapContentView: function (view) {
    this._currentContent = this._currentContent || false;
    this._swapViews(view, this.$content, this._currentContent);
  },

  _swapViews: function (view, area, currentView) {
    currentView && currentView.remove();
    area.html(view.render().$el);
    currentView = view;
  },

  initializeContent: function () {
    this.$rootEl.append("<section class = 'content'></section>");
    return $('section.content');
  },

  getOrFetch: function (id, collection) {
    var model = collection.get(id);
    if (model) {
      model.fetch();
    } else {
      model = new collection.model ( { id: id });
      model.fetch({
        success: function (model, response) {
          collection.add(model, {merge: true})
        }
      });
    }
    return model;
  }
});
