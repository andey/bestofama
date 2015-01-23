jQuery ->

  $('.ama-comments').on 'click', '.share-link', (e) ->
    e.preventDefault()
    canonical = $('link[rel="canonical"]').attr('href')
    key = $(this).closest('.ama-comment').attr('id')
    $(this).after("#{canonical}##{key}")
    $(this).addClass('hidden')

