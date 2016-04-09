Reflux             = require 'reflux'
_                  = require 'underscore'
Parse              = require 'parse'
Reqwest            = require 'reqwest'
Store              = require 'store'
EventActions       = require '../actions/event'
Utils              = require '../utils/main'
Config             = require '../config'

EventStore = Reflux.createStore
	listenables: [EventActions]

	init: ->
		Parse.initialize Config.parse.applicationId,
			Config.parse.javascriptKey
		@state =
			eventList: []
			event: null

	getInitialState: -> @state

	onList: (userId) ->
		@state.eventList = []
		Query = new Parse.Query 'Event'
		Query.equalTo 'owner', Parse.User.current()
		Query.find
			success: (results) =>
				for eventObj in results
					@state.eventList.push
						id: eventObj.id
						title: eventObj.get('title')
				@trigger @state
			error: (err) ->
				console.log err

	onCreate: (title) ->
		Event = Parse.Object.extend 'Event'
		structTemplate = Config.template.defaultStruct
		structTemplate.name = title
		structTemplate.nameLowercase = title.toLowerCase()
		newEvent = new Event
		newEvent.set 'title', title
		newEvent.set 'owner', Parse.User.current()
		newEvent.set 'payload', structTemplate
		newEvent.save null,
			success: (event) =>
				@state.eventList.unshift
					id: event.id
					title: event.get 'title'
				@trigger @state
			error: (event, error) ->
				console.log error

	onGet: (eventId) ->
		Query = new Parse.Query 'Event'
		Query.get eventId,
			success: (event) =>
				@state.event =
					id: event.id
					title: event.get 'title'
					payload: event.get 'payload'
				@trigger @state
			error: (err) ->
				console.log err

	onUpdate: (eventId, callbacks) ->
		Query = new Parse.Query 'Event'
		Query.get eventId,
			success: (event) =>
				event.set 'payload',@state.event.payload
				event.save null,
					success: (event) ->
						console.log "Save success"
						callbacks.success()
						@trigger @state
					error: (event, error) ->
						console.log "Save error"
						callbacks.error()
						@trigger @state
				@trigger @state
			error: (err) ->
				console.log err

	onDelete: (eventId) ->
		Query = new Parse.Query 'Event'
		Query.get eventId,
			success: (event) =>
				event.destroy
					success: (event) =>
						@onList event.get('owner').id
					error: (event, error) ->
						console.log "Destroy fail"
				@trigger @state
			error: (err) ->
				console.log err

module.exports = EventStore
