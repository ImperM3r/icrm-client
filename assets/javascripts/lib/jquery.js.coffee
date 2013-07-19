#= require json2/json2
#= require jquery/jquery

## Prepare jQuery
@ICRMClient.Base::$ = @ICRMClient.$ = jQuery.noConflict(true)
@ICRMClient.$.support.cors = true

# TODO Setup app_key in headers
