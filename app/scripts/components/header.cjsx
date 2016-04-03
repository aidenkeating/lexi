React       = require 'react'
Reflux      = require 'reflux'
Button      = require './common/button'
Component   = require './common/component'
HeaderStore = require '../stores/header_store'

Header = React.createClass
	mixins: [Reflux.connect(HeaderStore,'headerStore')]
	render: ->
		<div className='header-container animated slideInDown'>
			<Component className='header constrained'>
				<div className='brand-image-container'>
					<div className='brand-image'/>
				</div>
				<div className='header-message'>
					{@state.headerStore.text}
				</div>
			</Component>
		</div>

module.exports = Header
