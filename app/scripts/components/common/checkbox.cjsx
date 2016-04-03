React = require 'react'

CheckBox = React.createClass
	handleChange: (event) -> @props.onChange @props.stateReference, !@props.value

	render: ->
		<div>
			<div className='input-title-container'>
				<div className='input-title'>
					{@props.placeholder}
				</div>
			</div>
			<button style={this.props.style} className={'checkbox ' + @props.className} onClick={@handleChange}>
				<i className={'icon ' + (if @props.value then 'ion-toggle-filled' else 'ion-toggle')}/>
			</button>
		</div>

module.exports = CheckBox
