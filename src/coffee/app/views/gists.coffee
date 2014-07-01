define ['backbone','app/collections/gists','text!templates/gists.html'], (Backbone, GistsCollection, GistsTemplate) ->

  class GistsView extends Backbone.View

    el: ".content"

    events: {
      'click div.user': 'filterCollectionByUser'
      'click div#resetFilters': 'resetFilters'
    }

    template: _.template(GistsTemplate)

    initialize: (models, options)->
      @listenTo(@collection, 'sync', @render)
      @listenTo(@collection, 'sync', @saveCollection)

    render: ->
      console.log("i rendered?")
      myHtml = @template {gists: @collection.toJSON(), org: @collection.org || "", users: @collection.users}
      @$el.html myHtml
      return this

    filterCollectionByUser: (e)->
      username = e.currentTarget.id
      filteredGists = @wholeCollection.filter((gist) -> gist.get("owner").login == username)
      console.log filteredGists
      @collection = new GistsCollection(filteredGists)
      @collection.users = @wholeCollection.users
      @collection.org = @wholeCollection.org
      @render()

    saveCollection: ->
      @wholeCollection = @collection

    resetFilters: ->
      @collection = @wholeCollection
      @render()