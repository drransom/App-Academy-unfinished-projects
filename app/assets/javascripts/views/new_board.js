"use strict";

TrelloClone.Views.NewBoard = Backbone.View.extend({
  template: JST['new_board'],
  errorTemplate: JST['errors'],
  className: 'new-post',

  events: {
    'click .new-board' : 'newBoardForm',
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
    debugger
    event.preventDefault();
    var board_data = $('form.new-board').serializeJSON();
    var newBoard = new TrelloClone.Models.Board(board_data);
    newBoard.save({}, {
      success: function () {
        this.collection.add(newBoard);
        Backbone.history.navigate('/boards/' + newBoard.id, { trigger: true })
      }.bind(this),
      error: function (model, response) {
        this.newBoardForm(event);
        var formArea = $('form.new-board');
        var errors = _.filter(response.responseText.split(/\[|]|"|,/),
          function (elem) { return elem }
        );
        var errForm = this.errorTemplate({ errors: errors });
        formArea.prepend(errForm)
      }.bind(this)
    });
    this.createButton();
  },

  createButton: function () {
    // this.$el.empty();
    this.$el.append($("<div class='col-md-3'>" +
      "<a class='btn btn-xlarge btn-block new-board'>New Board" +
      "</a></div>"));
  }
})
