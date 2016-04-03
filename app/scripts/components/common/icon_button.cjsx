React = require 'react'

IconButton = React.createClass
	getDefaultProps: ->
		icon: ''
		className: ''

	render: ->
		<button style={@props.style} className={'icon-button ' + @props.className} onClick={@props.onClick}>
			<i className={'icon ' + @props.icon}/>
		</button>

module.exports = IconButton
