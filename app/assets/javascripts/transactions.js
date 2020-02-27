$(document).ready(function(){
  // Turn on js-selectable class so that it becomes SELCT 2 tag
  var $eventSelect=$('select#transaction_category_id').select2({
    allowClear: true,
    width: 220,
    theme: "bootstrap"
  });
  $eventSelect.on("select2:select", function() {
    form = this.form;
    Rails.fire(form, 'submit');
  });

});
