class ICRMClient.Suggestion.SuggestionTabView extends @ICRMClient.Backbone.View
  template: JST['suggestion/suggestion_tab_view']

  id: 'convead_suggestion_holder'
  tagName: 'div'

  header_class: 'suggestion'
  tab_name: @.prototype.t 'widget.tab.suggestions'

  disabled: true

  render: ->
    @$el.html @template()
    @
