define ['backbone','text!templates/app.html'], (Backbone, appTemplate) ->

  class AppView extends Backbone.View

    el: "body"

    events: {}

    template: _.template(appTemplate)

    render: ->
      @$el.html @template
      return this


  appView = new AppView()