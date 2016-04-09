Reflux = require 'reflux'

AuthActions = Reflux.createActions [
		'signIn',
		'signUp',
		'signOut'
	]

module.exports = AuthActions
