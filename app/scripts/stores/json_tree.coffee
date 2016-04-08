Reflux          = require 'reflux'
Reqwest         = require 'reqwest'
Store           = require 'store'
HeaderActions   = require '../actions/header_actions'
JSONTreeActions = require '../actions/json_tree'

JSONTreeStore = Reflux.createStore
	listenables: [JSONTreeActions]

	init: ->
		@state =
			enabled: false

	getInitialState: -> @state

	onToggle: ->
		@state.enabled = !@state.enabled
		@trigger @state

module.exports = JSONTreeStore
