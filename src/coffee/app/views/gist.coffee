define ['backbone','highlightjs','app/collections/gists','text!templates/gist.html'], (Backbone, hljs, GistCollection, GistTemplate) ->

  class GistView extends Backbone.View

    el: ".content"

    events: {}

    template: _.template(GistTemplate)

    initialize: (model, options)->
      @listenTo(@model, 'sync', @render)

    render: ->
      window.$el = @$el
      @$el.html @template {gist: @model.toJSON(), files: (info for own file,info of @model.toJSON().files).sort(@compareFiles)}
      $('pre code').each (i, block) ->
        hljs.highlightBlock(block)
      return this

    compareFiles: (a,b)->
      first = a.filename.toLowerCase()
      last = b.filename.toLowerCase()
      readme = (last is "readme.md") - (first is "readme.md")
      html = (last[-5..] is ".html") - (first[-5..] is ".html")
      js = (last[-3..] is ".js") - (first[-3..] is ".js")
      r =  (last[-2..] is ".r") - (first[-2..] is ".r")
      python = (last[-3..] is ".py") - (first[-3..] is ".py")
      css = (last[-4..] is ".css") - (first[-4..] is ".css")
      return readme || html || js || r || python || css || first.localeCompare(last)
