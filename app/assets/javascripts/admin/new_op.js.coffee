jQuery ->
  if $('.admin_ops.new').length > 0
    $('.users a').click()
    $('.users input').val(decodeURI((RegExp('username=(.+?)(&|$)').exec(location.search)||[null])[1]))
    $('#op_name').val(decodeURI((RegExp('title=(.+?)(&|$)').exec(location.search)||[null])[1]))