#= require underscore/underscore
#= require backbone/backbone
#
@ICRMClient.Backbone = Backbone.noConflict()
@ICRMClient.Backbone.$ = @ICRMClient.$ if @ICRMClient.$

@ICRMClient.Backbone.Model.prototype._ = @ICRMClient.Backbone.View.prototype._ = _
@ICRMClient.Base.prototype._ = _ if @ICRMClient.Base
@ICRMClient.underscore = _.noConflict()
