$(document).ready(function(){
  disable_options();

  $("#category-options, #advisory-category-fields, #reason-options, #remark-options").select2({ theme: 'bootstrap' });

  $("input[name=category-options]").on('change', function(){
    check_options('category-options', $(this).val());
  });

  $("input[name=reason-options]").on('change', function(){
    check_options('reason-options', $(this).val());
  });

  $("input[name=remark-options]").on('change', function(){
    check_options('remark-options', $(this).val());
  });
});

function check_options(str, val) {
  if (val == 'yes') {
    $("#" + str).removeAttr('disabled');
    $("#" + str + "-panel").show();
  } else {
    $("#" + str).attr('disabled', 'disabled');
    $("#" + str + "-panel").hide();
  }
  $("#" + str).select2({ theme: 'bootstrap' });
}

function disable_options() {
  if ($("input[name=category-options]:checked").val() == 'no'){
    $("#category-options-panel").hide();
    $("#category-options").attr('disabled', 'disabled');
  }
  // $("input[name=category-options]").filter('[value="no"]').attr('checked', true);

  if ($("input[name=reason-options]:checked").val() == 'no'){
    $("#reason-options-panel").hide();
    $("#reason-options").attr('disabled', 'disabled');
  }
  // $("input[name=reason-options]").filter('[value="no"]').attr('checked', true);

  if ($("input[name=remark-options]:checked").val() == 'no'){
    $("#remark-options-panel").hide();
    $("#remark-options").attr('disabled', 'disabled');
  }
  // $("input[name=remark-options]").filter('[value="no"]').attr('checked', true);
}
