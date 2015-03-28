$.UsersSearch = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find('input');
  this.$searchList = this.$el.find('.users');
  this.handleInput();
};

$.fn.usersSearch = function () {
  return this.each(function () {
    new $.UsersSearch(this);
  });
};

$.UsersSearch.prototype.handleInput = function() {
  this.$input.on("input", function(event){
    event.preventDefault();
    $.ajax({
      url: '/users/search',
      data: {
        query: this.$input.val()
      },
      dataType: 'json',
      type: "GET",
      success: function(response){
        console.log("success");
        this.renderResults(response);
      }.bind(this)
    });
  }.bind(this));
};

$.UsersSearch.prototype.renderResults = function(response) {
  this.$searchList.empty();
  var followedState, $user, $a, $button;
  response.forEach(function (el) {
    $user = $('<li></li>');
    $a = $('<a href="/users/' + el.id + '"></a>');
    $user.append($a);
    if(el.followed){
      followedState = "followed";
    } else {
      followedState = "unfollowed";
    }
    $button = $("<button></button>");
    $button.followToggle({"userId": el.id, "followState": followedState});
    $a.html(el.username);
    $user.append($button);
    this.$searchList.append($user);
  }.bind(this));
};

$(function () {
  $(".users-search").usersSearch();
});
