"use strict";

window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
  var collection = new TrelloClone.Collections.Boards();
    new TrelloClone.Routers.Router(collection, $('body'));
    Backbone.history.start();
  }
};
