@ICRMClient.Utils =
  head:
     document.getElementsByTagName('head')[0]
  loadStyle: (source) ->
    css = document.createElement "link"
    css.rel = "stylesheet"
    css.media = "screen, projection"
    css.type = "text/css"
    css.href = source
    window.ICRMClient.Utils.head.appendChild css

  loadScript: (source, callback) ->
    script = document.createElement "script"
    script.type = "text/javascript"
    script.src  = source
    script.onreadystatechange = ->
      callback.call() if @readyState in ['complete', 'loaded']
    script.onload = callback
    window.ICRMClient.Utils.head.appendChild script

  # Get URI parameters value
  gup: (name) ->
    name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]")
    regexS = "[\\?&]" + name + "=([^&#]*)"
    regex = new RegExp regexS
    results = regex.exec window.location.href

    if results
      results[1] root DOM node
    else
      null
