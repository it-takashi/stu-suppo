$(document).ready(function(){
  
  $(function () {
    // 画像をプレビュー表示させる.prev-contentを作成
    function buildHTML(image) {
      var html =
        `
          <img src="${image}", alt="preview" class="tweet_image">
        </>
        `
      return html;
    }
  
    // 画像が選択された時に発火します
    $(document).on('change', '.hidden', function () {
      // .file_filedからデータを取得して変数fileに代入します
      var file = this.files[0];
      // FileReaderオブジェクトを作成します
      var reader = new FileReader();
      // DataURIScheme文字列を取得します
      reader.readAsDataURL(file);
      console.log(file)
      // 読み込みが完了したら処理が実行されます
      reader.onload = function () {
        // 読み込んだファイルの内容を取得して変数imageに代入します
        var image = this.result;

        // 読み込んだ画像ファイルをbuildHTMLに渡します
        var html = buildHTML(image)
        $('.preview-box').empty();;
        $('.preview-box').append(html);
      }
    });
  });

});