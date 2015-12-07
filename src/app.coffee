express = require 'express'
metrics = require './metrics'
app = express()

app.set 'port', 1889
app.set 'views', "#{__dirname}/../views"
app.set 'view engine','jade'
app.use '/', express.static "#{__dirname}/../public"
app.use require('body-parser')()

app.get '/',(req,res) ->
  res.render 'index',
    locals:
      title: 'My ECE test page'

app.get '/metrics.json', (req,res) ->
  res.status(200).json  metrics.get()


app.listen app.get('port'), () ->
  console.log "server listening on #{app.get 'port'}"
