/* globals App */
/* globals RealNotification */

App.web_notifications = App.cable.subscriptions.create("WebNotificationsChannel", {
  connected: function() {
    console.log('Notification Channel connected.');
  },

  disconnected: function() {
    console.log('Notification Channel disconnected.');
  },

  received: function(data) {
    // console.log(data);
    // var notification = new RealNotification({
    //   delay: 7000, // default hide notification delay is 6000
    //   position: 'bottom-right' // default position is top-right see available options below
    // });
    // notification.show(data);
    var html = '<div class="alert alert-success alert-dismissible fade in notif-alert" id="real-notification" data-notification="real-notification">'
            + '<button class="close" data-dismiss="alert" aria-label="close">&times;</button>'
            + '<a href="/admin/advisory/review-advisory/'+ data.sid +'">'
            + '<strong id="title">New Advisory&emsp;</strong>'
            + '<span id="message">'+ data.message +'</span></a></div>';
    var id = $('.notification-panel').data('id');
    if (data.ids.includes(id)){
      var cnt = $('#inbox-count').data('count') + 1;
      $('#inbox-count').data('count', cnt);
      $('#inbox-count').html('( '+ cnt +' )');

      var index = $('.notif-alert').length;
      $('.notification-panel').append(html);
      $('.notif-alert:eq('+index+')').show()
                                    .delay(6000)
                                    .fadeOut();

      if ($("#inbox-lists").length) {
        var arrow = '';
        var clr = '';
        switch (data.priority) {
          case 3:
            arrow = 'up';
            color = '#d20000';
            break;
          case 2:
            arrow = 'up';
            color = '#eb7f00';
            break;
          default:
            arrow = 'down';
            color = '#3fb358';
            break;
        }
        var row = '<div class="row new">'
                + '<span class="glyphicon glyphicon-arrow-'+arrow+'" style="margin-right: 9px; color: '+color+'"></span>'
                + '<span class="glyphicon glyphicon-folder-close" style="margin-right: 9px"></span>'
                + '<label>'+ data.message +'</label>'
                + '<label class="pull-right">' + data.date_send
                + '<button type="button" class="btn-link" onclick="adv_info(\''+ data.sid +'\')">'
                + '<span class="glyphicon glyphicon-chevron-right"></span>'
                + '</button></label></div>';
        $("#inbox-lists").prepend(row);
      }
    }
  }
});

/*

  Available positions options are:

  top : notification will be placed in middle top of screen.

  top-left : notification will be placed in top left corner of screen.

  top-right : notification will be placed in top left corner of screen.

  bottom : notification will be placed in middle bottom of screen.

  bottom-left : notification will be placed in bottom left corner of screen.

  bottom-right : notification will be placed in bottom right corner of screen.

*/
