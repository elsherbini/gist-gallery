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
    'highlightjs':
      exports: 'hljs'
    'showdown':
      exports: 'Showdown'
    'backbone-fetch-cache':
      deps: ['backbone','underscore']

  paths:
    'underscore': '../components/underscore/underscore'
    'backbone': '../components/backbone/backbone'
    'backbone-fetch-cache': '../components/backbone-fetch-cache/backbone.fetch-cache'
    'jquery': '../components/jquery/dist/jquery'
    'bootstrap': '../components/bootstrap/dist/js/bootstrap'
    'text': '../components/requirejs-text/text'
    'highlightjs': '../components/highlightjs/highlight.pack'
    'showdown': '../components/showdown/compressed/showdown'
    'templates': '../templates'


require ['app/vendors'], ->
  require ['app/app'], (App) ->
    App.initialize()