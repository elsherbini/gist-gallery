define ['backbone', 'app/views/app'], (Backbone, appView) ->

  class Router extends Backbone.Router

    routes:
      ':userName/:gistId(/)': 'singleGistRequested'
      ':userName(/)': 'usersGistsRequested'

    initialize: ->
      Backbone.history.start()

    defaultAction: (actions) ->
      console.log "Unhandled route #{actions}"

    singleGistRequested: (userName, gistId)->
      console.log "requested gist #{userName}/#{gistId}" 

    usersGistsRequested: (userName)->
      console.log "requested gists of user #{userName}"
