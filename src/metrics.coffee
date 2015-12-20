db = require('./db') "#{__dirname}/../db/metrics"
module.exports =
  ###
  'get()'
  ----
  Returns some metrics
  ###
  get: (username, callback) ->
    metric = []
    rs = db.createReadStream
      gte: "metrics:#{username}:1"
    rs.on 'data', (data) ->
      value = data.value.split ":"
      metric.push(x: parseInt(value[1]), y: parseInt(value[2]))
    rs.on 'error', callback
    rs.on 'close', ->
      callback null, metric
  ###
  'save(id,metrics,callback)'
  -------------------
  Save some metrics with a given id
  Parameters :
  'id' : an integer
  ###

  save: (user, m, callback)->
    ws = db.createWriteStream()
    ws.on 'error', callback
    ws.on 'close', callback
    for metric, index in m
      {timestamp, value} = metric
      ws.write key: "metrics:#{user}:#{index+1}", value: "metrics:#{timestamp}:#{value}"
    console.log "Batch saved !"
    ws.end()

  remove: (username, id , callback)->
    toDel = "metrics:#{username}:#{id}"
    db.del toDel, callback
