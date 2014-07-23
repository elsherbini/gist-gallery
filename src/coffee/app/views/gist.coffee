define ['backbone','highlightjs','app/collections/gists','text!templates/gist.html'], (Backbone, hljs, GistCollection, GistTemplate) ->

  class GistView extends Backbone.View

    el: ".content"

    events: {}

    template: _.template(GistTemplate)

    initialize: (model, options)->
      @listenTo(@model, 'sync', @render)

    render: ->
      window.$el = @$el
      @$el.html @template {gist: @model.toJSON()}
      $('pre code').each (i, block) ->
        hljs.highlightBlock(block)
      return this
