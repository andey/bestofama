jQuery ->
  timestamps = $('time')
  timestamps.each ->
    date = new Date($(this).text())
    $(this).text(date.toLocaleString())