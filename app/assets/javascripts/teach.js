$(function(){

  function buildHTML(message) {
    if ( message.image ){
      var html = 
      `<div class='message-list__box', data-message-id=${message.id}>
      <div class='message-list__box__comment-info'>
      <div class='message-list__box__comment-info__name'>
      ${message.user_name}
      </div>
      <div class='message-list__box__comment-info__day'>
      ${message.created_at}
      </div>
      </div>
      <div class='message-list__box__comment'>
      <p>${message.comment}</p>
      <img class="lower-message__image" src=${message.image} >
      </div>
      </div>`
      return html;
    }else {
      var html = 
      `<div class='message-list__box', data-message-id=${message.id}>
      <div class='message-list__box__comment-info'>
      <div class='message-list__box__comment-info__name'>
      ${message.user_name}
      </div>
      <div class='message-list__box__comment-info__day'>
      ${message.created_at}
      </div>
      </div>
      <div class='message-list__box__comment'>
      <p>${message.comment}</p>
      </div>
      </div>`
      return html;
    }
  }
  
  $('#new_message').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    
    $.ajax({
      url: url,
      type: "POST",
      data: formData,  
      dataType: 'json',
      processData: false,
      contentType: false
    })
    
    .done(function(data){
      var html = buildHTML(data);
      $('.message-list').append(html);
      $('.message-list').animate({ scrollTop: $('.message-list')[0].scrollHeight});
      console.log('投稿完了')
    })

    .fail(function(){
      alert("メッセージ送信に失敗しました")
    })

    .always(function() {
      $('.form__submit').prop('disabled', false);
      $('#new_message')[0].reset();
    });
  })
  var reloadMessages = function() {
    var last_message_id = $('.message-list__box:last').data("message-id");
    var id = $('.teach_id').val();
    console.log(id)
    
    $.ajax({
      url: + id + "/api/messages",
      type: 'GET',
      dataType: 'json',
      data: {id: last_message_id}
    })
    .done(function(messages) {
      if (messages.length !== 0) {
        var insertHTML = '';
        $.each(messages, function(i, message) {
          insertHTML += buildHTML(message)
        });
        $('.message-list').append(insertHTML);
        $('.message-list').animate({ scrollTop: $('.message-list')[0].scrollHeight});
      }
    })
    .fail(function() {
      alert('error')
    });
  };
  if (document.location.href.match(/\/teaches\/\d+/)) {
    setInterval(reloadMessages, 7000);
  }
  
});