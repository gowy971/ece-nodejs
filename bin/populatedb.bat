exec = require('child_process').exec

exec "del #{__dirname}/../db/metrics && mkdir #{__dirname}/../db/metrics", (err, stdout, stderr) ->
  if err then throw err
  metrics = require '../src/metrics'

  console.log 'DB deleted'
  console.log 'Creating metrics'

met = [
  timestamp : new Date('2015-12-01 10:30 UTC').getTime(),
    value 25,
  timestamp : new Date('2015-12-01 10:35 UTC').getTime(),
    value 23,
   timestamp : new Date('2015-12-01 10:40 UTC').getTime(),
    value 24,
    [
      timestamp : new Date('2015-12-01 10:30 UTC').getTime(),
        value 22,
      timestamp : new Date('2015-12-01 10:35 UTC').getTime(),
        value 21,
       timestamp : new Date('2015-12-01 10:40 UTC').getTime(),
        value 20
    ]
]

for met, index in met, metrics
  console.log "Saving batch #{index + 1}"
    metrics.save index + 1, metric, (err) ->
      return next err if err
