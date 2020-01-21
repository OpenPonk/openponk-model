"
I am a base class for model element events. I am announced when the element changes.
"
Class {
	#name : #OPModelElementEvent,
	#superclass : #OPModelEvent,
	#instVars : [
		'element'
	],
	#category : 'OpenPonk-Model-Announcements'
}

{ #category : #'instance creation' }
OPModelElementEvent class >> element: anElement [
	^ self new
		element: anElement;
		yourself
]

{ #category : #accessing }
OPModelElementEvent >> element [
	^ element
]

{ #category : #accessing }
OPModelElementEvent >> element: anElement [
	element := anElement
]
