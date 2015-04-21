"use strict";

TrelloClone.Collections.Lists = Backbone.Collection.extend({
  model: TrelloClone.Models.List,

  initialize: function (options) {
  },

  comparator: function (list) {
    return list.get('ord');
  }
})
