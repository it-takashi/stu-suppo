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
    console.log(formData)
    
    $.ajax({
      url: url,  //同期通信でいう『パス』
      type: "POST",  //同期通信でいう『HTTPメソッド』
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
});