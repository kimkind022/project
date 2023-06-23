$(document).ready(function() {  
radioCheck();

$(document).on('click','#section770 input[type=checkbox]',function(){
  $.ajax({
    url : "pushToggle.fd",
    dataType : "html",
    data : {"push": $(this).attr('name')},
    success : function(data){
      $('#section770').html($(data).find('#section770').html());
      radioCheck();
    },
    error : function() {
      alert("fail");
    }
  });
});


});

function radioCheck(){
  let email = $('input[name=push]').attr('email');
  let sns = $('input[name=push]').attr('sns');
  let app = $('input[name=push]').attr('app');
  if ("true" == email) {
    $('input[name=email]').attr('checked','checked');
  }
  if ("true" == sns) {
    $('input[name=sns]').attr('checked','checked');
  }
  if ("true" == app) {
    $('input[name=app]').attr('checked','checked');
  }
}
