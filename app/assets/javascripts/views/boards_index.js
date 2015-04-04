"use strict";

TrelloClone.Views.BoardsIndex = Backbone.View.extend ({
  template: JST['board_index'],

  initialize: function (options) {
    this.listenTo(this.collection, 'sync add', this.render);
    this.$el = (options.$el);
  },

  render: function () {
    $('section.index').empty();
    var $section = $('<section></section>').addClass('index')
    $section.append(this.template({ boards: this.collection }));
    var boardForm = new TrelloClone.Views.NewBoard({ collection: this.collection });
    $section.append(boardForm.render().$el);
    this.$el.append($section);
    return this;
  }

});
