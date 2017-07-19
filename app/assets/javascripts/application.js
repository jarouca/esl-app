// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
$(document).ready(function() {
  $('.edit_word').on("submit", function(event) {
    event.preventDefault();

    $.ajax({
      method: "PUT",
      url: "/api/v1/words/:id",
      data: $(".edit_word").serialize()
    })
  });

  $('#new_word').on("submit", function(event) {
    event.preventDefault();

    $.ajax({
      method: "GET",
      url: "/api/v1/words",
      data: $("#new_word").serialize()
    })
  });

  $('#select-word-form').on("submit", '#select_word', function(event) {
    event.preventDefault();

    $.ajax({
      method: "POST",
      url: "/api/v1/words",
      data: {
        bank_id: $('#word_bank_id').val(),
        word: $("input[name='word']:checked"). val()
      }
    })
  });

});
