React  = require 'react'
Header = require './header'

Layout = React.createClass
	render: ->
		<div className='app-container'>
			<Header/>
			<div className='app-body-container'>
				{@props.children}
			</div>
		</div>

module.exports = Layout
