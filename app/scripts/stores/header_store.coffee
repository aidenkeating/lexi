Reflux        = require 'reflux'
Reqwest       = require 'reqwest'
Store         = require 'store'
HeaderActions = require '../actions/header_actions'

HeaderStore = Reflux.createStore
	listenables: [HeaderActions]

	init: ->
		@state =
			text: ''

	getInitialState: -> @state

	onUpdateText: (text) ->
		@state.text = text
		@trigger @state

	onTempUpdateText: (text,time) ->
		oldText = @state.text
		@state.text = text
		@trigger @state
		setTimeout (=>
			@state.text = oldText
			@trigger @state),
			time

module.exports = HeaderStore
