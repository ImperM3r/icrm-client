class ICRMClient.Views.MessagesView extends @ICRMClient.Backbone.View

  initialize: (options) ->
    @model_view = options.model_view
    @render()

    @listenTo @collection, 'add', (model) =>
      @add model
    @

  add: (model) =>
    @$el.append new @model_view(model: model).render().el

  render: ->
    @$el.empty()

    @collection.each (model) =>
      @add model
    @
