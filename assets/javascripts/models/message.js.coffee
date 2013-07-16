class ICRMClient.Models.Message extends @ICRMClient.Backbone.Model
  presentation: ->
    p = @toJSON()

    if p.from
      p.sender_name = p.from.name
    else
      p.sender_name = 'You' # TODO Move to locale

    return p
