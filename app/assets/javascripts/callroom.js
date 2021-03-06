$(function(){

  var modal = $('#modal'),
        modalContent = $('#modal_content')

  var callmodal = $('#callmodal'),
        modalContent = $('#modal_content')

  // 先生側のモーダルウィンドウ
  function buildCalled(student){
    if (student.image){
      var html =   
      `<p class = modal-profile-image-a>
        <img src= ${student.image} class='modal-profile-image'>
      </p>
      <p>${student.name}さんから連絡が来ています。</p>
      <P>紹介:${student.introduction}</p>
      <a href="/callrooms/call" class = "btn-border">承認する</a>
      <a href="/callrooms/update_attribute" class = "btn-border no-btn">拒否する</a>`
      return html;
    } else {
      var html =
      `<p class = modal-profile-image-a>
        <img src= "/no-image.png" class='modal-profile-image'>
      </p>
      <p>${student.name}さんから連絡が来ています。</p>
      <P>紹介:${student.introduction}</p>
      <a href="/callrooms/call" class = "btn-border">承認する</a>
      <a href="/callrooms/update_attribute" class = "btn-border no-btn">拒否する</a>`
      return html;
    }
  }

  // 連絡待ち
  function buildCall(callroom) {
    if ( callroom.user_image ){
      var html =
      `<p class = modal-profile-image-a>
        <img src= ${callroom.user_image} class='modal-profile-image'>
      </p>
      <p>${callroom.user_name}さんに連絡しています！</p>
      <div class = "cancelcall btn-flat-vertical-border", data-cancecall_id=${callroom.id}>キャンセル</div>`
      return html;
    }else{
      var html =
      `<p class = modal-profile-image-a>
        <img src= "/no-image.png" class='modal-profile-image'>
      </p>
      <p>${callroom.user_name}さんに連絡しています！</p>
      <div class = "cancelcall btn-flat-vertical-border", data-cancecall_id=${callroom.id}>キャンセル</div>`
      return html;
    }
  }
  
  // indexのcall-showをクリックcallroom.idに紐づく詳細情報がモーダルに出る。
  $('.callroom-show').click(function(e){
    e.preventDefault();
    var id = $(this).data("show_id");          
    $('#modal-' + id).show();
    $(".escape").click(function(){
      $(this).parents(".call_info_modal").fadeOut();
    });
  })
  
  // 電話するボタンを押すとstdeunt.idやstatusが変わる。
  $('.call').click(function(e){
    e.preventDefault();
    var id = $(this).data("call_id");
    
    $.ajax({
      url: "/callrooms/call",
      type: "GET",
      data: {id:id}, 
      dataType: 'json'
    })
    
    .done(function(data){
      var student = data.student
      var callroom = data.callroom
      var already_callroom = data.already_callroom
      
      if(callroom.student_id == student.id){
        var htmlCall = buildCall(callroom);
        $(modalContent).empty();
        $('.call_info_modal').hide();
        $('#modal_content').append(htmlCall);
        modal.show();
        
        // 通話キャンセル処理
        $('.cancelcall').on('click', function(e){
          e.preventDefault();
          var id = $(this).data("cancecall_id");
          
          $.ajax({
            url: "/callrooms/cancelcall",
            type: "POST",
            data: {id:id}, 
            dataType: 'json'
          })
          .done(function(callroom){
            $(modal).hide();
            $(modalContent).empty();
            var html = 
            `<div class = "escape">&times;</div>
            <p>${callroom.user_name}との連絡を取りやめました。</p>`
            $(modalContent).append(html);
            $(modal).show();
            
            $(".escape").on('click', function () {
              $(modal).fadeOut();
            });
          })
        })
      }
      else if ( typeof already_callroom != "undefined"){
        var html = `<div class = "escape">&times;</div>
        <div>すでにあなたは、${already_callroom.user_name}さんと連絡をとっています。連絡が終わるまで他のユーザーに連絡することができません。</p>
        <div class = "ben_box">
          <div class = "cancelcall btn-flat-vertical-border double_booking_btn", data-cancecall_id=${already_callroom.id}>${already_callroom.user_name}さんとの連絡を中止する</div>
        </div>`
        $('#modal_content').empty();
        $('#modal_content').append(html);
        modal.show();
        // 通話キャンセル処理
        $('.cancelcall').on('click', function(e){
          e.preventDefault();
          var id = $(this).data("cancecall_id");
          
          $.ajax({
            url: "/callrooms/cancelcall",
            type: "POST",
            data: {id:id}, 
            dataType: 'json'
          })
          .done(function(callroom){
            $(modal).hide();
            $(modalContent).empty();
            var html = 
            `<div class = "escape">&times;</div>
            <p>${callroom.user_name}との連絡を取りやめました。</p>`
            $(modalContent).append(html);
            $(modal).show();
            
            $(".escape").on('click', function () {
              $(modal).fadeOut();
            });
          })
        })
      }
      else{
        var html = `<div class = "escape">&times;</div>
                    <div>すでに相手が他のユーザーと連絡をとっています。</p>`
        $('#modal_content').empty();
        $('#modal_content').append(html);
        modal.show();
      }
      
    })
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
      type: 'get',
      dataType: 'json'
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
    
    .done(function(data){
      if(document.location.href.match(/\/callrooms\/\d+/)){
      }else if( typeof data.callroom10 != "undefined" && data.callroom10.status == 3){
        var html =
        `<div>${data.callroom10.user_name}さんに連絡が付きました。</div>
        <a href="/callrooms/${data.callroom10.id}">こちらへ</a>`
        $('#modal_content').empty();
        $('#modal_content').append(html);
        modal.show();
      } 
      else if(typeof data.callroom_now != "undefined" && data.callroom_now.status == 1){
        var html =
        `<div class = "escape">&times;</div>
        <div>${data.callroom_now.user_name}さんに通話中です。</div>
        <p>また、ご利用ください</p>`
        $('#modal_content').empty();
        $('#modal_content').append(html);
        modal.show();
      }

      $(document).on("click", ".escape", function () {
        (modal).hide();
      }); 
    })
  } 
  // ✗ボタンによるモーダル終了
  $(document).on("click", ".escape", function () {
    (modal).fadeOut;
  });
  setInterval(reloadCalled, 3000);
  setInterval(reloadCall, 3000);
});