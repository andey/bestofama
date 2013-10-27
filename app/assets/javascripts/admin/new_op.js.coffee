jQuery ->
  if $('.admin_ops.new').length > 0
    url = $.url();
    $('.users a').click()
    $('.users input').val url.param('username')
    $('#op_name').val url.param('title')

    $(document).keyup (e) ->
      if e.keyCode is 27
        console.log 'ESC key pressed'
        $.ajax(
          type: 'GET'
          url: 'http://api.duckduckgo.com'
          dataType: 'jsonp'
          data:
            q: $('#op_name').val()
            format: 'json'
        ).done (data) ->
          $('#op_content').val(data['AbstractText'])
          $('#op_tag_list').val(data['AbstractText'])
          $('.links a').click()
          $('.links input').val(data['AbstractURL'])
