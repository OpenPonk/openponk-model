Class {
	#name : 'OPModelObjectTest',
	#superclass : 'TestCase',
	#instVars : [
		'diagram',
		'element'
	],
	#category : 'OpenPonk-Model-Tests',
	#package : 'OpenPonk-Model',
	#tag : 'Tests'
}

{ #category : 'running' }
OPModelObjectTest >> setUp [
	super setUp.
	diagram := OPModelObject named: 'diagram'.
	element := OPModelObject named: 'member'
]

{ #category : 'tests' }
OPModelObjectTest >> testAdd [

	| added changed |
	added := nil.
	changed := nil.
	diagram
		when: OPElementAdded
		do: [ :event | added := event element ]
		for: self.
	diagram
		when: OPElementChanged
		do: [ :event | changed := event element ]
		for: self.
	diagram add: element.

	self assert: added equals: element.
	self assert: changed equals: diagram.
	self
		assertCollection: diagram ownedElements
		hasSameElements: { element }
]

{ #category : 'tests' }
OPModelObjectTest >> testAdded [
	diagram add: element.
	self assert: element owner equals: diagram
]

{ #category : 'tests' }
OPModelObjectTest >> testChange [
	| changed |
	changed := false.
	diagram whenChanged: [ changed := true ].
	diagram name: 'changed name'.
	self assert: changed.
	self assert: diagram name equals: 'changed name'
]

{ #category : 'tests' }
OPModelObjectTest >> testChanged [

	| changed |
	changed := nil.
	element
		when: OPElementChanged
		do: [ :event | changed := event element ]
		for: self.
	self assert: changed isNil.
	changed := nil.
	element name: 'a name'.
	self assert: changed equals: element.
	changed := nil.
	diagram add: element.
	self assert: changed equals: element.
	changed := nil.
	diagram remove: element.
	self assert: changed equals: element
]

{ #category : 'tests' }
OPModelObjectTest >> testRemove [

	| removed changed |
	diagram add: element.

	removed := nil.
	changed := nil.
	diagram
		when: OPElementRemoved
		do: [ :event | removed := event element ]
		for: self.
	diagram
		when: OPElementChanged
		do: [ :event | changed := event element ]
		for: self.
	diagram remove: element.

	self assert: removed equals: element.
	self assert: changed equals: diagram.
	self assert: diagram elements isEmpty
]

{ #category : 'tests' }
OPModelObjectTest >> testRemoved [
	diagram add: element.
	self assert: element owner isNotNil.
	diagram remove: element.
	self assert: element owner isNil
]
