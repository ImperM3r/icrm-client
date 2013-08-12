class ICRMClient.Problem.ProblemTabView extends @ICRMClient.Backbone.View
  template: JST['problem/problem_tab_view']

  id: 'convead_problem_holder'
  tagName: 'div'

  header_class: 'problem'
  tab_name: @.prototype.t 'widget.tab.problem'

  disabled: true

  render: ->
    @$el.html @template()
    @
