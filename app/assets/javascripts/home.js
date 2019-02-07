$(document).ready(function(){
  $("#btn-reset-password").on('click', function(){
    $('.cs-loader').show();
    $.get('/admin/reset-password?id=' + $(this).data('id'))
      .done(function(result){
        if (result == 'valid') {
          alert("Successfully reset password.");
        } else {
          alert("There was problem resetting the password.");
        }
        $('.cs-loader').hide();
      });
  });
});
