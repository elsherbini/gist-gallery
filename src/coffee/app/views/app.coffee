define ['backbone'], (Backbone) ->

  class AppView extends Backbone.View

    el: "body"

    events: {}

    initialize: ->
      console.log("AppView initialized")

  appView = new AppView()