jQuery ->
  timestamps = $('time')
  timestamps.each ->
    if $(this).data('time')
      date = new Date(parseInt($(this).data('time')) * 1000)
      $(this).text(date.toLocaleString())