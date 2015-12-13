db = require('./db') "#{__dirname}/../db/user"
module.exports =
  get: (username, callback) ->
    user = {}
    rs = db.createReadStream
      gte: "user:#{username}"
    rs.on 'data', (data) ->
    # parsing logic
    rs.on 'error', callback
    rs.on 'close', ->
      callback null, user

  save: (username, password, name, email, callback) ->
      # TODO: save a user by username
  remove: (username, callback) ->
  # TODO: delete a user by username
# We won't do update
