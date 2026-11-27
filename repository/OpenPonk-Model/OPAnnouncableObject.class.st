"
Foundational base class providing built-in announcement capabilities (via an Announcer).
Might be used as the root class for domain model elements in OpenPonk notations that need to broadcast lifecycle and state changes.
"
Class {
	#name : 'OPAnnouncableObject',
	#superclass : 'Object',
	#instVars : [
		'announcer'
	],
	#category : 'OpenPonk-Model-ModelObjects',
	#package : 'OpenPonk-Model',
	#tag : 'ModelObjects'
}

{ #category : 'ston' }
OPAnnouncableObject class >> stonAllInstVarNames [
	^ super stonAllInstVarNames copyWithout: #announcer
]

{ #category : 'announcing' }
OPAnnouncableObject >> announce: anAnnouncement [
	self announcer announce: anAnnouncement
]

{ #category : 'announcing' }
OPAnnouncableObject >> announceAdded: anElement [

	self announce: (OPModelChildAdded model: self child: anElement)
]

{ #category : 'announcing' }
OPAnnouncableObject >> announceChanged: anElement [

	self announce: (OPModelChanged model: anElement)
]

{ #category : 'announcing' }
OPAnnouncableObject >> announceRemovedChild: anElement [

	self announce: (OPModelChildRemoved model: self child: anElement).
	anElement announce: (OPModelRemoved model: self)
]

{ #category : 'accessing' }
OPAnnouncableObject >> announcer [

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : 'updating' }
OPAnnouncableObject >> changed [
	self announceChanged: self
]

{ #category : 'fuel support' }
OPAnnouncableObject >> fuelIgnoredInstanceVariableNames [
	^ #(#announcer)
]

{ #category : 'announcement registration' }
OPAnnouncableObject >> silentlyDo: aBlock [

	| oldAnnouncer |
	oldAnnouncer := announcer.
	announcer := Announcer new.
	aBlock ensure: [ announcer := oldAnnouncer ]
]

{ #category : 'announcement registration' }
OPAnnouncableObject >> unsubscribe: anObject [

	^ self announcer unsubscribe: anObject
]

{ #category : 'announcement registration' }
OPAnnouncableObject >> weakWhen: anAnnouncementClass send: aSelector to: aReceiver [

	^ self announcer weak
		  when: anAnnouncementClass
		  send: aSelector
		  to: aReceiver
]

{ #category : 'announcement registration' }
OPAnnouncableObject >> when: anEvent do: aBlock for: aReceiver [

	self announcer when: anEvent do: aBlock for: aReceiver
]

{ #category : 'announcement registration' }
OPAnnouncableObject >> when: anAnnouncementClass send: aSelector to: aReceiver [

	^ self announcer
		  when: anAnnouncementClass
		  send: aSelector
		  to: aReceiver
]

{ #category : 'announcement registration' }
OPAnnouncableObject >> whenChangedSend: aSelector to: aReceiver [

	^ self when: OPModelChanged send: aSelector to: aReceiver
]
