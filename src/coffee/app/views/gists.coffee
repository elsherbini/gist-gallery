define ['backbone','app/collections/gists','text!templates/gists.html'], (Backbone, GistCollection, GistsTemplate) ->

  class GistsView extends Backbone.View

    el: ".content"

    events: {}

    template: _.template(GistsTemplate)

    initialize: (models, options)->
      @listenTo(@collection, 'sync', @render)

    render: ->
      console.log JSON.stringify(@collection)
      myHtml = @template {gists: @collection.toJSON()}
      @$el.html myHtml
      return this