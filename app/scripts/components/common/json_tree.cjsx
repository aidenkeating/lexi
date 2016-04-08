React           = require 'react'
Reflux          = require 'reflux'
JSONTree        = require 'react-json-tree'
JSONTreeStore   = require '../../stores/json_tree'

Input = React.createClass
	mixins: [Reflux.connect(JSONTreeStore,'jsonTreeStore')]

	getDefaultProps: ->
		icon: ''
		className: ''
		type: 'text'

	handleChange: (event) -> @props.onChange @props.stateReference, event.target.value

	getValue: -> @props.value

	render: ->
		<div style={{textAlign:'left'}} className={this.props.className}>
			{<JSONTree.default data={this.props.data}/> if @state.jsonTreeStore.enabled}
		</div>

module.exports = Input
