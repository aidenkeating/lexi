React = require 'react'
Tokenizer     = require('react-typeahead').Tokenizer

TypeaheadInput = React.createClass
	getDefaultProps: ->
		icon: ''
		className: ''
		type: 'text'

	handleChange: (event) ->
		console.log "CHANGE OCCURED"
		console.log @refs.typeahead.getSelectedTokens().join(' ')
		@props.onChange @props.stateReference, @refs.typeahead.getSelectedTokens().join(' ')

	getValue: -> @props.value

	render: ->
		<div style={{marginTop:'10px',marginBottom:'10px'}}>
			<div className='input-title-container'>
				<div className='input-title'>
					{@props.placeholder}
				</div>
			</div>
			<Tokenizer options={@props.options}
				ref='typeahead'
				onTokenAdd={(token) => @handleChange()}
				onTokenRemove={(token) => @handleChange()}
				maxVisible={5}
				defaultSelected={@props.value}
				customClasses={input:'input',results:'typeahead-result-container',listItem:'typeahead-result',listAnchor:'typeahead-result-anchor'}
				/>
		</div>

module.exports = TypeaheadInput
