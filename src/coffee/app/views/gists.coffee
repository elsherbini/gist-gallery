define [
  'backbone'
  'app/collections/gists'
  'text!templates/gists.html'
  "app/views/gistThumb"
  'app/views/user'
  'app/views/language'], (Backbone, GistsCollection, GistsTemplate, GistThumbView, UserView, LanguageView) ->

  class GistsView extends Backbone.View

    el: ".content"

    events: {
      "click #resetFilters": "resetFilters"
    }

    template: _.template(GistsTemplate)

    initialize: (models, options)->
      @listenTo(@collection, 'sync', @render)
      @listenTo(App.vent, "stateChange", @checkYoSelf)

    render: ->
      templateHtml = @template {org: @collection.org || ""}
      @$el.html templateHtml

      gistsContainer = document.createDocumentFragment()
      @collection.each((gist)->
        gistsContainer.appendChild(new GistThumbView({model: gist}).render().el) )

      usersContainer = document.createDocumentFragment()
      @collection.users.each((user)->
        usersContainer.appendChild(new UserView({model: user}).render().el) )

      languagesContainer = document.createDocumentFragment()
      @collection.languages.each((language)->
        languagesContainer.appendChild(new LanguageView({model: language}).render().el) )

      @$el.find(".gistThumbs").append gistsContainer
      @$el.find(".users").append usersContainer
      @$el.find(".languages").append languagesContainer

      return this

    checkYoSelf: ->
      if App.state.filters.users.length or App.state.filters.languages.length
        @$el.find("#resetFilters").removeClass("invisible")
      else
        @$el.find("#resetFilters").addClass("invisible")

    resetFilters: ->
      App.vent.trigger("resetFilters")

