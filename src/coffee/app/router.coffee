define [
  'backbone'
  'app/views/app'
  'app/collections/gists'
  'app/models/gist'
  'app/views/gists'
  'app/views/gist'
  'app/collections/users'], (Backbone, AppView, GistsCollection, GistModel, GistsView, GistView, UsersCollection) ->

  class Router extends Backbone.Router

    clientId = "REDACTED"
    clientSecret = "REDACTED"
    addend = ""# "?client_id=#{clientId}&client_secret=#{clientSecret}"

    initialize: ->
      AppView.render();
      Backbone.history.start()

    routes:
      '': 'rootRequested'
      'orgs/:orgName': 'orgsGistsRequested'
      ':gistId(/)(:gistDescription)': 'singleGistRequested'

    singleGistRequested: (gistId)->
      @gistModel = gistModel = new GistModel()
      gistView = new GistView({model: gistModel})
      gistModel.url = "https://api.github.com/gists/#{gistId}"+addend
      gistModel.fetch({
        cache: true
        expires: 24*60*60

        success: (model, response, options) =>
          return
        error: (model, response, options) ->
          console.log "error:", response
        })


    orgsGistsRequested: (orgName)->

      usersCollection = new UsersCollection([],{url: "https://api.github.com/orgs/#{orgName}/members"+addend})
      usersCollection.fetch({

          expires: 24*60*60

          success: (collection, response, options) =>
            @getGistsForUsers(usersCollection, orgName)

          error: (collection, response, options) ->
            console.log "error:", response
        })

    getGistsForUsers: (usersCollection, orgName)->

      gistsCollection = new GistsCollection
      gistsCollection.org = orgName
      gistsCollection.users = usersCollection

      gistsView = new GistsView({collection: gistsCollection})

      for user in gistsCollection.users.toJSON()

        gistsCollection.url = user.gists_url.match(/[^{]+/)[0]+addend #get rid of the {/gistid} in the url

        gistsCollection.fetch({

          cache: true
          add: true
          merge: true
          remove: false
          expires: 24*60*60

          url: gistsCollection.url

          success: (collection, response, options) ->
            gistsCollection.setLanguages()

          error: (collection, response, options) ->
            console.log "error:", response
        })

    rootRequested: ->
     #@singleGistRequested("d7bf3bd67d00ed79695b")
     @orgsGistsRequested(App.state.org)

