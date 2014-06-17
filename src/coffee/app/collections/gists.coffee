define [
  "backbone"
  "app/models/gist"
], (Backbone, GistModel) ->

    class Gists extends Backbone.Collection

      model: GistModel

      #sort gists by the the decending update time (more recent first)
      comparator: (gist) ->
        return new Date(gist.get("updated_at")).getTime() * -1

      #allow a url to be passed in to the Gists constructor
      initialize: (models, options) ->
        options or options = {}
        @url = options.url?
        @org = options.org?

      #jsonp allows loading of json from other servers, in this case github

      sync: (method, model,options) ->
        options || options = {}
        options.timeout = 8000
        options.dataType = 'jsonp'

        return Backbone.sync(method, model, options)
           
      parse: (response) ->
        response.data
