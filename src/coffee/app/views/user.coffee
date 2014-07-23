define ['backbone','text!templates/user.html'], (Backbone, userTemplate) ->

  class userView extends Backbone.View


    events: {
      "click": "clickedUser"
    }

    template: _.template(userTemplate)

    render: ->
      @$el.html @template({user: @model.toJSON()})
      return this

    initialize: ->
      @listenTo(App.vent, "stateChange", @checkYoSelf)


    clickedUser: ->
      App.vent.trigger("clickedUser", @model.get("login"))

    checkYoSelf: ->
      if @model.get("login") not in App.state.filters.users
        @$el.addClass("faded")
      if @model.get("login") in App.state.filters.users
        @$el.removeClass("faded")
      if App.state.filters.users  .length == 0
        @$el.removeClass("faded")
