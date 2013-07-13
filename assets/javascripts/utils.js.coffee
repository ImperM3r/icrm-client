@ICRMClient.Utils =
  loadStyle: (source) ->
    css = document.createElement "link"
    css.rel = "stylesheet"
    css.media = "screen, projection"
    css.type = "text/css"
    css.href = source
    window.ICRMClient.head.appendChild css

  loadScript: (source, callback) ->
    script = document.createElement "script"
    script.type = "text/javascript"
    script.src  = source
    script.onreadystatechange = ->
      callback.call() if @readyState in ['complete', 'loaded']
    script.onload = callback
    window.ICRMClient.head.appendChild script
