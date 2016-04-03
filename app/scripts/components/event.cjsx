React              = require 'react'
Reflux             = require 'reflux'
_                  = require 'underscore'
Component          = require './common/component'
TabComponent       = require './common/tab_component'
Button             = require './common/button'
Input              = require './common/input'
TitleCase          = require 'title-case'
CheckBox           = require './common/checkbox'
EventActions       = require '../actions/event'
HeaderActions      = require '../actions/header_actions'
EventStore         = require '../stores/event'
Utils              = require '../utils/main'
List               = require './common/list'
TypeaheadInput     = require './common/typeahead_input'
Config             = require '../config'
NumberInput        = require './common/number_input'
DateInput          = require './common/date_input'

Event = React.createClass
	mixins: [Reflux.connect(EventStore,'eventStore')]

	typeToComponent:
		'string': Input
		'boolean': CheckBox
		'number': NumberInput
		'array': List

	componentWillMount: ->
		EventActions.get @props.params.id
		HeaderActions.updateText Config.template.messages.item

	save: -> EventActions.update @state.eventStore.event.id,
		success: => HeaderActions.tempUpdateText Config.template.messages.save.success, 2500
		error: => HeaderActions.tempUpdateText Config.template.messages.save.error, 2500

	getEventTitle: ->
		if @state.eventStore.event?
			@state.eventStore.event.title
		else 'Loading . . .'

	updateActive: ->
		newState = _.extend {}, @state
		newState.eventStore.event.payload.active = !newState.eventStore.event.payload.active
		@setState newState

	updateAvailable: ->
		newState = _.extend {}, @state
		newState.eventStore.event.payload.available = !newState.eventStore.event.payload.available
		@setState newState

	updateState: (reference, value) ->
		newState = _.extend {}, @state
		Utils.assign newState.eventStore.event.payload, reference, value
		@setState newState

	getValue: (reference) -> Utils.resolve reference.join('.'), @state.eventStore.event.payload

	payloadExists: -> @state.eventStore.event? && @state.eventStore.event.payload?

	renderComponent: (obj) ->
		obj.path.push(obj.key) if obj.key?
		if obj.type == 'array'
			@renderList obj.path, obj.key
		else if obj.key == 'date' or obj.key in Config.template.dates
			<DateInput stateReference={obj.path}
				placeholder={TitleCase(obj.key)}
				onChange={@updateState}
				value={@getValue(obj.path)}/>
		else if TitleCase(obj.key).toLowerCase().indexOf('css') > -1
			<TypeaheadInput stateReference={obj.path}
				value={@getValue(obj.path).split(' ')}
				placeholder={TitleCase(obj.key)}
				onChange={@updateState}
				options={Config.template.cssClasses}/>
		else
			React.createElement @typeToComponent[obj.type],
				placeholder: TitleCase(obj.key)
				stateReference: obj.path
				key: obj.key
				value: if obj.type == 'array' then @renderTab(obj.path,TitleCase(obj.key),false) else @getValue(obj.path)
				onChange: @updateState

	renderTab: (path,tabTitle,removable) ->
		tabValues = []
		if typeof(@getValue(path)) == 'string'
			tabValues.push({val:@getValue(path),path:path.slice(0),type:'string'})
		else
			for k, v of @getValue(path)
				if Array.isArray(v) || typeof(v) != 'object'
					if typeof(v) != 'object' then type = typeof(v) else type = 'array'
					tabValues.push({key:k,val:v,path:path.slice(0),type:type})
		<TabComponent title={tabTitle} removable={removable} onRemove={@removeFromStruct.bind(@,path)}>
			{tabValues.map(@renderComponent)}
		</TabComponent>

	renderList: (path, listTitle) ->
		listValues = []
		for el, idx in @getValue(path)
			elementPath = path.slice 0
			elementPath.push "#{idx}"
			listValues.push @renderTab(elementPath,idx,true)
		<TabComponent title={listTitle} removable={false} className='list'>
			{listValues}
			<Button text='Add' onClick={@addToList.bind(@,path)}/>
		</TabComponent>

	addToList: (path) ->
		value = @getValue(path).splice(0)
		value.push(value[0])
		@updateState path, value

	removeFromStruct: (path) ->
		if Array.isArray(@getValue(path.slice(0,-1)))
			value = @getValue(path.slice(0,-1)).splice(0)
			index = path[path.length-1]
			value.splice(index,1)
			@updateState path.slice(0,-1), value
		else @updateState path, undefined

	# TODO: This effort could be put into a config which render uses to generate the root components
	render: ->
		<div className='home-container'>
			<Component className='constrained' title='Overview'>
				<h1>{@getEventTitle()}</h1>
				<div style={{height:'35px'}}/>
				{@renderTab([],'General Settings',false) if @payloadExists()}
				{@renderTab(['overview','meta'],'Meta',false) if @payloadExists()}
				{@renderList(['overview','data'],'Data',false) if @payloadExists()}
				<div className='component-footer'/>
			</Component>
			<div style={{height:'25px'}}/>
			<Component className='constrained' title='Template Metadata'>
				{@renderTab(['template_meta'],'Template Meta',false) if @payloadExists()}
				<div className='component-footer'/>
			</Component>
			<div style={{height:'25px'}}/>
			<Component className='constrained' title='Offerings'>
				{@renderTab(['offerings','meta'],'Meta',false) if @payloadExists()}
				{@renderList(['offerings','data'],'Data',true) if @payloadExists()}
				<div className='component-footer'/>
			</Component>
			<div style={{height:'25px'}}/>
			<Component className='constrained' title='Contact'>
				{@renderTab(['contact','meta'],'Meta',false) if @payloadExists()}
				<div className='component-footer'/>
			</Component>
			<div style={{height:'25px'}}/>
			<Component className='constrained' title='Organisation'>
				{@renderTab(['organisation','meta'],'Meta',false) if @payloadExists()}
				<div className='component-footer'/>
			</Component>
			<div style={{height:'25px'}}/>
			<Component className='constrained' title='Attendees Meta'>
				{@renderTab(['attendees_meta'],'Meta',false) if @payloadExists()}
				<div className='component-footer'/>
			</Component>
			<div style={{height:'25px'}}/>
			<Component className='constrained'>
				<div style={{padding:'10px'}}>
					<Button text='Save' onClick={@save}/>
				</div>
			</Component>
			<div style={{height:'25px'}}/>
		</div>

module.exports = Event
