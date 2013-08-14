## Debug logger for Faye

class @ICRMClient.FayeLogger
  constructor: (args) ->
    @user_type = args.user_type
    @user_id   = args.user_id
    @app_key   = args.app_key

  incoming: (message, callback) ->
    #console.log('incoming', message)
    callback(message)

  outgoing: (message, callback) ->
    #console.log('outgoing', message)
    message.ext = user_type: @user_type, user_id: @user_id, app_key: @app_key
    callback(message)
