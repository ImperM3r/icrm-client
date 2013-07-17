class @ICRMClient.InformerController extends @ICRMClient.Base
  logger_url: window.ICRMClient.Assets.api_url + 'logger'

  constructor: (callback) ->
    @ajax
      url: @logger_url
      data: @data()
      success: callback

  data: ->
    data =
      current_url:    document.URL,
      referrer:       document.referrer,
      document_title: document.title || ''

    data['user_data[' + prop + ']'] = window.ICRM_Settings[prop] for prop of window.ICRM_Settings

    return data
