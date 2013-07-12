class @ICRMClient.Controllers.Informer
  constructor: (callback) ->

    window.ICRMClient.xhr.request
      url: window.ICRMClient.Assets.logger_url
      data: @user_data()
      headers: { "Content-Type" : "application/x-www-form-urlencoded" }

    , callback

    , (response) => #error function
      console.error response
    @

  user_data: ->
    window.ICRMClient.app_key = window.ICRM_Settings.app_key
    delete window.ICRM_Settings.app_key

    data =
      app_key:        window.ICRMClient.app_key,
      current_url:    document.URL,
      referrer:       document.referrer,
      document_title: document.title || ''

    data['user_data[' + prop + ']'] = window.ICRM_Settings[prop] for prop of window.ICRM_Settings

    return data
