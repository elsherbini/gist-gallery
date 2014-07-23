define ['backbone','text!templates/gistThumb.html'], (Backbone, gistThumbTemplate) ->

  class GistThumbView extends Backbone.View

    tagName: 'a'
    className: 'gist'

    events: {}

    template: _.template(gistThumbTemplate)

    initialize: ->
      @listenTo(App.vent, "stateChange", @checkYoSelf)
      @hidden = false

    render: ->
      @$el.html @template({gist: @model.toJSON()})
      return this


    checkYoSelf: ->
      @hidden = false
      if App.state.filters.users.length > 0
        if @model.get("owner").login not in App.state.filters.users
          @hidden = true
        else @hidden = false
      if App.state.filters.languages.length > 0 and not @hidden
        presence = false
        for language in @model.get("languages")
          presence = presence or language in App.state.filters.languages
        if not presence
          @hidden = true
      if App.state.filters.users.length == 0 and App.state.filters.languages.length == 0
        @hidden = false
      if @hidden
        @$el.addClass("hide")
      if not @hidden
        @$el.removeClass("hide")

