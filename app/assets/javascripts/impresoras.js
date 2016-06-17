$(document).on('page:change', function(){
$(".alert").delay(2000).slideUp(500, function(){
      $(".alert").alert('close');
  });
});