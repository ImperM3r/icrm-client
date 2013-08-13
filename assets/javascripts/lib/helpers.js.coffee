@ICRMClient.Helpers =
  linkify: (text) ->
    text.replace(/(https?:\/\/[^ ;|\\*'"!,()<>]+\/?)/g,'<a href="$1" data-link-external="true">$1</a>')

  msgDate: (date) ->
    return '' unless moment = window.moment
    return date unless moment(date).isValid()
    if moment(date).isBefore(moment().startOf('day'))
      moment(date).format('ll')
    else
      moment(date).format('LT')
