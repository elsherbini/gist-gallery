define [
  "backbone"
  "app/models/language"
], (Backbone, LanguageModel) ->

    class Languages extends Backbone.Collection

      model: LanguageModel
