React = require 'react'

Anchor = React.createClass
	getDefaultProps: ->
		text: ''
		className: ''
	render: ->
		<button className={'anchor ' + @props.className} onClick={@props.onClick}>
			{@props.text}
		</button>

module.exports = Anchor
