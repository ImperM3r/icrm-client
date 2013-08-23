class @ICRMClient.Pinger extends @ICRMClient.Base
  constructor: (period) ->
    @ping_url = @assets.basic_api_url + 'ping'
    period = 15 unless period
    period = period * 1000

    @debug "Set ping period #{period}"

    @intervalId = window.setInterval @ping, period

  data: ->
    {}

  ping: =>
    @ajax
      url:     @ping_url
      data:    @data()
