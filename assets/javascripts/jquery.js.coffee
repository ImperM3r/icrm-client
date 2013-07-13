#= require jquery/jquery.min

## Prepare jQuery
@ICRMClient.Base::$ = window.ICRMClient.jQuery = jQuery.noConflict()
@ICRMClient.Base::$.support.cors = true
