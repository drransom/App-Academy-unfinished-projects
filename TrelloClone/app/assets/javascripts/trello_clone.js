"use strict";

window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},

  initialize: function() {
    var boards = new TrelloClone.Collections.Boards();
    boards.fetch();
    new TrelloClone.Routers.Router(boards, $('body'));
    Backbone.history.start();
  }
};
