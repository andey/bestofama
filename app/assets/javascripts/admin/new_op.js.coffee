jQuery ->

  if $('.admin_ops.new').length > 0
    url = $.url();
    $('.users a').click()
    $('.users input').val url.param('username')
    $('#op_name').val url.param('title')

    $(document).keyup (e) ->
      if e.keyCode is 27
        name = $('#op_name').val()
        console.log 'ESC key pressed'

        # DUCK DUCK GO API
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

        # BING API
        $.ajax(
          type: 'GET'
          url: 'https://api.datamarket.azure.com/Bing/Search/v1/Composite'
          dataType: 'jsonp'
          jsonp: '$callback'
          cache: true
          data:
            Sources: "'image'"
            Query: "'#{name}'"
            $format: 'JSON'
        ).done (data) ->
          input = $('#op_avatar_source')
          input.after('<hr/>')
          images = data['d']['results'][0]['Image']
          $.each images, (index, value) ->
            console.log value
            input.after('<img style="width:100px;" src="' + value["Thumbnail"]["MediaUrl"] + '" data-source="' + value["MediaUrl"] + '">' )

    $(document).on "click", "img", ->
      $('#op_avatar_source').val($(this).data('source'))


