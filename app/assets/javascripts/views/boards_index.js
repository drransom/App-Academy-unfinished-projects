"use strict";

TrelloClone.Views.BoardsIndex = Backbone.View.extend ({
  template: JST['board_index'],
  class: 'content',

  initialize: function (options) {
    this.listenTo(this.collection, 'sync add', this.render);
  },

  render: function () {
    this.$el.html(this.template({ boards: this.collection }));
    var boardForm = new TrelloClone.Views.NewBoard({ collection: this.collection });
    this.$el.append(boardForm.render().$el);
    return this;
  }
});
