define [
  "backbone"
  "app/models/user"
], (Backbone, UserModel) ->

    class Users extends Backbone.Collection

      model: UserModel

      initialize: (models, options) ->
        @url = options.url

      sync: (method, model, options) ->
        options.timeout = 8000
        options.dataType = 'jsonp'
        return Backbone.sync(method, model, options)

      parse: (response) ->
        response.data
