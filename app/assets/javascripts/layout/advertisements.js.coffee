jQuery ->
  # Make the advertisement panels sticky
  elm = $('.sticky')
  if elm.length > 0
    elm.css('width', elm.width())
    bottom = $('.sticky-scroll-bottom')
    bottom_spacing = $(document).height() - bottom.offset().top
    elm.sticky({topSpacing: 10, bottomSpacing: bottom_spacing})