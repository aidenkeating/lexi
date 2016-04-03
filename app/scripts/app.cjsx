#From node_modules
React                = require 'react'
ReactRouter          = require 'react-router'
ReactDOM             = require 'react-dom'
createBrowserHistory = require 'history/lib/createBrowserHistory'

Layout  = require './components/layout'
Home    = require './components/home'
Event   = require './components/event'
NoMatch = require './components/nomatch'

Router       = ReactRouter.Router
Route        = ReactRouter.Route
Routes       = Router.Routes
DefaultRoute = Router.DefaultRoute

history = createBrowserHistory()

routes = (
	<Route component={Layout}>
		<Route path='/' component={Home}/>
		<Route path='/event/:id' component={Event}/>
		<Route path="*" component={NoMatch}/>
	</Route>
)

ReactDOM.render((<Router history={history}>{routes}</Router>), document.getElementById('content'))
