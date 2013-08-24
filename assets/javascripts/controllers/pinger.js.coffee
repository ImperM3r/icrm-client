class @ICRMClient.Pinger extends @ICRMClient.Base
  constructor: (period) ->
    @ping_url = @assets.basic_api_url + 'ping'

    # Period to ping, in seconds
    @ping_period = period || 15
    @count = 0

    @debug "Set ping period #{period}"

    @activity()

    @intervalId = window.setInterval @nextTick, 1000

    if typeof(document.attachEvent)!='undefined'
      document.attachEvent("onmousedown", @clicked)
      document.attachEvent("onmousemove", @moved)
      document.attachEvent("onkeydown", @typed)
    else
      document.addEventListener("mousedown", @clicked, false)
      document.addEventListener("mousemove", @moved, false)
      document.addEventListener("keydown", @typed, false)

  moved: =>
    @activity()

  typed: =>
    @activity()

  clicked: =>
    @activity()

  activity: =>
    @last_activity_at = new Date()

  data: ->
    now=new Date()
    return idle_timeout: now - @last_activity_at

  nextTick: =>
    @count+=1

    if @count>=@ping_period
      @ping()
      @count = 0

  ping: =>
    @ajax
      url:     @ping_url
      data:    @data()
