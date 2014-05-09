define ['backbone', 'app/views/app'], (Backbone, AppView) ->

  class Router extends Backbone.Router

    initialize: ->
      AppView.render();
      Backbone.history.start()

    routes:
      ':userName/:gistId(/)': 'singleGistRequested'
      ':userName(/)': 'usersGistsRequested'



    singleGistRequested: (userName, gistId)->
      console.log "requested gist #{userName}/#{gistId}" 

    usersGistsRequested: (userName)->
      console.log "requested gists of user #{userName}"
