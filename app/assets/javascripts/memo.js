$(document).ready(function(){
  init();
  select_category($("#select-category"));
  select_advisory_category($("#select-adv-category"));

  // var submit_form = false;
  // $("#new_memo").submit(function(e){
  //   if (submit_form){
  //     return;
  //   } else {
  //     $("#modal-insert-password").modal('show');
  //     e.preventDefault();
  //   }
  // });
  $("#btn-send").on('click', function(){
    $("#modal-insert-password").modal('show');
  });

  $("#btn-forward").on('click', function(){
    $("#modal-forward").modal('show');
  });

  $("#modal-forward").on('shown.bs.modal', function(){
    $("#modal-ok").hide();
    $("#modal-error").hide();
    $("#recipient-select-forward").select2({ theme: 'bootstrap' });
  });

  $("#btn-check-forward").on('click', function(){
    var dept_ids = $("#recipient-select-forward").val();
    var advisory_id = $(this).data('id');
    $('.cs-loader').show();
    $.get('/admin/advisory/forward', { dept_ids: dept_ids, advisory_id: advisory_id })
      .done(function(result){
        if (result == 'ok') {
          $("#modal-ok").show();
          $("#modal-forward").modal('hide');
        } else {
          $("#modal-error").show();
        }
        $('.cs-loader').hide();
      });
  });

  $("#btn-check-password").on('click', function(){
    var password = $('input[name=check-password]').val();
    var type = $(this).data('id');

    $('.cs-loader').show();
    $.get('/admin/check-account?password=' + password)
      .done(function(result){
        if (result == 'valid') {
          var sid = $('input[name=hidden-sid]').val();
          var priority = $('select[name=priority]').val()
          window.location.href = '/admin/advisory/send-advisory/' + sid + '?priority=' + priority;
        } else {
          alert('You have entered invalid password.');
        }
        $('.cs-loader').hide();
      });
  });

  // $('select[name=aircraft_registry_id]').on('change', function(){
  //   memo_filter();
  // });

  $('select[name=user_department_id]').on('change', function(){
    advisory_filter();
  });

  $('#flight_date').on('change', function(){
    advisory_filter();
  });

  $("#tb-search").on('keyup', function(){
    advisory_filter();
  });

  $('#tb-ac_registry').on('keyup', function(){
    advisory_filter();
  });

  $('#tb-flight_number').on('keyup', function(){
    advisory_filter();
  });

  $("#recipient-select, #incoordinate-select, #reason-select, #remarks-select, .frequency-select").select2({
    theme: 'bootstrap'
  });

  $("#remarks-select").on('change', function(){
    var sel = $(this).val();
    console.log(sel);
    if (sel) {
      if (sel.includes('34')) {
        $("#other-remarks").show();
        $("#other-remarks").find('input').removeAttr('disabled');
      } else {
        $("#other-remarks").hide();
        $("#other-remarks").find('input').attr('disabled', 'disabled');
      }
    } else {
      $("#other-remarks").hide();
      $("#other-remarks").find('input').attr('disabled', 'disabled');
    }
  });

  $('#created-flight-date').on('change', function(){
    created_filter();
  });

  $("#tb-created-search").on('keyup', function(){
    created_filter();
  });

  $("#created-ac_registry").on('keyup', function(){
    created_filter();
  });

  $("#created-flight_number").on('keyup', function(){
    created_filter();
  });

});

function init() {
  $('.has-datetime-picker').datetimepicker({
    format: 'YYYY-MM-DD HH:mm'
  });
  $('.has-time-picker').datetimepicker({
    format: 'HH:mm'
  });
  $('.has-date-picker').datetimepicker({
    format: 'YYYY-MM-DD'
  });
}

function advisory_filter() {
  var dept_id = $('select[name=user_department_id]').val();
  var flight_date = $('#flight_date').val();
  var txt = $("#tb-search").val();
  var ac_registry = $("#tb-ac_registry").val();
  var flight_number = $("#tb-flight_number").val();
  $.get('/admin/advisory/filter', { dept_id: dept_id, flight_date: flight_date, val: txt, ac_registry: ac_registry, flight_number: flight_number })
    .done(function(result){
      $(".panel-body.memo-lists").html(result);
    });
}

