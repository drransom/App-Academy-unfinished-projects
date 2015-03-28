$.FollowToggle = function (el, options) {
  this.$button = $(el);
  this.userId = this.$button.data("user-id") || options.userId;
  this.followState = this.$button.data("initial-follow-state") || options.followState;
  this.render();
  this.handleClick();
};

$.FollowToggle.prototype.render = function () {
  if(this.followState === "followed"){
    this.$button.html("Unfollow!");
  } else {
    this.$button.html("Follow!");
  }
};

$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this,options);
  });
};

$.FollowToggle.prototype.handleClick = function () {
  this.$button.on('click', function (event) {
    event.preventDefault();
    this.followState = (this.followState === "followed") ? "unfollowed" : "followed";
    var method = (this.followState === "followed") ? "POST" : "DELETE";
    $.ajax({
      url: '/users/' + this.userId + '/follow.json',
      type: method,
      success: function(response){
        console.log("success");
        this.render();
      }.bind(this)
    });
  }.bind(this));
};

$(function () {
  $(".follow-toggle").followToggle();
});
