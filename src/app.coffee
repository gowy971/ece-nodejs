express = require 'express'
metrics = require './metrics'
user = require './user'
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

authCheck = (req, res, next) ->
  unless req.session.loggedIn == true
    res.redirect '/login'
  else
    next()

app.get '/', authCheck, (req, res) ->
  res.render 'index', name: req.session.username

app.post '/insert', (req,res)->
  met =
  [
    {
      timestamp: req.body.timestamp1,
      value: req.body.value1
    },
    {
      timestamp: req.body.timestamp2,
      value: req.body.value2,
    },
    {
      timestamp:req.body.timestamp3,
      value: req.body.value2
    }
  ]
  metrics.save req.session.username, met, (err)->
    if err
      res.status(500)
    else
      res.status(200)


app.get '/metrics.json', (req,res) ->
   metrics.get req.session.username, (err, metric)->
       res.status(200).json metric

app.get '/login', (req, res) ->
  res.render 'login'

app.get '/signup', (req, res) ->
  res.render 'signup'

app.post '/login', (req, res) ->
  user.get req.body.username, (err, data) ->
    return next err if err
    unless req.body.password == data.password
      res.redirect('/login')
    else
      req.session.loggedIn = true
      req.session.username = data.username
      res.redirect '/'

app.post '/signup', (req, res) ->
  user.save req.body.username, req.body.password, req.body.name, req.body.email, (err) ->
    res.redirect('/signup') if err
    res.redirect '/login'

app.get '/logout', (req, res) ->
  delete req.session.loggedIn
  delete req.session.username
  res.redirect '/login'


app.listen app.get('port'), () ->
  console.log "server listening on #{app.get 'port'}"
