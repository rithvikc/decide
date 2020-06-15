const initImages = () => {
$(document).on("turbolinks:load", () => {
      // hide spinner
      $(".spinner").hide();

      // show spinner on AJAX start
      $(document).ajaxStart(function(){
        $(".spinner").show();
      });

      // hide spinner on AJAX stop
      $(document).ajaxStop(function(){
        $(".spinner").hide();
      });
});

}
export { initImages };
