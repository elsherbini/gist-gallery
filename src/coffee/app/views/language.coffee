define ['backbone','text!templates/language.html'], (Backbone, languageTemplate) ->

  class languageView extends Backbone.View

    className: 'language'

    events: {
      "click": "clickedLanguage"
    }

    template: _.template(languageTemplate)

    initialize: ->
      @listenTo(App.vent, "stateChange", @checkYoSelf)

    render: ->
      @$el.html @template({language: @model.toJSON()})
      return this

    clickedLanguage: ->
      App.vent.trigger("clickedLanguage", @model.get("name"))

    checkYoSelf: ->
      if @model.get("name") not in App.state.filters.languages
        @$el.addClass("faded")
      if @model.get("name") in App.state.filters.languages
        @$el.removeClass("faded")
      if App.state.filters.languages.length == 0
        @$el.removeClass("faded")

