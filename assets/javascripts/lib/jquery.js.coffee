#= require json2/json2
#= require jquery/jquery

## Prepare jQuery
@ICRMClient.Base::$ = @ICRMClient.$ = jQuery.noConflict(true)
@ICRMClient.$.support.cors = true

@ICRMClient.$.fn.extend
  submitByEnter: ->
    @on 'keypress', (event) =>
      if event.which == 13 and !event.shiftKey and !event.ctrlKey && @val().replace(/^\s+|\s+$/g, "").length > 0
        @.closest('form').submit()
        event.preventDefault()

# TODO Setup app_key in headers
