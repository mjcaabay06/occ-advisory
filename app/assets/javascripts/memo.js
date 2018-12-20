$(document).ready(function(){
  $('.has-datetime-picker').datetimepicker();
  $('.has-time-picker').datetimepicker({
    format: 'LT'
  });

  $('#btn-memo-submit').on('click', function(){
    $("#modal-insert-password").modal('show');
  });

  $("#btn-check-password").on('click', function(){
    var password = $('input[name=check-password]').val();
    $('.cs-loader').show();
    $.get('/admin/memo/check-account?password=' + password)
      .done(function(result){
        if (result == 'valid') {
          $("#new_memo").submit();
        } else {
          alert('You have entered invalid password.');
        }
        $('.cs-loader').hide();
      });
  });
});