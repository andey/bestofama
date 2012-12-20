find_entity_by_wiki_slug = (url) ->
  matches = url.match("http://en.wikipedia.org/wiki/(.*)")
  if matches?
    return $.getJSON("/api/entities/find_by_wiki_slug.json?q=" + matches[1])
    ;
  else
    return false

find_ama_by_key = (url) ->
  matches = url.match('/IAmA/comments/([a-z0-9]{5,6})/')
  if matches?
    return $.getJSON("/api/ama/find_by_key.json?key=" + matches[1])
    ;
  else
    return false

jQuery ->
  $("#submit_ama_url_input").change ->
    data = find_ama_by_key $("#submit_ama_url_input").val()
    if data == false
      $("#submit_ama_url").removeClass("success")
      $("#submit_ama_url").addClass("error")
      $("#submit_ama_url .help-inline").html('<i class="icon-remove"></i> Invalid URL')
    else
      data.done (response) ->
        if response["result"] == false
          $("#submit_ama_url").removeClass("error")
          $("#submit_ama_url").addClass("success")
          $("#submit_ama_url .help-inline").html('<i class="icon-ok-sign"></i>')
        else
          $("#submit_ama_url").removeClass("success")
          $("#submit_ama_url").addClass("error")
          $("#submit_ama_url .help-inline").html('<i class="icon-remove"></i> AMA already in database')

  $("#submit_wiki_url_input").change ->
    data = find_entity_by_wiki_slug $("#submit_wiki_url_input").val()
    if data == false
      $("#submit_wiki_url").removeClass("success")
      $("#submit_wiki_url").addClass("error")
      $("#submit_wiki_url .help-inline").html('<i class="icon-remove"></i> Invalid URL')
    else
      data.done (response) ->
        if response["result"] == false
          $("#submit_wiki_url").removeClass("error")
          $("#submit_wiki_url").addClass("success")
          $("#submit_wiki_url .help-inline").html('<i class="icon-ok-sign"></i> Entity not found, please enter in details')
          $("#submit_step3").removeClass("hidden")
        else
          $("#submit_wiki_url").removeClass("error")
          $("#submit_wiki_url").addClass("success")
          $("#submit_wiki_url .help-inline").html('<i class="icon-ok-sign"></i> Match Found.')

