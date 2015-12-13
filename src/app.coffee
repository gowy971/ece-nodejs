express = require 'express'
metrics = require './metrics'
app = express()

app.set 'port', 1337
app.set 'views', "#{__dirname}/../views"
app.set 'view engine','jade'
app.use '/', express.static "#{__dirname}/../public"
session = require 'express-session'
LevelStore = require('level-session-store')(session)
app.use require('body-parser')()
app.use session
  secret: 'MyAppSecret'
  store: new LevelStore './db/sessions'
  resave: true
  saveUninitialized: true

app.get '/metrics.json', (req,res) ->
  res.status(200).json  metrics.get()

app.get '/', (req,res) ->
  res.render 'index'

app.get '/login', (req, res) ->
  res.render 'login'

app.post 'login', (req, res) ->
  user.get req.body.username, (err, data) ->
    return next err if err
    unless res.redirect '/login'
    else
      req.session.loggedIn = true
      req.session.username = data.username
      res.redirect '/'

app.get '/logout', (req, res) ->
  delete req.session.loggedIn
  delete req.session.username
  res.redirect '/login'

app.listen app.get('port'), () ->
  console.log "server listening on #{app.get 'port'}"
