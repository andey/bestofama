jQuery ->

  # Resize the comments, so they don't overflow
  $(".comment-width").filter(->
    parseInt($(this).data('depth')) > 6
  ).each ->
    resize = 9 - Math.round((parseInt($(this).data('depth'))-6)/2.0)
    $(this).removeClass('col-xs-9 col-sm-9 col-md-9 col-lg-9').addClass("col-xs-#{resize} col-sm-#{resize} col-md-#{resize} col-lg-#{resize}")