function created_filter(){
  var flight_date = $('#created-flight-date').val();
  var txt = $("#tb-created-search").val();
  var ac_registry = $("#created-ac_registry").val();
  var flight_number = $("#created-flight_number").val();
  $.get('/admin/advisory/created-filter', { flight_date: flight_date, val: txt, ac_registry: ac_registry, flight_number: flight_number })
    .done(function(result){
      $(".panel-body.memo-lists").html(result);
    });
}

function adv_info(sid){
  window.location.href = '/admin/advisory/review-advisory/' + sid;
}

function select_category(id) {
  var val = $(id).val();
  var id = $(id).closest('.panel-body').data('id');

  if (id) {
    $('#additional-category' + id).find(".div-category").addClass('hidden');
    disable_fields($('#additional-category' + id).find(".div-category"));
    $('#additional-category' + id).find("#category-" + val).removeClass('hidden');
    enable_fields($('#additional-category' + id).find("#category-" + val));
  } else {
    $('#main-category').find(".div-category").addClass('hidden');
    disable_fields($('#main-category').find(".div-category"));
    $('#main-category').find("#category-" + val).removeClass('hidden');
    enable_fields($('#main-category').find("#category-" + val));
  }
  $(".frequency-select").select2({
    theme: 'bootstrap'
  });
}

function select_advisory_category(elem) {
  console.log($(elem).closest('.panel-body').data('id'));
  var val = $(elem).val();
  var id = $(elem).closest('.panel-body').data('id');
  if (id) {
    $('#additional-category' + id).find('.f').hide();
    $('#additional-category' + id).find('.f').find("input, select, textarea").attr('disabled','disabled');
    $('#additional-category' + id).find('.f.def, .f' + val).show();
    $('#additional-category' + id).find('.f.def, .f' + val).find("input, select, textarea").removeAttr('disabled');
  } else {
    $('#main-category').find('.f').hide();
    $('#main-category').find('.f').find("input, select, textarea").attr('disabled','disabled');
    if (val) {
      $('#main-category').find('.f.def, .f' + val).show();
      $('#main-category').find('.f.def, .f' + val).find("input, select, textarea").removeAttr('disabled');
    }
  }
}

function enable_fields(elem) {
  elem.find("input, select, textarea").removeAttr('disabled');
}

function disable_fields(elem) {
  elem.find("input, select, textarea").attr('disabled','disabled');
}

function flocation(elem){
  var id = $(elem).closest('.panel-body').data('id');
  var form = $('#main-category');

  if (id) {
    form = $('#additional-category' + id);
  }

  var loc1 = form.find('#loc-loc').val() ? form.find('#loc-loc').val() : '';
  var loc2 = form.find('#loc-f1').val() ? form.find('#loc-f1').val() : '';
  var loc3 = form.find('#loc-f2').val() ? form.find('#loc-f2').val() : '';
  form.find('#hidden-location').val(loc1 + ' ' + loc2 + ' ' + loc3);
}

function fmovement(elem){
  var id = $(elem).closest('.panel-body').data('id');
  var form = $('#main-category');

  if (id) {
    form = $('#additional-category' + id);
  }

  var loc1 = form.find('#mvnt-loc').val() ? form.find('#mvnt-loc').val() : '';
  var loc2 = form.find('#mvnt-f1').val() ? form.find('#mvnt-f1').val() : '';
  form.find('#hidden-movement').val(loc1 + ' ' + loc2);
}

function fmaxwnd(elem){
  var id = $(elem).closest('.panel-body').data('id');
  var form = $('#main-category');

  if (id) {
    form = $('#additional-category' + id);
  }

  var f1 = form.find('#mxwnd-f1').val() ? form.find('#mxwnd-f1').val() : '';
  var f2 = form.find('#mxwnd-f2').val() ? form.find('#mxwnd-f2').val() : '';
  form.find('#hidden-max-wind').val(f1 + ' ' + f2);
}
