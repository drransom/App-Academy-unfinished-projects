"use strict";

TrelloClone.Collections.Boards = Backbone.Collection.extend({
  model: TrelloClone.Models.Board,

  url: '/api/boards',

  initialize: function (options) {
  },
})
