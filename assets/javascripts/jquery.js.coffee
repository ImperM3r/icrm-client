#= require jquery/jquery.min

## Prepare jQuery
@ICRMClient.Base::$ = @ICRMClient.$ = jQuery.noConflict()
@ICRMClient.$.support.cors = true

# TODO Setup app_key in headers
