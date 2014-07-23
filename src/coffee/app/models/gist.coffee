define [
  "backbone"
  ], (Backbone) ->
    class Gist extends Backbone.Model

      defaults:
        id: null
        owner: {login: ""}
        description: ""
        created_at: ""
        updated_at: ""
        history: [{version: ""}]
        files: {}
        languages: []

      parse: (data) ->
        data = data.data if data.hasOwnProperty("data") #lol
        #but really though, when you request a single gist, it lives in res.data, whereas the list just lives in res
        {
          id: data.id
          owner: {login: data.owner.login, }
          description: data.description
          created_at: data.created_at
          updated_at: data.updated_at
          history: data.history
          files: data.files
          languages: (info.language for own file,info of data.files when info.language?)
        }

      validate: (attrs, options)->
        if attrs.files.hasOwnProperty("_include") is false
          return "not intended to be included"

      sync: (method, model, options) ->
        options || options = {}
        options.timeout = 8000
        options.dataType = 'jsonp'
        options.validate = true
        return Backbone.sync(method, model, options)



