"
I am above the topmost model element to provide convenient announcer access.

Maybe I should be a Trait in the Element instead?
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
	self announce: (OPElementAdded element: anElement).
	self changed
]

{ #category : 'announcing' }
OPAnnouncableObject >> announceChanged: anElement [
	self announce: (OPElementChanged element: anElement)
]

{ #category : 'announcing' }
OPAnnouncableObject >> announceRemoved: anElement [
	self announce: (OPElementRemoved element: anElement).
	anElement announce: (OPElementRemoved element: anElement).
	self changed
]

{ #category : 'accessing' }
OPAnnouncableObject >> announcer [
	announcer ifNil: [ self announcer: Announcer new ].
	^ announcer
]

{ #category : 'accessing' }
OPAnnouncableObject >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : 'announcing' }
OPAnnouncableObject >> changed [
	self announceChanged: self
]

{ #category : 'as yet unclassified' }
OPAnnouncableObject >> fuelIgnoredInstanceVariableNames [
	^ #(#announcer)
]

{ #category : 'announcement registration' }
OPAnnouncableObject >> silentlyDo: aBlock [
	| oldAnnouncer |
	oldAnnouncer := announcer.
	announcer := Announcer new.
	aBlock value.
	announcer := oldAnnouncer
]

{ #category : 'announcement registration' }
OPAnnouncableObject >> when: anAnnouncementClass do: aValuable [

	| subscriberForDeprecation |
	aValuable receiver ifNil: [
		self error:
			'You must specify a subscriber object for this subscription. Please use #when:do:for: method.' ].

	subscriberForDeprecation := thisContext sender receiver
	                            = aValuable receiver
		                            ifTrue: [ 'self' ]
		                            ifFalse: [ '`@arg2 receiver' ].
	self
		deprecated:
			'Since there are some block closures (Clean and Constant) without a receiver, the API of announcements was changed to send the subscriber explicitly. 
			We are deprecating this method because it was asking for the receiver of the block to use it as the subscriber.'
		transformWith: '`@receiver when: `@arg1 do: `@arg2'
			->
			('`@receiver when: `@arg1 do: `@arg2 for: '
			 , subscriberForDeprecation).

	^ self
		  when: anAnnouncementClass
		  do: aValuable
		  for: aValuable receiver
]

{ #category : 'announcement registration' }
OPAnnouncableObject >> when: anEvent do: aBlock for: aReceiver [

	self announcer when: anEvent do: aBlock for: aReceiver
]

{ #category : 'announcement registration' }
OPAnnouncableObject >> when: anAnnouncementClass send: aSelector to: anObject [
	self announcer when: anAnnouncementClass send: aSelector to: anObject
]

{ #category : 'announcement registration' }
OPAnnouncableObject >> whenChanged: aBlock [

	self when: OPElementChanged do: aBlock for: aBlock receiver
]
