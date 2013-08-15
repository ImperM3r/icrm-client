class @ICRMClient.InformerController extends @ICRMClient.Base

  constructor: (after_callback) ->
    @after_callback = after_callback
    @logger_url = @assets.api_url + 'logger'

    @perform()

  data: ->
    data =
      current_url:    document.URL,
      referrer:       document.referrer,
      document_title: document.title || ''

    data['user_data[' + prop + ']'] = window.ICRM_Settings[prop] for prop of window.ICRM_Settings

    return data

  perform: ->
    @ajax
      url:     @logger_url
      data:    @data()
      success: @_callback

  _callback: (response) =>
    window.ICRMClient.informer_response = response

    if !response || !response.visitor
      @error "Bad response #{JSON.stringify(response)}"
    else
      @debug "Informer response #{JSON.stringify(response)}"
      window.ICRMClient.visitor = response.visitor

      @after_callback()
