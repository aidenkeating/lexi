React = require 'react'

Input = React.createClass
	getDefaultProps: ->
		icon: ''
		className: ''
		type: 'text'

	handleChange: (event) -> @props.onChange @props.stateReference, event.target.value

	getValue: -> @props.value

	render: ->
		<div style={{marginTop:'10px',marginBottom:'10px'}}>
			<div className='input-title-container'>
				<div className='input-title'>
					{@props.placeholder}
				</div>
			</div>
			<input
				type={@props.type}
				placeholder={@props.placeholder}
				className={'input ' + @props.className}
				onChange={@handleChange}
				value={@getValue()}/>
		</div>

module.exports = Input
