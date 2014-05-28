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