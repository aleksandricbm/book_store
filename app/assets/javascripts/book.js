$(function() {
  function get_item_quantity()
  {
    return parseInt($("#order_item_quantity").val());
  }
  $(".fa.fa-minus.line-height-40").click(function(){
    if(get_item_quantity()>1) $("#order_item_quantity").val(get_item_quantity()-1);
  });
  $(".fa.fa-plus.line-height-40").click(function(){
    $("#order_item_quantity").val(get_item_quantity()+1);
  });
});
