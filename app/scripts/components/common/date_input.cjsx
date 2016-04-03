React    = require 'react'
Calendar = require 'rc-calendar'

DateInput = React.createClass
	getDefaultProps: ->
		icon: ''
		className: ''
		type: 'text'

	handleChange: (date) ->
		@props.onChange @props.stateReference, "#{date.getDayOfMonth()}/#{date.getMonth()+1}/#{date.getYear()}"

	getPlaceholder: -> "#{@props.placeholder} (#{@props.value})"

	render: ->
		<div style={{marginTop:'10px',marginBottom:'10px'}}>
			<div className='input-title-container'>
				<div className='input-title'>
					{@getPlaceholder()}
				</div>
			</div>
			<Calendar ref='calendar' formatter='dd/mm/yyyy' onChange={@handleChange} showDateInput={false} showToday={false}/>
		</div>

module.exports = DateInput
