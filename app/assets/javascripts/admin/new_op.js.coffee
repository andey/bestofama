jQuery ->
  if $('.admin_ops.new').length > 0
    url = $.url();
    $('.users a').click()
    $('.users input').val url.param('username')
    $('#op_name').val url.param('title')

    $(document).keyup (e) ->
      if e.keyCode is 27
        name = $('#op_name').val()
        console.log window.BING_API
#        console.log 'ESC key pressed'
#        $.ajax(
#          type: 'GET'
#          url: 'http://api.duckduckgo.com'
#          dataType: 'jsonp'
#          data:
#            q: $('#op_name').val()
#            format: 'json'
#        ).done (data) ->
#          $('#op_content').val(data['AbstractText'])
#          $('#op_tag_list').val(data['AbstractText'])
#          $('.links a').click()
#          $('.links input').val(data['AbstractURL'])

        $.ajax(
          type: 'GET'
          url: 'https://api.datamarket.azure.com/Bing/Search/v1/Composite'
          dataType: 'jsonp'
          jsonp: '$callback'
          cache: true
          username: 'Xyr0Vm1kTPp3eK46QsynD2iJTCDYa3R89yZvILi3tes'
          password: 'Xyr0Vm1kTPp3eK46QsynD2iJTCDYa3R89yZvILi3tes'
          data:
            Sources: "'image'"
            Query: "'#{name}'"
            $format: 'JSON'
        ).done (data) ->
          console.log data
          images = data['d']['results'][0]['Image']
          console.log images
          $.each images, (index, value) ->
            console.log value

