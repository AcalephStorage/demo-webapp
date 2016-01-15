$(document).ready(function() {
  (function poll(){
    $.ajax({
      url: '/k8s',
      success: function(data) {
        $('#doge').slideDown('fast').delay(1500).slideUp('slow');
        $('#running-pods').html(data.pods.running);
        $('#total-pods').html(data.pods.total);
        $('#total-rcs').html(data.rcs.total);
      },
      dataType: 'json',
      complete: function() {
        setTimeout(poll, 10000);
      },
      timeout: 10000
    });
  })();
});
