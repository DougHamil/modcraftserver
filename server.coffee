express = require 'express'
stylus = require 'stylus'
nib = require 'nib'
path = require 'path'

compile = (str, pathtofile)-> stylus(str).set('filename', pathtofile).use(nib())

app = express()

app.set 'views', path.resolve(__dirname, './views')
app.set 'view engine', 'jade'
app.use stylus.middleware(src:__dirname+'/public', compile:compile)
app.use express.static(__dirname + '/public')

app.get '/', (req, res) ->
  res.render 'index.jade'

app.get '/:pageName', (req, res)->
  if req.params.pageName != 'favicon.ico'
    res.render req.params.pageName+'.jade'
  else
    res.send('')

app.listen 9090
