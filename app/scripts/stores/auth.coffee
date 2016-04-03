Reflux      = require 'reflux'
Parse       = require 'parse'
Reqwest     = require 'reqwest'
Store       = require 'store'
AuthActions = require '../actions/auth'
Config      = require '../config'

AuthStore = Reflux.createStore
	listenables: [AuthActions]

	init: ->
		Parse.initialize Config.parse.applicationId,
			Config.parse.javascriptKey
		currentUser = Parse.User.current()
		@state =
			authenticated: currentUser?
			sessionToken: if currentUser? then currentUser.getSessionToken() else null
			userId: if currentUser? then currentUser.id else null

	getInitialState: -> @state

	onSignIn: (credentials) ->
		Parse.User.logIn credentials.username, credentials.password,
			success: (user) =>
				@state.authenticated = true
				@state.sessionToken = user.getSessionToken()
				@state.userId = user.id
				@trigger @state
			error: (user,err) ->
				callbacks.error()

	onSignUp: (credentials, callbacks) ->
		console.log credentials
		console.log callbacks
		user = new Parse.User
		user.set 'username', credentials.username
		user.set 'password', credentials.password
		user.set "email", credentials.email
		user.signUp null,
			success: (user) =>
				console.log "SUCCESS"
				@state.authenticated = true
				@state.sessionToken = user.getSessionToken()
				@state.userId = user.id
				@trigger @state
				callbacks.success()
			error: (user,err) ->
				callbacks.error()

module.exports = AuthStore
