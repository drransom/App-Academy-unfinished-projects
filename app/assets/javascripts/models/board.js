"use strict";

TrelloClone.Models.Board = Backbone.Model.extend ({
  url: 'api/boards',

  initialize: function (options) {
    this.title = options.title;
    this.userId = options.userId;
  }
});
