define ['app/router'], (Router) ->

  router = null

  initialize = ->

    App = window.App = {}
    App.vent = _.extend({}, Backbone.Events)
    App.state =
      org: "gistgallerytest"
      filters:
        users: []
        languages: []

    App.helpers =
      toggle: (item, array) ->

        if item in array
          array.splice(array.indexOf(item), 1)
        else
          array.push item

    App.vent.on "clickedUser", (login)->
      App.helpers.toggle(login, App.state.filters.users)
      App.vent.trigger("stateChange")

    App.vent.on "clickedLanguage", (language)->
      App.helpers.toggle(language, App.state.filters.languages)
      App.vent.trigger("stateChange")

    App.vent.on "resetFilters", ->
      for own category of App.state.filters
        App.state.filters[category] = []
      App.vent.trigger("stateChange")

    router = new Router()

  {router: router, initialize: initialize}
