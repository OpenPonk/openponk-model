"
I am a comment associated with an element.
"
Class {
	#name : #OPMComment,
	#superclass : #Object,
	#instVars : [
		'body'
	],
	#category : 'OpenPonk-Model-ModelObjects'
}

{ #category : #'instance creation' }
OPMComment class >> body: aString [
	^ self new
		body: aString;
		yourself
]

{ #category : #testing }
OPMComment class >> isDeprecated [
	^ true
]

{ #category : #accessing }
OPMComment >> body [
	^ body
]

{ #category : #accessing }
OPMComment >> body: aString [
	body := aString
]
