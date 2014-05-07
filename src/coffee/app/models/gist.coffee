define [
  "backbone"
], (Backbone) ->

    class Gist extends Backbone.Model

      defaults:
        
        id: NaN
        owner: {login: ""}
        description: ""
        created_at: ""
        updated_at: ""
        history: [{version: ""}]
        files: {}
