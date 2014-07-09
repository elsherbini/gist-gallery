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
        @languages = []

      #jsonp allows loading of json from other servers, in this case github

      sync: (method, model,options) ->
        options || options = {}
        options.timeout = 8000
        options.dataType = 'jsonp'

        return Backbone.sync(method, model, options)

      parse: (response) ->
        response.data

      setLanguages: ()->
        for gist in @toJSON()
          for language in gist.languages
            @languages.push language if language not in @languages and language isnt "Markdown"
        console.log @languages

