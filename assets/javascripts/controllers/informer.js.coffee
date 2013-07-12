class @ICRMClient.Controllers.Informer extends @ICRMClient.Base
  constructor: (callback) ->
    @logger_url = window.ICRMClient.Assets.api_url + 'logger'
    @callback = callback
    @jqueryRequest()

  jqueryRequest: =>
    post =
      crossDomain: true
      xhrFields:
        withCredentials: true
      type: 'POST'
      url: @logger_url
      data: @data()
      success: @callback
      error: (e) ->
        console.error e
        #throw 'error'

    @$.ajax post

  easyRequest: =>
    window.ICRMClient.xhr.request
      url: @logger_url
      data: @data()
      headers: { "Content-Type" : "application/x-www-form-urlencoded" }

    , @callback

    , (response) => #error function
      console.error response
    @

  data: ->
    window.ICRMClient.app_key = window.ICRM_Settings.app_key
    delete window.ICRM_Settings.app_key

    data =
      app_key:        window.ICRMClient.app_key,
      current_url:    document.URL,
      referrer:       document.referrer,
      document_title: document.title || ''

    data['user_data[' + prop + ']'] = window.ICRM_Settings[prop] for prop of window.ICRM_Settings

    return data
