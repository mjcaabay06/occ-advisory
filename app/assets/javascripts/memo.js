$(document).ready(function(){
  $('.has-datetime-picker').datetimepicker();
  $('.has-time-picker').datetimepicker({
    format: 'LT'
  });

  var submit_form = false;
  $("#new_memo").submit(function(e){
    if (submit_form){
      return;
    } else {
      $("#modal-insert-password").modal('show');
      e.preventDefault();
    }
  });

  $("#btn-check-password").on('click', function(){
    var password = $('input[name=check-password]').val();
    $('.cs-loader').show();
    $.get('/admin/memo/check-account?password=' + password)
      .done(function(result){
        if (result == 'valid') {
          submit_form = true;
          $("#new_memo").submit();
        } else {
          alert('You have entered invalid password.');
        }
        $('.cs-loader').hide();
      });
  });

});