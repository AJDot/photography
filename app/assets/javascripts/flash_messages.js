$(document).on('turbolinks:load', function() {
  function removeAlert(alert) {
    alert.slideUp();
  }

  $('.alert').on('click', '[data-dismiss="alert"]', function() {
    removeAlert($(this).closest('.alert'));
  })
});
