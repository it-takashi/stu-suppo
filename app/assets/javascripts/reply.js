$(function(){

  function buildHTML(reply) {
    if ( reply.user_image && reply.image){
      var html = 
        `<div class='reply-list__box', data-reply-id=${reply.id}>
          <div class='comment-author'>
            <a href="/users/${reply.user_id}" class= "link-image">
              <p><img src=${reply.user_image} class="author__image"></p>
            </a>
            <a href="/users/${reply.user_id}" class= "author__name">
              ${reply.user_name}
            </a>
            <p class="reply-list__box__comment">${reply.comment}</p>
            <img class="lower-reply__image" src=${reply.image} >
            <div class= "author__created_at">
            ${reply.created_at}
            </div>
          </div> 
        </div>`
      return html
    } 
    // ユーザー写真があり、メッセージに画像がない
    else if ( reply.user_image){
      var html = 
        `<div class='reply-list__box', data-reply-id=${reply.id}>
          <div class='comment-author'>
            <a href="/users/${reply.user_id}" class= "link-image">
              <p><img src=${reply.user_image} class="author__image"></p>
            </a>
            <a href="/users/${reply.user_id}" class= "author__name">
              ${reply.user_name}
            </a>
            <p class="reply-list__box__comment">${reply.comment}</p>
            <div class= "author__created_at">
            ${reply.created_at}
            </div>
          </div>
        </div>`
      return html
    }
    // ユーザー画像がなし、メッセージが画像
    else if (reply.image){
      var html =
        `<div class='reply-list__box', data-reply-id=${reply.id}>
          <div class='comment-author'>
            <a href="/users/${reply.user_id}" class= "link-image">
              <p><img src="/no-image.png" class="author__image"></p>
            </a>
            <a href="/users/${reply.user_id}" class= "author__name">
              ${reply.user_name}
            </a>
            <p class="reply-list__box__comment">${reply.comment}</p>
            <img class="lower-reply__image" src=${reply.image} >
            <div class= "author__created_at">
            ${reply.created_at}
            </div>
          </div>
        </div>`
        return html
    }
    // ユーザー画像がなし、メッセージが画像なし
    else{
      var html =
        `<div class='reply-list__box', data-reply-id=${reply.id}>
          <div class='comment-author'>
            <a href="/users/${reply.user_id}" class= "link-image">
              <p><img src="/no-image.png" class="author__image"></p>
            </a>
            <a href="/users/${reply.user_id}" class= "author__name">
              ${reply.user_name}
            </a>
            <p class="reply-list__box__comment">${reply.comment}</p>
            <div class= "author__created_at">
            ${reply.created_at}
            </div>
          </div>
        </div>`
      return html
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