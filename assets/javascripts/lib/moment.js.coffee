#= require moment/min/moment.min
#= require moment/min/langs.min

_locale = ->
  if window.navigator? && window.navigator.language?
    window.navigator.language.substr 0, 2
  else if window.clientInformation?
    window.clientInformation.browserLanguage.substr 0, 2
  else
    'en'

moment.lang _locale()
