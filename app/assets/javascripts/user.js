$(function(){
  // マイページのタブ 
  $(".userpost_tab a").click(function() {
    $(this).parent().addClass("active").siblings(".active").removeClass("active");
    var tabContents = $(this).attr("href");
    $(tabContents).addClass("active").siblings(".active").removeClass("active");
    return false;
  });

  // sign_up editページ

  // ユーザー名の一意性チェック
  $("#user_name").change(function () {

    var name = $("#user_name").val()
    console.log(name)

    $.ajax({
      url: "/api/users/",
      type: 'get',
      dataType: 'json',
      data: {name:name}
    })

    .done(function(user){
      // userがあるかどうか確認しあればすでにその名前があることを伝える
      console.log(user)
      console.log(user.name)
      if (typeof user.name != "undefined"){
        alert('すでにその名前user.nameが存在します。');
        return false;
      }
      else if ( name.length > 10) {
        alert('本文を10文字以内で入力してください。');
        return false;
      }
    })
  });


  // emailの一意性チェック(newページeditのみ確認)
  if(document.location.href.match(/\/users\/\d+\/edit|\/users\/sign_up|\/users$/)){
    
    $("#user_email").change(function () {
  
      var email = $("#user_email").val()
      $.ajax({
        url: "/api/users/new",
        type: 'get',
        dataType: 'json',
        data: {email:email}
      })
  
      .done(function(user){
        // userがあるかどうか確認しあればすでにその名前があることを伝える
        console.log(user.email)
        if (typeof user.email != "undefined"){
          alert('すでにそのemailは存在します。');
        return false;
        }
      })
    });
  }


})
