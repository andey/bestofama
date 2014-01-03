jQuery ->

  # Resize the comments, so they don't overflow
  $(".comment-width").filter(->
    parseInt($(this).data('depth')) > 6
  ).each ->
    resize = 9 - Math.round((parseInt($(this).data('depth'))-6)/2.0)
    $(this).removeClass('col-xs-9 col-sm-9 col-md-9 col-lg-9').addClass("col-xs-#{resize} col-sm-#{resize} col-md-#{resize} col-lg-#{resize}")

  $('#tab-archive').find('.archives .karma, .archives .comments').each ->
    which_class = if $(this).hasClass('karma') then '.karma' else '.comments'
    change = parseInt($(this).find('.number').text()) - parseInt($(this).parent().next().find(which_class).text())
    if change > 0
      $(this).find('.difference').text("(+#{change})").addClass('green')
    else if change < 0
      $(this).find('.difference').text("(#{change})").addClass('red')

  $('.ama-comments').on 'click', '.share-link', (e) ->
    e.preventDefault()
    canonical = $('link[rel="canonical"]').attr('href')
    key = $(this).closest('.ama-comment').attr('id')
    $(this).after("#{canonical}##{key}")
    $(this).addClass('hidden')

  if $('#amas_show').length > 0 && window.location.hash
    hash = window.location.hash
    $(hash).find('.comment-width').addClass('anchor')

  if $('.change').length > 0
    $('.change').each ->
      $($(this).data('key')).find('.history-check').removeClass('hidden')

  $('.ama-comments').on 'click', '.history-check', (e) ->
    e.preventDefault()
    modal = $('.modal')
    modal.find('.modal-body').html('')
    hr = false
    $(".change[data-key='#{$(this).attr('href')}']").each ->
      if hr
        modal.find('.modal-body').append('<hr/>')
      modal.find('.modal-body').append($(this).find('.before').html())
      modal.find('.modal-body').append('<center>' + $(this).next().find('time').text() + '</center>')
      hr = true
    modal.modal('show')

