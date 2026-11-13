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
	#category : 'OpenPonk-Model-Tests-ModelObjects',
	#package : 'OpenPonk-Model-Tests',
	#tag : 'ModelObjects'
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
OPModelObjectTest >> testAddAllAndHasAndElementNamed [
	| second |
	second := OPModelObject named: 'second'.
	diagram addAll: { element . second }.

	self assert: (diagram has: element) description: 'Diagram must contain first added element'.
	self assert: (diagram has: second) description: 'Diagram must contain second added element'.
	self assert: (diagram elementNamed: 'second') identicalTo: second.
	self should: [ diagram elementNamed: 'missing' ] raise: NotFound
]

{ #category : 'tests' }
OPModelObjectTest >> testAddIsIdempotentAndPropagatesChildChanges [
	| parentChanges |
	parentChanges := 0.
	diagram when: OPModelChanged do: [ :event | parentChanges := parentChanges + 1 ] for: self.

	diagram add: element.
	self assert: parentChanges equals: 1.

	diagram add: element.
	self assert: diagram elements size equals: 1.
	self assert: parentChanges equals: 1.

	element name: 'updated'.
	self assert: parentChanges equals: 2
]

{ #category : 'tests' }
OPModelObjectTest >> testAdded [
	diagram add: element.
	self assert: element owner equals: diagram
]

{ #category : 'tests' }
OPModelObjectTest >> testChange [
	| receivedModels |
	receivedModels := OrderedCollection new.
	diagram when: OPModelChanged do: [ :event | receivedModels add: event model ] for: self.
	diagram name: 'changed name'.
	self assertCollection: receivedModels hasSameElements: { diagram }.
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
	self assert: changed identicalTo: nil.
	element name: 'a name'.
	self assert: changed identicalTo: element.
	changed := nil.
	diagram add: element.
	self assert: changed identicalTo: element.
	changed := nil.
	diagram remove: element.
	self assert: changed identicalTo: element
]

{ #category : 'tests' }
OPModelObjectTest >> testHierarchyQueriesAndPrintOn [
	| grandChild unrelated |
	grandChild := OPModelObject named: 'leaf'.
	unrelated := OPModelObject named: 'other'.
	diagram add: element.
	element add: grandChild.

	self assertCollection: diagram allElements hasSameElements: { element . grandChild }.
	self assertCollection: diagram withAllElements hasSameElements: { diagram . element . grandChild }.
	self assert: (grandChild isInsideOf: element) description: 'Grandchild must be inside direct parent'.
	self assert: (grandChild isInsideOf: diagram) description: 'Grandchild must be inside ancestor'.
	self deny: (grandChild isInsideOf: unrelated) description: 'Grandchild must not be inside unrelated object'.
	self deny: (diagram isInsideOf: element) description: 'Root must not be inside its child'.
	self assert: grandChild rootOwner identicalTo: diagram.
	self assert: diagram rootOwner identicalTo: diagram.
	self assert: diagram printString equals: 'an OPModelObject(''diagram'')'
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
	diagram when: OPModelChanged do: [ :event | changed := event model ] for: self.
	diagram remove: element.

	self assert: removed equals: element.
	self assert: changed equals: diagram.
	self assert: changedByChildRemoval equals: diagram.
	self assertEmpty: diagram elements
]

{ #category : 'tests' }
OPModelObjectTest >> testRemoveFromCascadesToOwnedAndRelatedElements [
	| ownerElement child related |
	ownerElement := OPTestModelObject new name: 'owner'.
	child := OPModelObject named: 'child'.
	related := OPTestModelObject new name: 'rel'.
	ownerElement add: child.
	ownerElement relatedElements: { related }.
	diagram addAll: { ownerElement . related }.

	diagram remove: ownerElement.
	self assertEmpty: ownerElement elements.
	self assert: child owner identicalTo: nil.
	self deny: (diagram has: related) description: 'Related element must be removed when owning element is removed'
]

{ #category : 'tests' }
OPModelObjectTest >> testRemoveSelfRemoveAllAndRemovedFromValidation [
	| second removed |
	second := OPModelObject named: 'second'.
	diagram addAll: { element . second }.

	element remove.
	self deny: (diagram has: element) description: 'Removed element must no longer be in diagram'.
	self assert: element owner identicalTo: nil.

	self assert: (diagram remove: element) identicalTo: element.

	diagram add: element.
	removed := diagram removeAll.
	self assertCollection: removed hasSameElements: { second . element }.
	self assertEmpty: diagram elements.
	self assert: second owner identicalTo: nil.

	diagram add: element.
	self should: [ element removedFrom: second ] raise: AssertionFailure.
	element removedFrom: diagram.
	self assert: element owner identicalTo: nil
]

{ #category : 'tests' }
OPModelObjectTest >> testRemoved [
	diagram add: element.
	self assert: element owner identicalTo: diagram.
	diagram remove: element.
	self assert: element owner identicalTo: nil
]

{ #category : 'tests' }
OPModelObjectTest >> testUuidSetterAndGetter [
	| customUuid |
	customUuid := UUID new.
	element uuid: customUuid.
	self assert: element uuid identicalTo: customUuid
]
