React = require 'react'

NumberInput = React.createClass
	getDefaultProps: ->
		icon: ''
		className: ''
		type: 'text'

	handleChange: (event) -> @props.onChange @props.stateReference, parseInt(event.target.value.replace(/[^\d.-]/g, ''))

	getValue: -> @props.value

	render: ->
		<div style={{marginTop:'10px',marginBottom:'10px'}}>
			<div className='input-title-container'>
				<div className='input-title'>
					{@props.placeholder}
				</div>
			</div>
			<input
				ref='input'
				type='number'
				placeholder={@props.placeholder}
				className={'input ' + @props.className}
				onChange={@handleChange}
				value={@getValue()}/>
		</div>

module.exports = NumberInput
