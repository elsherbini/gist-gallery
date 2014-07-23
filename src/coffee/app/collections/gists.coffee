define [
  "backbone"
  "app/models/gist"
  "app/models/language"
  "app/collections/languages"
], (Backbone, GistModel, LanguageModel, LanguagesCollection) ->

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
        @languages = new LanguagesCollection()

      #jsonp allows loading of json from other servers, in this case github

      sync: (method, model,options) ->
        options || options = {}
        options.timeout = 8000
        options.dataType = 'jsonp'
        options.validate = true
        return Backbone.sync(method, model, options)

      parse: (response) ->
        (gist for gist in response.data when gist.files.hasOwnProperty("_include") is true)

      setLanguages: ->
        for gist in @toJSON()
          for language in gist.languages
            @languages.push new LanguageModel({name:language}) if not @languages.findWhere({name:language})? and language isnt "Markdown"
