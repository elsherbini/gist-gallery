define [
  "backbone"
  "app/models/gist"
], (Backbone, GistModel) ->

    class Gists extends Backbone.Collection

      model: GistModel

      initialize: (models, options) ->
        @url = options.url

      sync: (method, model, options) ->
        options.timeout = 8000
        options.dataType = 'jsonp'
        return Backbone.sync(method, model, options)
      
      parse: (response) ->
        response.data
