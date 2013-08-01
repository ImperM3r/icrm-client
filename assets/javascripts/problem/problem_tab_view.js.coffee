class ICRMClient.Problem.ProblemTabView extends @ICRMClient.Backbone.View
  template: JST['problem/problem_tab_view']

  id: 'convead_problem_holder'
  tagName: 'div'

  tab_name: 'Problem'

  disabled: true

  render: ->
    @$el.html @template()
    @
