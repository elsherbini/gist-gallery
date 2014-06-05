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

      initialize: ->
        @listenTo(@, 'sync', @sortFiles)
        
      parse: (data) ->
        data = data.data if data.hasOwnProperty("data") #lol
        #but really though, when you request a single gist, it lives in res.data, whereas the list just lives in res
        id: data.id
        owner: {login: data.owner.login}
        description: data.description
        created_at: data.created_at
        updated_at: data.updated_at
        history: data.history
        files: data.files

      sync: (method, model, options) ->
        options.timeout = 8000
        options.dataType = 'jsonp'
        return Backbone.sync(method, model, options)

      sortFiles: (->)
        ###sortedFiles = @.get("files").sort((a,b) ->
         (b.filename == "index.html") - (a.filename == "index.html") || a.filename.localeCompare(b.filename) 
        )
        @.set("files") = sortedFiles;###
        

