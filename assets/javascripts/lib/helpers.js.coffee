@ICRMClient.Helpers =
  linkify: (text) ->
    text.replace(/(https?:\/\/[^ ;|\\*'"!,()<>]+\/?)/g,'<a href="$1" data-link-external="true">$1</a>')
