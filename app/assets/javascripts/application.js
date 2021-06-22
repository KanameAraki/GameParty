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
//= require bootstrap-sprockets

//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require data-confirm-modal



// コメントアイコン押下でコメントフォームが出現・消失
$(document).on('turbolinks:load', function() {
  $('.comment-icon ').on('click', function(){
    $(this).parent().find(".comment-form").toggleClass("d-none");
  });
});

// ヘッダーホバーで吹き出し出現
$(document).on('turbolinks:load', function() {
  $('[data-toggle="tooltip"]').tooltip()
})

// チャットページのスクロールで最下部を表示
$(document).on('turbolinks:load', function() {
  if(document.URL.match(/chats/)){
    var obj = $("#target");
    $(obj).scrollTop(obj.get(0).scrollHeight);
  }
})
