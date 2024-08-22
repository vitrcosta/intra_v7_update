// require jquery
// require jquery_ujs
// require turbolinks
// require jquery-readyselector
// require bootstrap-datepicker
//= require vendors/moment/min/moment.min

// require ckeditor/init

//= require vendors/jquery/dist/jquery.min
//= require vendors/bootstrap/dist/js/bootstrap.min
//= require vendors/fastclick/lib/fastclick
//= require vendors/nprogress/nprogress
//= require vendors/ion.rangeSlider/js/ion.rangeSlider.min
//= require vendors/mjolnic-bootstrap-colorpicker/dist/js/bootstrap-colorpicker.min
//= require vendors/jquery.inputmask/dist/min/jquery.inputmask.bundle.min
//= require vendors/jquery-knob/dist/jquery.knob.min
//= require vendors/cropper/dist/cropper
// require vendors/cropper/dist/init_cropper
// require cropper
//= require vendors/validator/validator
//= require vendors/Chart.js/dist/Chart.min
//= require vendors/gauge.js/dist/gauge.min
//= require vendors/bootstrap-progressbar/bootstrap-progressbar.min
//= require vendors/iCheck/icheck.min
//= require vendors/skycons/skycons
//= require vendors/Flot/jquery.flot
//= require vendors/Flot/jquery.flot.pie
//= require vendors/Flot/jquery.flot.time
//= require vendors/Flot/jquery.flot.stack
//= require vendors/Flot/jquery.flot.resize
//= require vendors/flot.orderbars/js/jquery.flot.orderBars
//= require vendors/flot-spline/js/jquery.flot.spline.min
//= require vendors/flot.curvedlines/curvedLines
//= require vendors/DateJS/build/date
//= require vendors/jqvmap/dist/jquery.vmap
//= require vendors/jqvmap/dist/maps/jquery.vmap.world
//= require vendors/jqvmap/examples/js/jquery.vmap.sampledata
//= require vendors/bootstrap-daterangepicker/daterangepicker

//= require vendors/datatables_test/jquery.dataTables
// require vendors/datatables.net/js/jquery.dataTables
// require vendors/datatables.net-bs/js/dataTables.bootstrap.min
// require vendors/datatables.net-buttons/js/dataTables.buttons.min
// require vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min
// require vendors/datatables.net-buttons/js/buttons.flash.min
// require vendors/datatables.net-buttons/js/buttons.html5.min
// require vendors/datatables.net-buttons/js/buttons.print.min
// require vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min
// require vendors/datatables.net-keytable/js/dataTables.keyTable.min
// require vendors/datatables.net-responsive/js/dataTables.responsive.min
// require vendors/datatables.net-responsive-bs/js/responsive.bootstrap
// require vendors/datatables.net-scroller/js/dataTables.scroller.min
//= require vendors/jszip/dist/jszip.min
//= require vendors/pdfmake/build/pdfmake.min
//= require vendors/pdfmake/build/vfs_fonts
//= require vendors/bootstrap-wysiwyg/js/bootstrap-wysiwyg.min
//= require vendors/jquery.hotkeys/jquery.hotkeys
//= require vendors/google-code-prettify/src/prettify
//= require vendors/jquery.tagsinput/src/jquery.tagsinput
//= require vendors/switchery/dist/switchery.min
//= require vendors/select2/dist/js/select2.full.min
//= require vendors/parsleyjs/dist/parsley
// require vendors/parsleyjs/dist/parsley_init
//= require vendors/autosize/dist/autosize.min
//= require vendors/devbridge-autocomplete/dist/jquery.autocomplete.min
//= require vendors/starrr/dist/starrr

// require build/js/custom
//= require our_intranet_script
//= require jquery.validate
// require embed-api/components/view-selector2.js
// require embed-api/components/date-range-selector.js
// require embed-api/components/active-users.js

//= require jquery.block
//= require jquery.canvasjs.min
//= require html2canvas.min.js

$("#delete-confirm").on("show", function () {
  var $submit = $(this).find(".btn-danger"),
    href = $submit.attr("href");
  $submit.attr("href", href.replace("pony", $(this).data("id")));
});

$(".delete-confirm").click(function (e) {
  e.preventDefault();
  $("#delete-confirm").data("id", $(this).data("id")).modal("show");
});

$(function () {
  $(document).on("change", ".field_galeria", function () {
    var num_blocks = 1000 + $(".conta_quantos_botao_file").length;
    var text_file_galeria_size = $(".text_file_galeria").length;
    for (var i = 0; i < text_file_galeria_size; i++) {
      var flag = false;
      var valor_input_text = $(".text_file_galeria")[i].value;
      if (valor_input_text == "Nenhum arquivo selecionado") {
        flag = true;
      }
    }
    if (flag) {
      $(".append_input_group").last().remove();
    }
    $(".append_imagens2").append(
      "" +
        '<div class="input-group append_input_group">' +
        '<label class="input-group-btn" title="Importar imagem">' +
        '<span class="btn btn-primary">Arquivo… <input class="fileupload campos_intranet field_galeria" style="display: none;" onchange="galeria_change_file_append(this,' +
        num_blocks +
        ')" type="file" name="post[galleries_attributes][' +
        num_blocks +
        '][image]" id="post_galleries_attributes_' +
        num_blocks +
        '_image"><div class="conta_quantos_botao_file"></div></span></label><input type="text" name="galeria_text-file-' +
        num_blocks +
        '" class="form-control text_file_galeria" value="Nenhum arquivo selecionado" readonly=""></div>'
    );
  });
});

function galeria_change_file_append(field, num_blocks) {
  var text_name = "galeria_text-file-" + num_blocks;
  document.getElementsByName(text_name)[0].value = field.value
    .replace(/\\/g, "/")
    .replace(/.*\//, "");
}
