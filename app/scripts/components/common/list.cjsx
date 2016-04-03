React   = require 'react'

List = React.createClass
	render: ->
		<div>
			{@props.value}
		</div>

module.exports = List
