document.addEventListener("turbolinks:load", function () {

  // Get all "navbar-burger" elements
  var $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);

  // Check if there are any navbar burgers
  if ($navbarBurgers.length > 0) {

    // Add a click event on each of them
    $navbarBurgers.forEach(function ($el) {
      $el.addEventListener('click', function () {

        // Get the target from the "data-target" attribute
        var target = $el.dataset.target;
        var $target = document.getElementById(target);

        // Toggle the class on both the "navbar-burger" and the "navbar-menu"
        $el.classList.toggle('is-active');
        $target.classList.toggle('is-active');

      });
    });
  }

});

// clicking x closes notifications
$(document).on('click', '.notification > button.delete', function() {
    $(this).parent().addClass('is-hidden').remove();
    if ($('.flash-notif').length == 0) {
      $('#flash-notif-section').addClass('is-hidden').remove();
    }
    return false; // returning false does something
});

// clicking has-dropdown opens the menu
$(document).on('click', 'a.navbar-link', function() {
  $(this).parent().toggleClass("is-active");
  return false; // returning false does something
});

// clicking outside a navbar-dropdown closes it
// i could see this causing issues if I have multiple, so keep it in mind
$(document).click(function(event) {
    if(!$(event.target).closest('.navbar-dropdown').length) {
        if($('.navbar-dropdown').parent().hasClass('is-active')) {
            $('.navbar-dropdown').parent().removeClass('is-active');
        }
    }
});
