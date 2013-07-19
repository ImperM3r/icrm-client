class ICRMClient.FayeClient

  constructor: (opts) ->
    @org_path = "/org/" + opts.app_key

    @client = new Faye.Client ICRMClient.Assets.faye_url, timeout: 30, retry: 3
    @client.addExtension new window.ICRMClient.FayeLogger opts.visitor

  subscribe: (path, callback, context) ->
    @client.subscribe @org_path + path, callback, context
