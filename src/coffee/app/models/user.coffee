define ["backbone"], (Backbone) ->
  class User extends Backbone.Model

    defaults:
      login: ""
      id: null
      avatar_url: ""
      gravatar_id: ""
      url: ""
      html_url: ""
      gists_url: ""

    parse: (data) ->
      login: data.login
      id: data.id
      avatar_url: data.avatar_url
      gravatar_id: data.gravatar_id
      url: data.url
      html_url: data.html_url
      gists_url: data.gists_url
