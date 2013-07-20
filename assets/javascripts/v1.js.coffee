#= require ./lib/namespaces
#= require ./lib/assets
#= require ./lib/base
#= require ./lib/jquery
#= require ./lib/backbone
#= require ./lib/utils
#= require ./lib/faye_client
#= require ./lib/faye_logger
#= require_tree ../templates
#= require_tree ./views
#= require_tree ./controllers
#= require_tree ./navigation
#= require_tree ./notifications
#= require_tree ./suggestion
#= require_tree ./problem
#= require_tree ./chat
#= require_tree ./widget

new @ICRMClient.ConveadController
