React         = require 'react'
Component     = require './common/component'
Button        = require './common/button'
Anchor        = require './common/anchor'
Input         = require './common/auth_input'
AuthActions   = require '../actions/auth'
HeaderActions = require '../actions/header_actions'
Config        = require '../config'

AuthDialog = React.createClass
	getInitialState: ->
		password: ''
		passwordConfirmation: ''
		username: ''
		authMode: 'signin'

	componentWillMount: ->
		HeaderActions.updateText Config.template.messages.auth.welcome
		HeaderActions.tempUpdateText Config.template.messages.welcome, 2500

	updateUsername: (event) -> @setState username: event.target.value.substr(0,25)

	updatePassword: (event) -> @setState password: event.target.value

	updatePasswordConfirmation: (event) -> @setState passwordConfirmation: event.target.value

	handleSignin: ->
		AuthActions.signIn
			username: @state.username
			password: @state.password
		false

	handleSignup: ->
		AuthActions.signUp
			username: @state.username
			password: @state.password
			passwordConfirmation: @state.passwordConfirmation,
				success: =>
					HeaderActions.tempUpdateText Config.template.message.list
					HeaderActions.tempUpdateText Config.template.messages.auth.success, 2500
				error: => HeaderActions.tempUpdateText Config.template.messages.auth.error, 2500
		false

	tabTo: (mode) -> @setState authMode: mode

	renderAuthMode: ->
		if @state.authMode == 'signin'
			<Component className='constrained animated slideInUp'>
				<div style={{height:'25px'}}/>
				<Input type='text' placeholder='Username' onChange={@updateUsername}/>
				<div style={{height:'25px'}}/>
				<Input type='password' placeholder='Password' onChange={@updatePassword}/>
				<div style={{height:'25px'}}/>
				<span>
					No account? <Anchor text='Sign up' onClick={@tabTo.bind(this,'signup')}/>
				</span>
				<div style={{height:'25px'}}/>
				<Button text='Sign in' onClick={@handleSignin}/>
			</Component>
		else if @state.authMode == 'signup'
			<Component className='constrained animated slideInUp'>
				<div style={{height:'25px'}}/>
				<Input type='text' placeholder='Username' onChange={@updateUsername}/>
				<div style={{height:'25px'}}/>
				<Input type='password' placeholder='Password' onChange={@updatePassword}/>
				<div style={{height:'25px'}}/>
				<Input type='password' placeholder='Password Confirmation' onChange={@updatePasswordConfirmation}/>
				<div style={{height:'25px'}}/>
				<span>
					Have an account? <Anchor text='Sign in' onClick={@tabTo.bind(this,'signin')}/>
				</span>
				<div style={{height:'25px'}}/>
				<Button text='Sign up' onClick={@handleSignup}/>
			</Component>
		else false

	render: ->
		<div className='auth-dialog-container'>
			{@renderAuthMode()}
		</div>

module.exports = AuthDialog
