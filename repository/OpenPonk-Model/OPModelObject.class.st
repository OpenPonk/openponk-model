"
A DCModelObject is base class for any semantic element of a metamodel.
"
Class {
	#name : 'OPModelObject',
	#superclass : 'OPAnnouncableObject',
	#instVars : [
		'owner',
		'elements',
		'uuid',
		'name'
	],
	#category : 'OpenPonk-Model-ModelObjects',
	#package : 'OpenPonk-Model',
	#tag : 'ModelObjects'
}

{ #category : 'instance creation' }
OPModelObject class >> named: aString [
	^ self new
		name: aString;
		yourself
]

{ #category : 'adding' }
OPModelObject >> add: anElement [

	(elements includes: anElement) ifTrue: [ ^ anElement ].
	anElement addedTo: self.
	elements add: anElement.
	anElement weakWhen: OPElementChanged send: #changed to: self.
	self announceAdded: anElement.
	^ anElement
]

{ #category : 'adding' }
OPModelObject >> addAll: aCollection [
	aCollection do: [ :each | self add: each ].
	^ aCollection
]

{ #category : 'adding' }
OPModelObject >> addedTo: anObject [
	owner := anObject.
	self changed.
	^ anObject
]

{ #category : 'accessing' }
OPModelObject >> allElements [
	"should return all elements recursively (incl. sub-elements)"

	^ self elements asSet flatCollect: [ :each |
		  (Set with: each) , each allElements ]
]

{ #category : 'accessing' }
OPModelObject >> belongsTo [
	"FAMIX compatibility"

	^ self owner
]

{ #category : 'removing' }
OPModelObject >> detach [
	owner := nil
]

{ #category : 'accessing' }
OPModelObject >> elementNamed: aName [
	^ self elements detect: [ :each | each name = aName ]
]

{ #category : 'accessing' }
OPModelObject >> elements [
	^ elements
]

{ #category : 'testing' }
OPModelObject >> has: anElement [
	^ elements includes: anElement
]

{ #category : 'initialization' }
OPModelObject >> initialize [
	name := ''.
	elements := OrderedCollection new
]

{ #category : 'testing' }
OPModelObject >> isInsideOf: aModelObject [
	^ self owner
		ifNotNil: [ owner == aModelObject
				ifTrue: [ true ]
				ifFalse: [ owner isInsideOf: aModelObject ] ]
		ifNil: [ false ]
]

{ #category : 'accessing' }
OPModelObject >> name [
	^ name
]

{ #category : 'accessing' }
OPModelObject >> name: aString [
	name := aString.
	self changed
]

{ #category : 'accessing' }
OPModelObject >> ownedElements [
	^ elements
]

{ #category : 'accessing' }
OPModelObject >> owner [
	^ owner
]

{ #category : 'printing' }
OPModelObject >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: '(''';
		nextPutAll: self name;
		nextPutAll: ''')'
]

{ #category : 'accessing' }
OPModelObject >> relatedElements [
	^ #()
]

{ #category : 'removing' }
OPModelObject >> remove [
	^ self owner remove: self
]

{ #category : 'removing' }
OPModelObject >> remove: anElement [

	(elements includes: anElement) ifFalse: [ ^ anElement ].
	anElement removeFrom: self.
	elements remove: anElement.
	self announceRemoved: anElement.
	^ anElement
]

{ #category : 'removing' }
OPModelObject >> removeAll [
	| removed |
	removed := elements copy.
	[ elements isNotEmpty ] whileTrue: [ self remove: elements anyOne ].
	^ removed
]

{ #category : 'removing' }
OPModelObject >> removeFrom: anOwner [
	self removeRelatedElements.
	self removeOwnedElements.
	self detach.
	self changed
]

{ #category : 'removing' }
OPModelObject >> removeOwnedElements [
	self ownedElements copy do: [ :each | self remove: each ]
]

{ #category : 'removing' }
OPModelObject >> removeRelatedElements [
	self relatedElements copy do: [ :each | each remove ]
]

{ #category : 'removing' }
OPModelObject >> removedFrom: anOwner [
	self removedFrom: anOwner do: [ self removeAll ]
]

{ #category : 'removing' }
OPModelObject >> removedFrom: anOwner do: aBlock [

	self assert: self owner = anOwner.
	aBlock value.
	owner := nil.
	self changed
]

{ #category : 'accessing' }
OPModelObject >> uuid [
	^ uuid ifNil: [ uuid := UUID new ]
]

{ #category : 'accessing' }
OPModelObject >> uuid: aUUID [
	uuid := aUUID
]
