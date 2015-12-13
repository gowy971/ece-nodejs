db = require('./db') "#{__dirname}/../db/metrics"
metrics =[]
module.exports =
  ###
  'get()'
  ----
  Returns some metrics
  ###
  get: () ->
    myMetric= null
    rs = db.createReadStream()
    rs.on "data",(metric)->
      myKey = metric.key.split ":"
      myMetric = {x : parseInt(myKey[2]), y:parseInt(metric.value)}
      metrics.push myMetric
    return metrics
  ###
  'save(id,metrics,callback)'
  -------------------
  Save some metrics with a given id
  Parameters :
  'id' : an integer
  ###
  save: (id, metrics, callback) ->
    ws = db.createWriteStream()
    ws.on 'error', callback
    ws.on 'close', callback
    for m in metrics
      {timestamp, value} = m
      ws.write key: "metric:#{id}:#{timestamp}", value: value
    ws.end()
