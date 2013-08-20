class ICRMClient.Chat.Message extends @ICRMClient.Backbone.Model
  presentation: ->
    p = @toJSON()
    @_.extend p, window.ICRMClient.Helpers
    return p
