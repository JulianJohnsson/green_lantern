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
//= require abraham
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
//= require serviceworker-companion


$(document).ready(function(){
  // Turn on js-selectable class so that it becomes SELCT 2 tag
  $('select#score_country_id').select2({
    allowClear: true,
    width: 250,
    theme: "bootstrap"
  });
  $('#score_country_id').change(function(){
    $(this).parents('form').submit();
  });
});

$(document).ready(function(){
  // Turn on js-selectable class so that it becomes SELCT 2 tag
  $('select#gift_country_id').select2({
    allowClear: true,
    width: 250,
    theme: "bootstrap"
  });
  $('#gift_country_id').change(function(){
    $(this).parents('form').submit();
  });
});

$(document).ready(function(){
  setTimeout(function(){
    $('.alert').fadeOut();
    }, 3000);
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

// Register the serviceWorker script at /serviceworker.js from our server if supported
if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/serviceworker.js')
  .then(function(reg) {
    console.log('Service worker change, registered the service worker');
  });
}
// Otherwise, no push notifications :(
else {
  console.error('Service worker is not supported in this browser');
}

navigator.serviceWorker.ready.then((serviceWorkerRegistration) => {
  serviceWorkerRegistration.pushManager
  .subscribe({
    userVisibleOnly: true,
    applicationServerKey: window.vapidPublicKey
  });
});
