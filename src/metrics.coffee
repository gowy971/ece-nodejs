db = require('./db') "#{__dirname}/../db/metrics"
module.exports =
  ###
  'get()'
  ----
  Returns some metrics
  ###
  get: () ->
   return [
     timestamp: new Date('2015-12-01 10:30 UTC').getTime(),
     value: 26
   ,
     timestamp: new Date('2015-12-01 10:35 UTC').getTime(),
     value: 23
   ,
     timestamp: new Date('2015-12-01 10:40 UTC').getTime(),
     value: 20
   ,
     timestamp: new Date('2015-12-01 10:45 UTC').getTime(),
     value: 19
   ,
     timestamp: new Date('2015-12-01 10:50 UTC').getTime(),
     value: 18
   ,
     timestamp: new Date('2015-12-01 10:55 UTC').getTime(),
     value: 20
   ]

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
