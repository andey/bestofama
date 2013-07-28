jQuery ->
  # Load iframe src
  load_iframe = (element) ->
    if $(element).length > 0 && $(element).attr('src') == undefined
      url = $(element).data('url')
      $(element).attr('src', url)
      return true
    else
      return false

  # INITIALIZE
  if $('#admin-ops_new').length > 0
    $('#query').change (event) ->
      event.preventDefault()
      duckduckgo_string = 'https://duckduckgo.com/?q=' + encodeURIComponent($('#query').val()) + '+site%3Awikipedia.org'
      $('#duckduckgo').attr('src', duckduckgo_string)
      googleimages_string = 'https://www.google.com/search?tbm=isch&q=' + encodeURIComponent($('#query').val())
      $('#googleimages_link').attr('href', googleimages_string)