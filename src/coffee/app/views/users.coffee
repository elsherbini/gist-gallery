define ['backbone','app/collections/users','text!templates/users.html'], (Backbone, UserCollection, UsersTemplate) ->

  class UsersGistsView extends Backbone.View

    el: ".content"

    events: {}

    template: _.template(UsersTemplate)

    initialize: (models, options)->

      @collection.fetch({

      cache: true 
      
      success: (collection, response, options) ->
        console.log "success"

      error: (collection, response, options) ->
        console.log "error:", response
      })

      @listenTo(@collection, 'sync', @render)

    render: ->
      console.log JSON.stringify(@collection)
      myHtml = @template {users: @collection.toJSON()}
      @$el.html myHtml
      return this