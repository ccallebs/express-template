# Add ability to parse request body
bodyParser = require('body-parser')

# Sessions
cookieParser = require('cookie-parser')
session = require('express-session')

# Flash messages
flash = require('express-flash')

# User Auth
passport = require('passport')

express = require('express')
app = express()

# View Setup
app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'
app.set 'view options', ->
  layout: false
app.locals.basedir = __dirname + '/views';

# Asset compilation
app.use require('stylus').middleware(__dirname + '/public')

coffeeParams =
  src: __dirname + '/public'
  compress: true

app.use require('coffee-middleware')(coffeeParams)

app.use bodyParser()
app.use flash()
app.use cookieParser()
app.use session(secret: '1234567890QWERTY', key: 'sid', cookies: { secure: true })
app.use passport.initialize()
app.use passport.session()

app.use '/components', express.static(__dirname + '/bower_components')
app.use express.static(__dirname + '/public')

# Routes
require('./routes/all')(app)

server = app.listen 3000, ->
  console.log 'Listening on port 3000...'
