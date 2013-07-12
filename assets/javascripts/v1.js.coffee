#= require namespaces
#= require assets
#= require utils
#= require controllers/informer
#= require controllers/chat_controller
#= require controllers/notification_controller
#= require controllers/root_controller
#= require jquery/jquery.min

if window.attachEvent
  window.attachEvent 'onload', new @ICRMClient.RootController
else
  window.addEventListener 'load', new @ICRMClient.RootController, false
