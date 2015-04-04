"use strict";

TrelloClone.Views.NewBoard = Backbone.View.extend({
  template: JST['new_board'],
  errorTemplate: JST['errors'],
  tagName: 'section',
  className: 'new-post',

  events: {
    'click button.new-board' : 'newBoardForm',
    'submit' : 'createBoard'
  },

  render: function () {
    this.createButton();
    return this;
  },

  newBoardForm: function (event) {
    event.preventDefault();
    this.$el.empty();
    var content = this.template();
    this.$el.append(content);
  },

  createBoard: function (event) {
    event.preventDefault();
    var board_data = $('form.new-board').serializeJSON();
    var newBoard = new TrelloClone.Models.Board(board_data);
    newBoard.save({}, {
      success: function () {
        this.collection.add(newBoard);
      }.bind(this),
      error: function (model, response) {
        debugger;
        this.newBoardForm(event);
        var formArea = $('form.new-board');
        var errors = _.filter(response.responseText.split(/\[|]|"|,/),
          function (elem) { return elem }
        );
        var errForm = this.errorTemplate({ errors: errors });
        formArea.prepend(response)
      }.bind(this)
    });
    this.createButton();
  },

  createButton: function () {
    $('section.new-post').empty();
    this.$el.append($("<button class=new-board>Create a new board</button>"));
  }
})
