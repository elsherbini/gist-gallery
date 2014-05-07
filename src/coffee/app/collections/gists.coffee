define [
  "backbone"
  "models/gist"
], (Backbone, GistModel) ->

    class Gists extends Backbone.Collection

      model: GistModel

