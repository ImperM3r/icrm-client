class ICRMClient.Problem.ProblemTabView extends @ICRMClient.Backbone.View
  template: JST['problem/problem_tab_view']

  id: 'convead_problem_holder'
  tagName: 'div'

  render: ->
    @$el.html @template()
    @
