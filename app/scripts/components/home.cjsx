React      = require 'react'
Reflux     = require 'reflux'
Component  = require './common/component'
Button     = require './common/button'
Anchor     = require './common/anchor'
Input      = require './common/input'
AuthDialog = require './auth_dialog'
AuthStore  = require '../stores/auth'
EventList  = require './event_list'

Home = React.createClass
	mixins: [Reflux.connect(AuthStore,'auth')]

	renderPage: ->
		if !@state.auth.authenticated
			<AuthDialog/>
		else <EventList/>

	render: ->
		<div className='home-container'>
			{@renderPage()}
		</div>

module.exports = Home
