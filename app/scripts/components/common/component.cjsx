React = require 'react'

Component = React.createClass
	getDefaultProps: -> className: ''

	renderTitle: ->
		if @props.title?
			<div className='component-title'>
				{@props.title}
			</div>
		else false

	render: ->
		<div className={'component ' + @props.className}>
			{@renderTitle()}
			{@props.children}
		</div>

module.exports = Component
