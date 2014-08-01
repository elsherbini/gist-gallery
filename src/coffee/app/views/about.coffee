define ['backbone','text!templates/about.html'], (Backbone, aboutTemplate) ->

  class AppView extends Backbone.View

    el: ".content"

    events: {}

    template: _.template(aboutTemplate)

    initialize: ->
      @render()

    render: ->
      @$el.html @template({})
      return this
