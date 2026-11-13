"
Unit tests for announcement registration, suppression, unsubscription, and serialization metadata.
"
Class {
	#name : 'OPAnnouncableObjectTest',
	#superclass : 'TestCase',
	#instVars : [
		'announcable'
	],
	#category : 'OpenPonk-Model-Tests-ModelObjects',
	#package : 'OpenPonk-Model-Tests',
	#tag : 'ModelObjects'
}

{ #category : 'running' }
OPAnnouncableObjectTest >> setUp [
	super setUp.
	announcable := OPAnnouncableObject new
]

{ #category : 'tests' }
OPAnnouncableObjectTest >> testAnnounceAddedAndRemovedChildAndChanged [

	| addedEvent changedEvent childRemovedEvent modelRemovedEvent child |
	child := OPAnnouncableObject new.
	addedEvent := changedEvent := childRemovedEvent := modelRemovedEvent := nil.
	announcable when: OPModelChildAdded do: [ :ann | addedEvent := ann ] for: self.
	announcable when: OPModelChanged do: [ :ann | changedEvent := ann ] for: self.
	announcable when: OPModelChildRemoved do: [ :ann | childRemovedEvent := ann ] for: self.
	child when: OPModelRemoved do: [ :ann | modelRemovedEvent := ann ] for: self.

	announcable announceAdded: child.
	self assert: addedEvent model identicalTo: announcable.
	self assert: addedEvent child identicalTo: child.

	announcable changed.
	self assert: changedEvent model identicalTo: announcable.

	announcable announceRemovedChild: child.
	self assert: childRemovedEvent model identicalTo: announcable.
	self assert: childRemovedEvent child identicalTo: child.
	self assert: modelRemovedEvent model identicalTo: announcable
]

{ #category : 'tests' }
OPAnnouncableObjectTest >> testSerializationExcludesAnnouncer [
	self assertCollection: announcable fuelIgnoredInstanceVariableNames hasSameElements: #(#announcer).
	self denyCollection: OPAnnouncableObject stonAllInstVarNames includesAny: #(#announcer)
]

{ #category : 'tests' }
OPAnnouncableObjectTest >> testSilentlyDoSuppressesAnnouncementsAndRestoresAnnouncer [
	| count |
	count := 0.
	announcable when: OPModelChanged do: [ :ann | count := count + 1 ] for: self.

	announcable silentlyDo: [
		announcable changed.
		announcable announceAdded: OPAnnouncableObject new ].
	self assert: count equals: 0.

	announcable changed.
	self assert: count equals: 1
]

{ #category : 'tests' }
OPAnnouncableObjectTest >> testWhenChangedSendToAndUnsubscribe [
	| receivedEvents blockCount |
	receivedEvents := OrderedCollection new.
	blockCount := 0.
	announcable whenChangedSend: #add: to: receivedEvents.
	announcable changed.
	self assert: receivedEvents size equals: 1.

	announcable when: OPModelChanged do: [ :ann | blockCount := blockCount + 1 ] for: self.
	announcable changed.
	self assert: receivedEvents size equals: 2.
	self assert: blockCount equals: 1.

	announcable unsubscribe: self.
	announcable changed.
	self assert: receivedEvents size equals: 3.
	self assert: blockCount equals: 1
]
