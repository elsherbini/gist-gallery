requirejs.config
  baseUrl: './js'
  shim:
    'underscore':
      exports: '_'
    'backbone':
      deps: ['underscore', 'jquery']
      exports: 'Backbone'
    'bootstrap':
      deps: ['jquery']

  paths:
    'underscore': '../components/underscore/underscore'
    'backbone': '../components/backbone/backbone'
    'jquery': '../components/jquery/dist/jquery'
    'bootstrap': '../components/bootstrap/dist/js/bootstrap'
    'text': '../components/requirejs-text/text'
    'templates': '../templates'


require ['app/vendors'], ->
  require ['app/app','app/collections/gists','app/views/usersGists'], (App, GistsCollection, UserGistsView) ->
    App.initialize()

    testCollection = new GistsCollection
  
    testCollection.fetch({
      success: (collection, response, options) ->
        console.log "collection:", collection, "response:", response

      error: (collection, response, options) ->
        console.log "error:", response
      })

    myView = new UserGistsView({collection: testCollection})
    console.log myView.collection