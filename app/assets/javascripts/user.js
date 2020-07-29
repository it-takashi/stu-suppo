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
  $("#user_name").keyup(function () {
    $('.error_user_name').empty();
    var name = $("#user_name").val()

    $.ajax({
      url: "/api/users/",
      type: 'get',
      dataType: 'json',
      data: {name:name}
    })

    .done(function(user){
      // userがあるかどうか確認しあればすでにその名前があることを伝える
      if (typeof user.name != "undefined"){
        var html = `<div class="error">すでにその名前は存在します。</div>
        `
        $(".error_user_name") .append(html);
      }
    })
  });

})
