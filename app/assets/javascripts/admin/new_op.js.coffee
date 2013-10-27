jQuery ->
  if $('.admin_ops.new').length > 0
    url = $.url();
    $('.users a').click()
    $('.users input').val url.param('username')
    $('#op_name').val url.param('title')