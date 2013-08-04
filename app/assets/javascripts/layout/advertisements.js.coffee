jQuery ->

  # Make the advertisement panels sticky
  elm = $('.sticky')
  if elm.length > 0
    elm.css('width', elm.width())
    bottom = $('.sticky-scroll-bottom')
    bottom_spacing = $(document).height() - bottom.offset().top
    elm.sticky({topSpacing: 10, bottomSpacing: bottom_spacing})

  # What size should 'placeholder' advertisements be?
  if $('.placeholder').length > 0
    width = document.documentElement.clientWidth

    if ( width >= 1200)
      $('.placeholder-skyscrapper').attr('src', 'http://placehold.it/160x600')
      $('.placeholder-skyscrapper-alt').attr('src', 'http://placehold.it/160x600')
      $('.placeholder-index-square').attr('src', 'http://placehold.it/336x280')
      $('.placeholder-index-square-alt').attr('src', 'http://placehold.it/250x250')

    if (width >= 992 && width < 1200)
      $('.placeholder-skyscrapper').attr('src', 'http://placehold.it/160x600')
      $('.placeholder-skyscrapper-alt').attr('src', 'http://placehold.it/160x600')
      $('.placeholder-index-square').attr('src', 'http://placehold.it/250x250')
      $('.placeholder-index-square-alt').attr('src', 'http://placehold.it/200x200')

    if (width >= 768 && width < 992)
      $('.placeholder-skyscrapper').attr('src', 'http://placehold.it/160x600')
      $('.placeholder-skyscrapper-alt').attr('src', 'http://placehold.it/468x60')
      $('.placeholder-index-square').attr('src', 'http://placehold.it/468x60')
      $('.placeholder-index-square-alt').attr('src', 'http://placehold.it/468x60')

    if (width < 768)
      $('.placeholder-skyscrapper').attr('src', 'http://placehold.it/468x60')
      $('.placeholder-skyscrapper-alt').attr('src', 'http://placehold.it/468x60')
      $('.placeholder-index-square').attr('src', 'http://placehold.it/468x60')
      $('.placeholder-index-square-alt').attr('src', 'http://placehold.it/468x60')