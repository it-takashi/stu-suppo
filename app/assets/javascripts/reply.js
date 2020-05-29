$(function(){
  function buildHTML(reply) {
    if ( reply.image ){
      var html = 
      `<div class='reply-list__box', data-reply-id=${reply.id}>
      <div class='reply-list__box__comment-info'>
      <div class='reply-list__box__comment-info__name'>
      ${reply.user_name}
      </div>
      <div class='reply-list__box__comment-info__day'>
      ${reply.created_at}
      </div>
      </div>
      <div class='reply-list__box__comment'>
      <p>${reply.comment}</p>
      <img class="lower-reply__image" src=${reply.image} >
      </div>
      </div>`
      return html;
    }else {
      var html = 
      `<div class='reply-list__box', data-reply-id=${reply.id}>
      <div class='reply-list__box__comment-info'>
      <div class='reply-list__box__comment-info__name'>
      ${reply.user_name}
      </div>
      <div class='reply-list__box__comment-info__day'>
      ${reply.created_at}
      </div>
      </div>
      <div class='reply-list__box__comment'>
      <p>${reply.comment}</p>
      </div>
      </div>`
      return html;
    }
  }
  
  $('#new_reply').on('submit', function(e){
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
      $('.reply-list').append(html);
      $('.reply-list').animate({ scrollTop: $('.reply-list')[0].scrollHeight});
    })

    .fail(function(){
      alert("メッセージ送信に失敗しました")
    })

    .always(function() {
      $('.form__submit').prop('disabled', false);
      $('#new_reply')[0].reset();
    });
   
    
  })
});