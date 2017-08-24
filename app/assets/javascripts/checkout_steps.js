function error_parse(data)
{
  console.log(data)
  $("#new_setting_address").find('div').removeClass("has-error");
  $("#new_setting_address").find('span.help-block').remove();
  for (var key in data)
  {
    put_error_message(key, data[key])
  }
}

function put_error_message(key, data)
{
  // console.log(data)
  for (var type in data)
  {
    console.log(type +'____'+data[type])
    $("#setting_address_"+key+"_address_"+type).parent().addClass('has-error')
    $("#setting_address_"+key+"_address_"+type).after('<span class="help-block">' + data[type] + '</span>')
  }
}
