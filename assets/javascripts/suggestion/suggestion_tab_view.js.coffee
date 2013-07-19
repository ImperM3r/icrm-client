class ICRMClient.Suggestion.SuggestionTabView extends @ICRMClient.Backbone.View
  template: JST['suggestion/suggestion_tab_view']

  id: 'convead_suggestion_holder'
  tagName: 'div'

  render: ->
    @$el.html @template()
    @
