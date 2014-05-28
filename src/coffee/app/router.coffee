define [
  'backbone'
  'app/views/app'
  'app/collections/gists'
  'app/views/usersGists'
  'app/collections/users'
  'app/views/orgUsers'], (Backbone, AppView, GistsCollection, UserGistsView, UsersCollection, OrgUsersView) ->

  class Router extends Backbone.Router

    initialize: ->
      AppView.render();
      Backbone.history.start()

    routes:
      'orgs/:orgName': 'orgsGistsRequested'
      ':userName/:gistId(/)': 'singleGistRequested'
      ':userName(/)': 'usersGistsRequested'


    singleGistRequested: (userName, gistId)->
      console.log "requested gist #{userName}/#{gistId}" 

    usersGistsRequested: (userName)->
      console.log "requested gists of #{userName}"
      new UserGistsView({collection: new GistsCollection([],{url: "https://api.github.com/users/#{userName}/gists"})}).render()

    orgsGistsRequested: (orgName)->
      console.log "requested users in #{orgName}"
      new OrgUsersView({collection: new UsersCollection([],{url: "https://api.github.com/orgs/#{orgName}/members"})}).render()
