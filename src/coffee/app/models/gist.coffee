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
        
      parse: (data) ->
        id: data.id
        owner: {login: data.owner.login}
        description: data.description
        created_at: data.created_at
        updated_at: data.updated_at
        history: data.history
        files: data.files

