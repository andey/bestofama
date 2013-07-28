jQuery ->
  # Load iframe src
  load_iframe = (element) ->
    if $(element).length > 0 && $(element).attr('src') == undefined
      url = $(element).data('url')
      $(element).attr('src', url)
      return true
    else
      return false

  # BIND EVENTS
  $("#ops_show .nav-tabs li").click ->
    $("#ops_show .nav-tabs .active").removeClass('active')
    $(this).addClass('active')
    $("#ops_show .tab-content").addClass('hide')
    $("#ops_show #"+$(this).attr('rel')).removeClass('hide')
    if $(this).attr('rel') == 'info'
      load_iframe('iframe')

  # INITIALIZE
  if $('#ops_show').length > 0

    hash = window.location.hash
    tab_taken = false

    if hash == '#amas' || hash == '#comments' || hash == '#info'
      tab_taken = true

    if ($('#amas').length > 0 && !tab_taken) || hash == '#amas'
      tab_taken = true
      $('#amas').removeClass('hide')
      $('li[rel="amas"]').addClass('active')
    else if ($('#comments').length > 0 && !tab_taken) || hash == '#comments'
      tab_taken = true
      $('#comments').removeClass('hide')
      $('li[rel="comments"]').addClass('active')
    else if ($('#info').length > 0 && !tab_taken) || hash == '#info'
      tab_taken = true
      $('#info').removeClass('hide')
      $('li[rel="info"]').addClass('active')
      load_iframe('iframe')








