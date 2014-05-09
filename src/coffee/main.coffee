requirejs.config
  baseUrl: './js'
  shim:
    'underscore':
      exports: '_'
    'backbone':
      deps: ['underscore', 'jquery']
      exports: 'Backbone'

  paths:
    'underscore': '../components/underscore/underscore'
    'backbone': '../components/backbone/backbone'
    'jquery': '../components/jquery/dist/jquery'


require ['app/vendors'], ->
  require ['app/app','app/collections/gists'], (App, GistsCollection) ->
    App.initialize()

    testCollection = new GistsCollection([], {url:"https://api.github.com/gists/users/mbostock/gists"})
  
    testCollection.fetch({
      success: (collection, response, options) ->
        console.log "collection:", collection, "response:", response

      error: (collection, response, options) ->
        console.log "error:", response
      })  
