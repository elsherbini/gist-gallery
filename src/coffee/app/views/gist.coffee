define ['backbone','highlightjs','app/collections/gists','text!templates/gist.html'], (Backbone, hljs, GistCollection, GistTemplate) ->

  class GistView extends Backbone.View

    el: ".content"

    events: {}

    template: _.template(GistTemplate)

    initialize: (model, options)->
      @listenTo(@model, 'sync', @render)
      options or options = {}
      @org = options.org?

    render: ->
      myHtml = $.parseHTML(@template {gist: @model.toJSON()})
      myHtml = $(myHtml).select('pre code').each((i,e)-> hljs.highlightBlock e )
      @$el.html myHtml
      return this