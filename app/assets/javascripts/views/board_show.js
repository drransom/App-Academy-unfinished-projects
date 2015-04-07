"use strict";

TrelloClone.Views.BoardShow = Backbone.View.extend ({
  template: JST['board_show'],
  class: 'content',

  initialize: function (options) {
    this.listenTo(this.model, 'sync', this.render);
  },

  events: {
    'click button' : 'delete'
  },

  render: function () {
    var listObjects = this.model.get('lists');
    var lists = new TrelloClone.Collections.Lists();
    if (listObjects) {
      for (var i = 0; i < listObjects.length; i++) {
        var listData = listObjects[i];
        var listItem = new TrelloClone.Models.List();
        listItem.set(listData);
        lists.add(listItem);
      }
    }
    this.$el.html(this.template({ boards: this.collection,
                                  board: this.model,
                                  lists: lists
                                }));
    this.$el.addClass('board-background')
    return this;
  },

  delete: function () {
    this.model.destroy();
    Backbone.history.navigate('', { trigger: true })
  }
});
