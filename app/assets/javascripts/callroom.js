$(function(){

  var modal = $('#modal'),
        modalContent = $('#modal_content'),
        btnOpen = $("#btn_open"),
        btnClose = $(".btn_close");

  var callmodal = $('#callmodal'),
        modalContent = $('#modal_content'),
        btnOpen = $("#btn_open"),
        btnClose = $(".btn_close");

  // 先生側のモーダルウィンドウ
  function buildCalled(student){
    console.log(student)
    if (student.image){
      var html =   
      `<p>
        <img src= ${student.image.url}  class='author__image'>
      </p>
      <p>${student.name}さんから連絡が来ています。</p>
      <P>紹介:${student.profile}</p>
      <a href="/callrooms/call">承認する</a>
      <a href=" /callrooms/update_attribute">拒否する</a>`
      return html;
    } else {
      var html =
      `<div class="author__no-image">No-<br/>image</div>
      <p>${student.name}さんから連絡が来ています。</>
      <P>紹介:${student.introduction}</p>
      <a href="/callrooms/call">承認する</a>
      <a href="/callrooms/update_attribute">拒否する</a>`
      return html;
    }
  }

  function buildCall(callroom) {
    if ( callroom.user_imgage ){
      var html =   
        `<p class = link-image>
          <img src= "callroom.user_image.url"  class='author__image'>
        </p>
        <p>${callroom.user_name}さんに連絡しています！</p>
        <div>タイトル: ${callroom.title}</div>
        <div>本文: ${callroom.body}</div>`
          return html;
    }else{
      var html =
      `<p class = link-image>
        <div class="author__no-image">
            No-
            <br>
            image
        </div>
      </p>
      <p>${callroom.user_name}さんに連絡しています！</p>
      <div>タイトル: ${callroom.title}</div>
      <div>本文: ${callroom.body}</div>`
      return html;
    }
  }
  
  // indexのcallをクリックすると
  $('.call').click(function(e){
    e.preventDefault();
    var id = $(this).data("call_id");    
    // var id = $(this).val();      
    console.log(id)
    // console.log(current_user.id)
    
    $.ajax({
      url: "/callrooms/call",
      type: "GET",
      data: {id:id}, 
      dataType: 'json'
    })

    .done(function(data){
      var student = data.student
      var callroom = data.callroom
      
      if(callroom.student_id == student.id){
        var htmlCall = buildCall(callroom);
        $('#modal_content').empty();
        $('#modal_content').append(htmlCall);
        modal.show();
      }
      else{
        `<div>すでに電話しています。</div>`
        console.log("通信失敗")
        $('#modal_content').empty();
        $('#modal_content').append(html);
        modal.show();
      }
    })

    .fail(function(){
      console.log("通信失敗")
    })




    // モーダル以外、閉じるを押すとモーダルが消える

    $(modal).on('click', function(event) {
      if(!($(event.target).closest(modalContent).length)||($(event.target).closest(btnClose).length)){
        modal.hide();
      }
    });
    $(modal).on('click', function(event) {
      if(!($(event.target).closest(modalContent).length)||($(event.target).closest(btnClose).length)){
        modal.hide();
      }
    });

    
  }) 

  $(callmodal).on('click', function(event) {
    if(!($(event.target).closest(modalContent).length)||($(event.target).closest(btnClose).length)){
      callmodal.hide();
    }
  });

  // 先生側自動更新
  var reloadCalled =function(){
    $.ajax({
      //ルーティングで設定したパス
      url: "/api/callrooms",
      //ルーティングで設定した通りhttpメソッドをgetに指定
      type: 'get',
      dataType: 'json',
      //dataオプションでリクエストに値を含める
      // data: {id: called_id}
    })

    .done(function(data){
      var callroom = data.callroom
      // callroomがあるかどうか確認しstatusが2かつcallmodelの要素が1であることを確認する
      if (typeof callroom != "undefined" && callroom.status == 2 && $('#callmodal_content').length == 1){
        var student = data.student
        // 先生側
        var htmlCalled = buildCalled(student);
        $('#callmodal_content').empty();
        $('#callmodal_content').append(htmlCalled);
        $('#callmodal').show();
      }
    })

  }  
  // 生徒側自動更新
  var reloadCall =function(){
    $.ajax({
      url: "/api/callrooms/new",
      type: 'get',
      dataType: 'json'
    })

    .done(function(callroom){
      // console.log(callroom)
      if(document.location.href.match(/\/callrooms\/\d+/)){
      }else if(callroom.status == 3){
        var html =
          `<div>${callroom.user_name}さんに連絡が付きました。</div>
          <a href="/callrooms/${callroom.id}">こちらへ</a>`
        $('#modal_content').empty();
        $('#modal_content').append(html);
        modal.show();
      } 
    })
  } 

  // setInterval(reloadCalled, 7000);
  // setInterval(reloadCall, 7000);
});