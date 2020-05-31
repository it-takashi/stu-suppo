$(function(){ 
  
  let localStream;  
  // カメラ映像取得
  
  const peer = new Peer({
    key: 'e751c12a-973c-4ca1-bd50-1f2cec55d91a',
    debug: 3
  });
  peer.on('open', () => {
    document.getElementById('my-id').textContent = peer.id;
    console.log('ID取得完了')
  });

  navigator.mediaDevices.getUserMedia({video: true, audio: true})
    .then( stream => {
      console.log('ビデオ設置完了')
      // 成功時にvideo要素にカメラ映像をセットし、再生
      // const videoElm = document.getElementById('my-video')
      const videoElm = $('#my-video').get(0);
      videoElm.srcObject = stream;
      videoElm.play();
      // 着信時に相手にカメラ映像を返せるように、グローバル変数に保存しておく
      localStream = stream;
  }).catch( error => {
    // 失敗時にはエラーログを出力
    console.error('mediaDevice.getUserMedia() error:', error);
    return;
  });

  

  //発信処理
  document.getElementById('make-call').onclick = () => {
    const theirID = document.getElementById('their-id').value;
    const mediaConnection = peer.call(theirID, localStream);
    setEventListener(mediaConnection);
    alert('発信しました。')
  };
    
  
  // イベントリスナを設置する関数
  const setEventListener = mediaConnection => {
    mediaConnection.on('stream', stream => {
      // video要素にカメラ映像をセットして再生
      const videoElm = document.getElementById('their-video')
      videoElm.srcObject = stream;
      videoElm.play();
    });
  
  //着信処理
  peer.on('call', mediaConnection => {
    mediaConnection.answer(localStream);
    setEventListener(mediaConnection);
    alert('着信があります。')
  });
  }

  peer.on('error', err => {
    alert(err.message);
  });

  peer.on('close', () => {
    alert('通信が切断しました。');
  });

})
