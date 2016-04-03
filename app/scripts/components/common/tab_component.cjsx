React  = require 'react'
Button = require './button'

TabComponent = React.createClass
	getInitialState: -> visible: false

	getDefaultProps: -> className: ''

	toggleVisible: -> @setState visible:!@state.visible

	render: ->
		<div className={"component-tab-container #{@props.className}"}>
			<div className='component-tab' onClick={@toggleVisible}>
				{@props.title}
			</div>
			{<Button className='remove-button' text='Remove' onClick={@props.onRemove}/> if @props.removable}
			<div className='component-tab-body' style={if @state.visible then {maxHeight:'5000px'}}>
				<div ref='body-inner'>
					{@props.children if @state.visible}
				</div>
			</div>
		</div>

module.exports = TabComponent
