$.TweetCompose = function(el){
  this.$el = $(el);
  this.submitHandler();
  this.contentHandler();
  this.mentionHandler();
};

$.TweetCompose.prototype.submitHandler = function(){
  this.$el.on("submit", function (event) {
    event.preventDefault();
    var $currentTarget = $(event.currentTarget);
    var formData = $currentTarget.serializeJSON();
    this.$el.find(":input").attr('disabled', 'disabled');
    $.ajax({
      url: "/tweets",
      data: formData,
      type: "POST",
      dataType: "json",
      success: this.handleSuccess.bind(this)
    });
  }.bind(this));
};

$.TweetCompose.prototype.contentHandler = function () {
  this.$el.find('textarea').on('input', function (event) {
    var $currentTarget = $(event.currentTarget);
    var charsLeft = 140 - $currentTarget.val().length;
    $('.chars-left').text(charsLeft + " characters remaining.");
  });
};

$.TweetCompose.prototype.mentionHandler = function () {
  this.$el.find('.add-mention-user').on("click",function(){
    var html = this.$el.find('script').html();
    this.$el.find('.mentioned-users').append(html);
  }.bind(this));
  this.$el.on("click",".remove-mentioned-user", function(event){
    var $currentTarget = $(event.currentTarget);
    $currentTarget.parent().remove();

  });

};

$.TweetCompose.prototype.handleSuccess = function (response) {
  this.clearInput();
  this.$el.find(":input").removeAttr('disabled');
  var $tweetList = $('#feed');
  var $li = $('<li></li>').html(response.content);
  $tweetList.prepend($li);
  $('.chars-left').text(140 + " characters remaining.");

  console.log("success");
};

$.TweetCompose.prototype.clearInput = function () {
  this.$el.find(":input").val("");
  this.$el.find(".mentioned-users").empty();
  this.$el.find(".tweet-button").val("Post Tweet!");
};

$.fn.tweetCompose = function(){
  this.each(function() {
    new $.TweetCompose(this);
  });
};

$(function(){
  $('.tweet-compose').tweetCompose();
});
