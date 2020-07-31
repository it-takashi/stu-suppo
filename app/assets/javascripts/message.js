$(function(){
  var url = $(this).attr('action');

  function buildHTML(message) {
    if ( message.user_image && message.image){
      var html = 
        `<div class='reply-list__box', data-message-id=${message.id}>
          <div class='comment-author'>
            <a href="/users/${message.user_id}" class= "link-image">
              <p><img src=${message.user_image} class="author__image"></p>
            </a>
            <a href="/users/${message.user_id}" class= "author__name">
              ${message.user_name}
            </a>
            <p class="reply-list__box__comment">${message.comment}</p>
            <img class="lower-reply__image" src=${message.image} >
            <div class= "author__created_at">
            ${message.created_at}
            </div>
          </div> 
        </div>`
      return html
    } 
    // ユーザー写真があり、メッセージに画像がない
    else if ( message.user_image){
      var html = 
        `<div class='reply-list__box', data-message-id=${message.id}>
          <div class='comment-author'>
            <a href="/users/${message.user_id}" class= "link-image">
              <p><img src=${message.user_image} class="author__image"></p>
            </a>
            <a href="/users/${message.user_id}" class= "author__name">
              ${message.user_name}
            </a>
            <p class="reply-list__box__comment">${message.comment}</p>
            <div class= "author__created_at">
            ${message.created_at}
            </div>
          </div>
        </div>`
      return html
    }
    // ユーザー画像がなし、メッセージが画像
    else if (message.image){
      var html =
        `<div class='reply-list__box', data-message-id=${message.id}>
          <div class='comment-author'>
            <a href="/users/${message.user_id}" class= "link-image">
              <p><img src="/no-image.png" class="author__image"></p>
            </a>
            <a href="/users/${message.user_id}" class= "author__name">
              ${message.user_name}
            </a>
            <p class="reply-list__box__comment">${message.comment}</p>
            <img class="lower-reply__image" src=${message.image} >
            <div class= "author__created_at">
            ${message.created_at}
            </div>
          </div>
        </div>`
        return html
    }
    // ユーザー画像がなし、メッセージが画像なし
    else{
      var html =
        `<div class='reply-list__box', data-message-id=${message.id}>
          <div class='comment-author'>
            <a href="/users/${message.user_id}" class= "link-image">
              <p><img src="/no-image.png" class="author__image"></p>
            </a>
            <a href="/users/${message.user_id}" class= "author__name">
              ${message.user_name}
            </a>
            <p class="reply-list__box__comment">${message.comment}</p>
            <div class= "author__created_at">
            ${message.created_at}
            </div>
          </div>
        </div>`
      return html
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
    $('.reply-list').append(html);
    $('.reply-list').animate({ scrollTop: $('.reply-list')[0].scrollHeight});
  })

  .fail(function(){
    alert("メッセージ送信に失敗しました")
  })

  .always(function() {
    $('.comment__submit ').prop('disabled', false);
    $('#new_message')[0].reset();
  });
  })
  var reloadMessages = function() {
  var last_message_id = $('.reply-list__box:last').data("message-id");
  var id = $('.callroom_id').val();
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
      $('.reply-list').append(insertHTML);
      $('.reply-list').animate({ scrollTop: $('.reply-list')[0].scrollHeight});
    }
  })
  .fail(function() {
    // alert('error')
  });
  };
  if (document.location.href.match(/\/callrooms\/\d+$/)) {
  setInterval(reloadMessages, 7000);
  }
})
