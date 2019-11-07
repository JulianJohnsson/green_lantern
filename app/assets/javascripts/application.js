// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require material/moment.min
//= require material/bootstrap-material-design.min
//= require material/bootstrap-datetimepicker
//= require material/material-kit
//= require material/nouislider.min
//= require rails-ujs
//= require bootstrap-sprockets
//= require chartkick
//= require Chart.bundle
//= require Chart.bundle.min
//= require select2
//= require_tree .

$(document).ready(function(){
  // Turn on js-selectable class so that it becomes SELCT 2 tag
  $('select#transaction_category_id').select2({
    allowClear: true,
    width: 250,
    theme: "bootstrap"
  });
});

$(document).ready(function(){
  // Turn on js-selectable class so that it becomes SELCT 2 tag
  $('select#score_country_id').select2({
    allowClear: true,
    width: 250,
    theme: "bootstrap"
  });
});

$(window).scroll(function() {
if ($("#registration-navbar").offset().top > 80) {
    $('#custom-nav').addClass('affix');
    $(".navbar-fixed-top").addClass("top-nav-collapse");
    $('.navbar-brand img').attr('src','/assets/Logo-Carbo-White.png'); //change src
} else {
    $('#custom-nav').removeClass('affix');
    $(".navbar-fixed-top").removeClass("top-nav-collapse");
    $('.navbar-brand img').attr('src','/assets/Logo-Carbo-Blue.png')
}
});

/*$(document).ready(function(){
  var slider = document.getElementById('sliderRegular');

  noUiSlider.create(slider, {
    start: 40,
    connect: [true,false],
    step: 20,
    range: {
      min: 0,
      max: 100
    },
    behaviour: 'tap-drag',
    tooltips: true,
  });

  slider.noUiSlider.on('update', function () {
    $("#preference_energy_contract").val(slider.noUiSlider.get());
  });

  slider.noUiSlider.on('update', function () {
    document.getElementById("energy_contract").innerHTML = slider.noUiSlider.get();
  });
});
*/


