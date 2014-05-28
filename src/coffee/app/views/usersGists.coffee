define ['backbone','app/collections/gists','text!templates/usersGists.html'], (Backbone, GistCollection, UsersGistsTemplate) ->

  class UsersGistsView extends Backbone.View

    el: ".content"

    events: {}

    template: _.template(UsersGistsTemplate)

    initialize: (models, options)->

      @collection.fetch({
      success: (collection, response, options) ->
        console.log "success"

      error: (collection, response, options) ->
        console.log "error:", response
      })

      @listenTo(@collection, 'sync', @render)

    render: ->
      console.log JSON.stringify(@collection)
      myHtml = @template {gists: @collection.toJSON()}
      @$el.html myHtml
      return this