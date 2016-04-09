React       = require 'react'
Reflux      = require 'reflux'
Header      = require './header'
AuthStore   = require '../stores/auth'

Layout = React.createClass
	mixins: [Reflux.connect(AuthStore,'authStore')]

	render: ->
		<div className='app-container'>
			<Header/>
			<div className='app-body-container'>
				{@props.children}
			</div>
		</div>

module.exports = Layout
