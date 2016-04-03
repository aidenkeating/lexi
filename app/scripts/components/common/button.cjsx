React = require 'react'

Button = React.createClass
	getDefaultProps: ->
		text: ''
		className: ''
	render: ->
		<button className={'button ' + @props.className} onClick={@props.onClick}>
			{@props.text}
		</button>

module.exports = Button
