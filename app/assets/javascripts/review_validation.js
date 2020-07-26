$(document).ready(function(){

  $("#new_review").validate({

    rules: {
          "review[rate]": { required: true}
    },
    messages: {
        "review[rate]": {required: "入力してください"},
    },


    errorPlacement: function(error,element){
      error.insertAfter($("#rate-error"));
     },


  });
});