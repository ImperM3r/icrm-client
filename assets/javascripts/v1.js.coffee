#= require namespaces
#= require assets
#= require base
#= require jquery
#= require backbone
#= require utils
#= require_tree ../templates
#= require models/message
#= require_tree ./collections
#= require_tree ./views
#= require controllers/chat_controller
#= require controllers/informer
#= require controllers/notification_controller
#= require controllers/root_controller

new @ICRMClient.RootController
