define ['backbone','text!templates/usersGists.html'], (Backbone, UsersGistsTemplate) ->

  class UsersGistsView extends Backbone.View

    el: ".content"

    events: {}

    template: _.template(UsersGistsTemplate, this)

    render: ->
      @$el.html @template
      return this