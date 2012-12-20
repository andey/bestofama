jQuery ->
  $("#li-navbar-search-button a").click ->
    $("#li-navbar-search-button").addClass("hidden")
    $("#li-navbar-search-form").removeClass("hidden")