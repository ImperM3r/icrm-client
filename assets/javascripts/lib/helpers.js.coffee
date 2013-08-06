@ICRMClient.Helpers =
  linkify: (text) ->
    text.replace(/(https?:\/\/[^ ;|\\*'"!,()<>]+\/?)/g,'<a href="$1">$1</a>')
