$(function(){
  
  let localStream;
  const peer = new Peer({
    key: 'e751c12a-973c-4ca1-bd50-1f2cec55d91a',
    debug: 3
  });
  peer.on('open', () => {
    document.getElementById('my-id').textContent = peer.id;
  });
  
  // カメラ映像取得
  
  navigator.mediaDevices.getUserMedia({video: true, audio: true})
    .then( stream => {
    // 成功時にvideo要素にカメラ映像をセットし、再生
    const videoElm = document.getElementById('my-video')
    videoElm.srcObject = stream;
    videoElm.play();
    // 着信時に相手にカメラ映像を返せるように、グローバル変数に保存しておく
    localStream = stream;
  }).catch( error => {
    // 失敗時にはエラーログを出力
    console.error('mediaDevice.getUserMedia() error:', error);
    return;
  });
  document.getElementById('make-call').onclick = () => {
  const theirID = document.getElementById('their-id').value;
  const mediaConnection = peer.call(theirID, localStream);
  setEventListener(mediaConnection);
  };
    
  
  // イベントリスナを設置する関数
  const setEventListener = mediaConnection => {
  mediaConnection.on('stream', stream => {
    // video要素にカメラ映像をセットして再生
    const videoElm = document.getElementById('their-video')
    videoElm.srcObject = stream;
    videoElm.play();
  
  //着信処理
  peer.on('call', mediaConnection => {
  mediaConnection.answer(localStream);
  setEventListener(mediaConnection);
  });
  });
  }

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