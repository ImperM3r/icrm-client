#= require_tree ./i18n

@ICRMClient.I18n || (@ICRMClient.I18n = {})

fallback_dict = @ICRMClient.I18n.en
dict = @ICRMClient.I18n['ru'] #[@ICRMClient.locale]

_.extend @ICRMClient.Backbone.View.prototype, {
  t: (key) =>
    tr = dict[key] or fallback_dict[key] or ''
    unless tr
      console.log "missing translation for key: #{key}"
    tr
}
