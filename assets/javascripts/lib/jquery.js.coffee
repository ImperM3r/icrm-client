#= require json2/json2
#= require jquery/jquery
#= require jquery-utils/jquery-utils

## Prepare jQuery
@ICRMClient.Base::$ = @ICRMClient.$ = jQuery.noConflict(true)
@ICRMClient.$.support.cors = true

# TODO Setup app_key in headers
