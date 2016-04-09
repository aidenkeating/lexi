Reflux = require 'reflux'

EventActions = Reflux.createActions [
		'create',
		'list',
		'get',
		'update',
		'delete'
	]

module.exports = EventActions
