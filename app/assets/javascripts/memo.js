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

  $('select[name=aircraft_registry_id]').on('change', function(){
    memo_filter();
  });

  $('select[name=user_department_id]').on('change', function(){
    memo_filter();
  });

  $('#created_date').on('change', function(){
    memo_filter();
  });

  $(".btn-memo-info").on('click', function(){
    var id = $(this).data('id');
    $.get('admin/memo-info', { id: id })
    .done(function(result){
      $(".panel-body.memo-info").html(result);
    });
  });

});

function memo_filter() {
  var ac_id = $('select[name=aircraft_registry_id]').val();
  var dept_id = $('select[name=user_department_id]').val();
  var created_date = $('#created_date').val();

  $.get('admin/memo-filters', { ac_id: ac_id, dept_id: dept_id, created_date: created_date })
    .done(function(result){
      $(".panel-body.memo-lists").html(result);
    });
}
