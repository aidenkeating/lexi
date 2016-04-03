React  = require 'react'

NoMatch = React.createClass
	render: ->
		<div className="no-match-container">
			<h1>
				Oops! No page here!
			</h1>
		</div>

module.exports = NoMatch
