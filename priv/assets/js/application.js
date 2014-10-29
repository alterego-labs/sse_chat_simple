$(document).ready(function() {
  var es = new EventSource('/stream');
  es.onmessage = function(e) {
    var data = JSON.parse(e.data);
    str = "<span><b>" + data.username + "</b></span><span style='font-size: 14px;'><i>(" + data.datetime + ")</i></span>:<span style='margin-left: 5px;'>" + data.message + "</span>";
    $('#chat').append(str + "<br>")
  };

  // writing
  $("form").on('submit',function(e) {
    $.get('/push_message', {
      login: $('#login').val(),
      message: $('#message').val()
    });
    $('#message').val('');
    $('#message').focus();
    //e.preventDefault();
    return false;
  });
});
