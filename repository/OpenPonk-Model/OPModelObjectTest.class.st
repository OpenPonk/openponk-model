"
Unit tests for OPModelObject.
Verifies structural operations such as adding, removing, and reparenting elements, as well as the correct firing of domain events.
"
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
	added := Set new.
	changed := Set new.
	diagram
		when: OPModelChildAdded
		do: [ :event | added add: event child ]
		for: self.
	diagram
		when: OPModelChanged
		do: [ :event | changed add: event model ]
		for: self.
	diagram add: element.

	self assertCollection: added hasSameElements: { element }.
	self assertCollection: changed includesAny: { diagram }.
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
		when: OPModelChanged
		do: [ :event | changed := event model ]
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

	| removed changed changedByChildRemoval |
	diagram add: element.

	removed := nil.
	changed := nil.
	changedByChildRemoval := nil.
	diagram
		when: OPModelChildRemoved
		do: [ :event |
				removed := event child.
				changedByChildRemoval := event model ]
		for: self.
	diagram
		when: OPModelChanged
		do: [ :event | changed := event model ]
		for: self.
	diagram remove: element.

	self assert: removed equals: element.
	self assert: changed equals: diagram.
	self assert: changedByChildRemoval equals: diagram.
	self assert: diagram elements isEmpty
]

{ #category : 'tests' }
OPModelObjectTest >> testRemoved [
	diagram add: element.
	self assert: element owner isNotNil.
	diagram remove: element.
	self assert: element owner isNil
]
