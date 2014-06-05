define ['backbone','highlightjs','app/collections/gists','text!templates/gist.html'], (Backbone, hljs, GistCollection, GistTemplate) ->

  class GistView extends Backbone.View

    el: ".content"

    events: {}

    template: _.template(GistTemplate)

    initialize: (model, options)->
      @listenTo(@model, 'sync', @render)

    render: ->
      myHtml = @template {gist: @model.toJSON()}
      @$el.html myHtml
      hljs.initHighlighting()
      return this