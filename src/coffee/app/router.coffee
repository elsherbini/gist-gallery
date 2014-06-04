define [
  'backbone'
  'app/views/app'
  'app/collections/gists'
  'app/views/gists'
  'app/collections/users'
  'app/views/users'], (Backbone, AppView, GistsCollection, GistsView, UsersCollection, UsersView) ->

  class Router extends Backbone.Router

    initialize: ->
      AppView.render();
      Backbone.history.start()

    routes:
      '': 'rootRequested'
      'orgs/:orgName': 'orgsGistsRequested'
      ':userName/:gistId(/)': 'singleGistRequested'
      ':userName(/)': 'usersGistsRequested'


    singleGistRequested: (userName, gistId)->
      console.log "requested gist #{userName}/#{gistId}" 

    usersGistsRequested: (userName)->
      console.log "requested gists of #{userName}"
      new UserGistsView({collection: new GistsCollection([],{url: "https://api.github.com/users/#{userName}/gists"})}).render()

    orgsGistsRequested: (orgName)->

      userCollection = new UsersCollection([],{url: "https://api.github.com/orgs/#{orgName}/members"})
      userCollection.fetch({
          success: (collection, response, options) =>
            console.log "successfully fetched #{userCollection.url}"
            @getGistsForUsers(userCollection)

          error: (collection, response, options) ->
            console.log "error:", response
        })

    getGistsForUsers: (userCollection)->

      gistsCollection = new GistsCollection

      gistsView = new GistsView({collection: gistsCollection})

      for user in userCollection.toJSON()
        gistsCollection.url = user.gists_url.match(/[^{]+/)[0] #get rid of the {/gistid} in the url
        gistsCollection.fetch({
          
          add: true
          
          remove: false

          success: (collection, response, options) ->
            console.log "successfully fetched #{user.login}'s gists"
            console.log JSON.stringify gistsCollection.toJSON()

          error: (collection, response, options) ->
            console.log "error:", response
        })

    rootRequested: ->
      @orgsGistsRequested("d3")
      