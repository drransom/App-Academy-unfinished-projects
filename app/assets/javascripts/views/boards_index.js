"use strict";

TrelloClone.Views.BoardsIndex = Backbone.View.extend ({
  template: JST['board_index'],
  class: 'content',

  initialize: function (options) {
    this.listenTo(this.collection, 'sync', this.render);
    this.listenTo(this.collection, 'add', this.redirect);
  },

  render: function () {
    this.$el.html(this.template({ boards: this.collection }));
    debugger
    var boardForm = new TrelloClone.Views.NewBoard({ collection: this.collection });
    $('.boards-index').append(boardForm.render().$el);
    return this;
  },


});
