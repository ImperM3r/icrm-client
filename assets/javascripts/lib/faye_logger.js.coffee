## Debug logger for Faye

@ICRMClient.FayeLogger=
  incoming: (message, callback) ->
    console.log('incoming', message)
    callback(message)

  outgoing: (message, callback) ->
    console.log('outgoing', message)
    callback(message)
