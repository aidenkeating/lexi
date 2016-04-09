React         = require 'react'
Reflux        = require 'reflux'
Link          = require('react-router').Link
Component     = require './common/component'
Button        = require './common/button'
Anchor        = require './common/anchor'
Input         = require './common/auth_input'
AuthStore     = require '../stores/auth'
AuthActions   = require '../actions/auth'
HeaderActions = require '../actions/header_actions'
EventActions  = require '../actions/event'
EventStore    = require '../stores/event'
Config        = require '../config'

EventList = React.createClass
	mixins: [Reflux.connect(EventStore,'eventStore'),
					Reflux.connect(AuthStore,'authStore')]

	getInitialState: -> newTitle: ''

	componentWillMount: ->
		EventActions.list @state.authStore.userId
		HeaderActions.updateText Config.template.messages.list

	updateNewTitle: (event) -> @setState newTitle: event.target.value

	createEvent: -> EventActions.create @state.newTitle

	handleSignOut: -> AuthActions.signOut()

	renderEvent: (event) ->
		<div key={event.id} className='animated slideInUp' style={{marginTop:'25px'}}>
			<Component className='constrained' title={event.title}>
				<Link to={"/event/#{event.id}"}>
					<Button text='Edit'/>
				</Link>
			</Component>
		</div>

	render: ->
		<div className='auth-dialog-container'>
			<Component className='constrained' title='Create'>
				<Input type='text' placeholder='Title' value={@state.newTitle} onChange={@updateNewTitle}/>
				<div style={{height:'25px'}}/>
				<Button text='Create a new event' onClick={@createEvent}/>
			</Component>
			{@state.eventStore.eventList.map(@renderEvent)}
			{<button className='signout-button' onClick={@handleSignOut}>exit</button> if @state.authStore.authenticated}
		</div>

module.exports = EventList
