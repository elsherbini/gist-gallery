define [
  'backbone'
  'app/views/app'
  'app/collections/gists'
  'app/models/gist'
  'app/views/gists'
  'app/views/gist'
  'app/collections/users'
  'app/views/users'], (Backbone, AppView, GistsCollection, GistModel, GistsView, GistView, UsersCollection, UsersView) ->

  class Router extends Backbone.Router

    initialize: ->
      AppView.render();
      Backbone.history.start()

    routes:
      '': 'rootRequested'
      'orgs/:orgName': 'orgsGistsRequested'
      ':gistId(/)': 'singleGistRequested'

    singleGistRequested: (gistId)->
      @gistModel = gistModel = new GistModel()
      gistView = new GistView({model: gistModel})
      gistModel.url = "https://api.github.com/gists/#{gistId}"
      gistModel.fetch({
        success: (model, response, options) =>
          console.log "successfully fetched gist #{gistId}"
        error: (model, response, options) ->
          console.log "error:", response
        })


    orgsGistsRequested: (orgName)->

      usersCollection = new UsersCollection([],{url: "https://api.github.com/orgs/#{orgName}/members"})
      usersCollection.fetch({
          success: (collection, response, options) =>
            console.log "successfully fetched #{usersCollection.url}"
            @getGistsForUsers(usersCollection, orgName)

          error: (collection, response, options) ->
            console.log "error:", response
        })

    getGistsForUsers: (usersCollection, orgName)->

      window.gistsCollection = gistsCollection = new GistsCollection
      gistsCollection.org = orgName

      window.gistsView = gistsView = new GistsView({collection: gistsCollection})

      for user in usersCollection.toJSON()

        gistsCollection.url = user.gists_url.match(/[^{]+/)[0] #get rid of the {/gistid} in the url
        
        gistsCollection.refreshFromServer({
          
          url: gistsCollection.url

          add: true

          merge: true
          
          remove: false

          success: (collection, response, options) ->
            console.log "successfully fetched some gists"
            #gistsCollection.each( (model) -> model.save())

          error: (collection, response, options) ->
            console.log "error:", response
        })

    rootRequested: ->
     #@singleGistRequested("d7bf3bd67d00ed79695b")
     @orgsGistsRequested("d3")
      