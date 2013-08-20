#= require underscore/underscore
#= require backbone/backbone
#
@ICRMClient.Backbone = Backbone.noConflict()
@ICRMClient.Backbone.$ = @ICRMClient.$ if @ICRMClient.$

@ICRMClient.Backbone.Model.prototype._ = @ICRMClient.Backbone.View.prototype._ = @ICRMClient.Base.prototype._ = @ICRMClient.underscore = _.noConflict()
