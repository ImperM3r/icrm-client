class ICRMClient.Widget.NavigationView extends @ICRMClient.Backbone.View
  el: '#icrm_chat .convead_navigation'

  initialize: (options) ->
    @$tabs = @$()
    $tabLinks = @$('ul.tabset a.tab')
    @prevActiveLink = @$ $tabLinks.eq(0)
    @currentTab = null
    $tabLinks.each (i, link) =>
      $link = @$(link)
      $tab = options.$parent.find($link.attr 'href')
      @$tabs = @$tabs.add $tab
      if $link.hasClass 'active'
        @prevActiveLink = $link
        @currentTab = $tab
        $tab.show()
      else
        $tab.hide()


  events:
    'click a.tab' : '_switchTab'

  _switchTab: (e) ->
    $link = @$ e.target
    @prevActiveLink.removeClass 'active'
    $link.addClass 'active'
    @prevActiveLink = $link
    @currentTab.hide()
    @currentTab = @$tabs.filter($link.attr 'href').eq(0).show()
    e.preventDefault()
