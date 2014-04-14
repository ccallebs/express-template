mongoose = require 'mongoose'
mongoose.connect 'mongodb://localhost/APPLICATION_NAME'

db = mongoose.connection

db.on 'error', ->
  console.log 'Database connection error.'

db.once 'open', ->
  console.log 'Successfully connected to database.'

module.exports = ->
  mongoose
