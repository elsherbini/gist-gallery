define ['app/router'], (Router) ->

  app = null

  initialize = ->
    app = new Router()
  
  {router: app, initialize: initialize}