$(function(){ 
  if (document.location.href.match(/\/teaches\/\d+|\/callrooms\/\d+/)) {

    // モーダル
    var modal = $('#modal'),
        modalContent = $('#modal_content'),
        btnOpen = $("#btn_open"),
        btnClose = $(".btn_close");

  var callmodal = $('#callmodal'),
        callmodalContent = $('#callmodal_content'),
        btnOpen = $("#btn_open"),
        btnClose = $(".btn_close");
    
    const Peer = window.Peer;
    window.__SKYWAY_KEY__ = 'e751c12a-973c-4ca1-bd50-1f2cec55d91a';
    
    (async function main() {
      const localVideo = document.getElementById('js-local-stream');
      const localId = document.getElementById('js-local-id');
      const callTrigger = document.getElementById('js-call-trigger');
      const closeTrigger = document.getElementById('js-close-trigger');
      const remoteVideo = document.getElementById('js-remote-stream');
      const remoteId = document.getElementById('js-remote-id');
      const meta = document.getElementById('js-meta');
      const sdkSrc = document.querySelector('script[src*=skyway]');
    
      meta.innerText = `
        UA: ${navigator.userAgent}
        SDK: ${sdkSrc ? sdkSrc.src : 'unknown'}
      `.trim();
    
      const localStream = await navigator.mediaDevices
        .getUserMedia({
          audio: true,
          video: true,
        })
        .catch(console.error);
    
      // Render local stream
      localVideo.muted = true;
      localVideo.srcObject = localStream;
      localVideo.playsInline = true;
      await localVideo.play().catch(console.error);
    
      const peer = (window.peer = new Peer({
        key: window.__SKYWAY_KEY__,
        debug: 3,
      }));
      
      // Register caller handler
      // 発信者の処理
      callTrigger.addEventListener('click', () => {
        // Note that you need to ensure the peer has connected to signaling server
        // before using methods of peer instance.
        if (!peer.open) {
          return;
        }

        
    
        const mediaConnection = peer.call(remoteId.value, localStream);
    
        mediaConnection.on('stream', async stream => {
          // Render remote stream for caller
          remoteVideo.srcObject = stream;
          remoteVideo.playsInline = true;
          console.log("電話したぜ")

          await remoteVideo.play().catch(console.error);
        });
        mediaConnection.once('close', () => {
          remoteVideo.srcObject.getTracks().forEach(track => track.stop());
          remoteVideo.srcObject = null;
          console.log("発信者通話終了")
          if (document.location.href.match(/\/callrooms\/\d+/)) {
            var id = $('.callroom_id').val();
            $.ajax({
              url: "/callrooms/update_attribute",
              type: "get",
              data: {id:id}, 
              dataType: 'json'
            })
            
            .done(function(data){
              console.log(data)
              student = data.student
              current_user  = data.current_user
              callroom = data.callroom
              console.log(student)
              // 先生のモーダル
              if (callroom.user_id == current_user.id){
                var html =
                `<div>${student.name}さんに連絡が終了しました。</div>
                <div>続けて連絡をお待ち下さい</div>`
                $('#modal_content').empty();
                $('#modal_content').append(html);
                modal.show();
              }
              // 生徒のモーダル
              else{
                var html =
                `<div>${callroom.user_name}さんとの連絡が終了しました。</div>`
                $('#callmodal_content').empty();
                $('#callmodal_content').append(html);
                callmodal.show();
                setTimeout(function(){
                  window.location.href = "/tweets/";
                }, 5000);
              }
            })
            .fail(function(){
              console.log("通信失敗")
            })

          }
        });
    
        closeTrigger.addEventListener('click', () =>{
          mediaConnection.close(true)
        }
        );
      });
    
      peer.once('open', id => (localId.textContent = id));
    
      // Register callee handler
      // 受信者の処理
      peer.on('call', mediaConnection => {
        mediaConnection.answer(localStream);
    
        mediaConnection.on('stream', async stream => {
          // Render remote stream for callee
          remoteVideo.srcObject = stream;
          remoteVideo.playsInline = true;
          await remoteVideo.play().catch(console.error);
          
        });
        
        mediaConnection.once('close', () => {
          remoteVideo.srcObject.getTracks().forEach(track => track.stop());
          remoteVideo.srcObject = null;
          console.log("受信者通話終了")
          // 通信終了時 status = 1(公開) student(生徒)をnillにする。
          if (document.location.href.match(/\/callrooms\/\d+/)) {
            var id = $('.callroom_id').val();
            $.ajax({
              url: "/callrooms/update_attribute",
              type: "get",
              data: {id:id}, 
              dataType: 'json'
            })
            
            .done(function(data){
              console.log(data)
              student = data.student
              current_user  = data.current_user
              callroom = data.callroom
              console.log(student)
              // 先生のモーダル
              if (callroom.user_id == current_user.id){
                var html =
                `<div>${student.name}さんに連絡が終了しました。</div>
                <div>続けて連絡をお待ち下さい</div>`
                $('#modal_content').empty();
                $('#modal_content').append(html);
                modal.show();
              }
              // 生徒のモーダル
              else{
                var html =
                `<div>${callroom.user_name}さんとの連絡が終了しました。</div>`
                $('#callmodal_content').empty();
                $('#callmodal_content').append(html);
                callmodal.show();
                setTimeout(function(){
                  window.location.href = "/tweets/";
                }, 5000);
              }
            })
            .fail(function(){
              console.log("通信失敗")
            })

          }
        });
        
        closeTrigger.addEventListener('click', () =>{ mediaConnection.close(true)

        })
      });
      
      peer.on('error', console.error);
    })();

  // $(modal).on('click', function(event) {
  //   if(!($(event.target).closest(modalContent).length)||($(event.target).closest(btnClose).length)){
  //     modal.hide();
  //   }
  // });

  }
})
