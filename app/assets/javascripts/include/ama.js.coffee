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
      $(this).find('.change').text("(+#{change})").addClass('green')
    else if change < 0
      $(this).find('.change').text("(#{change})").addClass('red')