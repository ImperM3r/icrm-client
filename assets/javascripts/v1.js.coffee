#= require namespaces
#= require assets
#= require base
#= require jquery
#= require utils
#= require controllers/informer
#= require controllers/chat_controller
#= require controllers/notification_controller
#= require controllers/root_controller

if window.attachEvent
  window.attachEvent 'onload', new @ICRMClient.RootController
else
  window.addEventListener 'load', new @ICRMClient.RootController, false
