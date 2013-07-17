#= require ./lib/namespaces
#= require ./lib/assets
#= require ./lib/base
#= require ./lib/jquery
#= require ./lib/backbone
#= require ./lib/utils
#= require_tree ../templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require_tree ./controllers
#= require_tree ./chat
#= require_tree ./widget

new @ICRMClient.ConveadController
