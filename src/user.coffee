db = require('./db') "#{__dirname}/../db/user"
module.exports =
  get: (username, callback) ->
    rs = db.createReadStream
      gte: "user:#{username}"
    user =null
    rs.on 'data', (data) ->
      key = data.key.split ":"
      properties = data.value.split ":"
      user = {username : key[1], password:properties[1], name:properties[2],email:properties[3]}
      return user
    rs.on 'error', callback
    rs.on 'close', ->
      callback null, user

  save: (username, password, name, email, callback) ->
    ws = db.createWriteStream()
    ws.write key: "user:#{username}", value: "user:#{password}:#{name}:#{email}"
    ws.end()

  # TODO: delete a user by username
# We won't do update
