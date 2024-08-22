$(function() {
  // We can attach the `fileselect` event to all file inputs on the page
  $(document).on('change', ':file#inputImage', function() {
    var input = $("#inputImage");
    var fu1 = document.getElementById("inputImage");
    var label = input.value;
  });

  // We can watch for our custom `fileselect` event like this
  $(document).ready( function() {
    $(':file#inputImage').on('fileselect', function(event, numFiles, label) {
      var input = $(":file#inputImage").parents('.input-group').find(':text'),
      log = numFiles > 1 ? numFiles + ' files selected' : label;
      input.val("log log");
      if( input.length ) {
        input.val(log);
      } else {
        if( log ){
          // alert(log);
        }
      }

    });
  });

});
