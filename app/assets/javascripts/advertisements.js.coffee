jQuery ->

  if $('.placeholder').length > 0
    width = document.documentElement.clientWidth

    if ( width >= 1200)
      $('.placeholder-skyscrapper').attr('src', 'http://placehold.it/160x600')
      $('.placeholder-skyscrapper-alt').attr('src', 'http://placehold.it/160x600')
      $('.placeholder-index-square').attr('src', 'http://placehold.it/336x280')

    if (width >= 992 && width < 1200)
      $('.placeholder-skyscrapper').attr('src', 'http://placehold.it/160x600')
      $('.placeholder-skyscrapper-alt').attr('src', 'http://placehold.it/160x600')
      $('.placeholder-index-square').attr('src', 'http://placehold.it/250x250')

    if (width >= 768 && width < 992)
      $('.placeholder-skyscrapper').attr('src', 'http://placehold.it/160x600')
      $('.placeholder-skyscrapper-alt').attr('src', 'http://placehold.it/468x60')
      $('.placeholder-index-square').attr('src', 'http://placehold.it/468x60')

    if (width < 768)
      $('.placeholder-skyscrapper').attr('src', 'http://placehold.it/468x60')
      $('.placeholder-skyscrapper-alt').attr('src', 'http://placehold.it/468x60')
      $('.placeholder-index-square').attr('src', 'http://placehold.it/468x60')