"
Model representing a directed binary relationship between two OPModelObjects.
Explicitly defines and tracks a source element and a target element.
"
Class {
	#name : 'OPDirectedAssociation',
	#superclass : 'OPModelObject',
	#instVars : [
		'source',
		'target'
	],
	#category : 'OpenPonk-Model-ModelObjects',
	#package : 'OpenPonk-Model',
	#tag : 'ModelObjects'
}

{ #category : 'instance creation' }
OPDirectedAssociation class >> from: aSourceObject to: aTargetObject [
	^ self new
		from: aSourceObject to: aTargetObject;
		yourself
]

{ #category : 'instance creation' }
OPDirectedAssociation class >> from: aSourceObject to: aTargetObject named: aString [
	^ self new
		from: aSourceObject to: aTargetObject;
		name: aString;
		yourself
]

{ #category : 'instance creation' }
OPDirectedAssociation >> from: aSourceObject to: aTargetObject [
	self source: aSourceObject.
	self target: aTargetObject
]

{ #category : 'accessing' }
OPDirectedAssociation >> source [
	^ source
]

{ #category : 'accessing' }
OPDirectedAssociation >> source: aModelObject [
	source := aModelObject
]

{ #category : 'accessing' }
OPDirectedAssociation >> target [
	^ target
]

{ #category : 'accessing' }
OPDirectedAssociation >> target: aModelObject [
	target := aModelObject
]
