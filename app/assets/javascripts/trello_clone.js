"use strict";

window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var collection = new TrelloClone.Collections.Boards();
    collection.fetch();
    new TrelloClone.Routers.Router(collection, $('body'));
    Backbone.history.start();
  }
};
