"
Deprecated representation of a basic textual comment or note associated with a domain model element.
Retained for backward compatibility.
"
Class {
	#name : 'OPMComment',
	#superclass : 'Object',
	#instVars : [
		'body'
	],
	#category : 'OpenPonk-Model-ModelObjects',
	#package : 'OpenPonk-Model',
	#tag : 'ModelObjects'
}

{ #category : 'instance creation' }
OPMComment class >> body: aString [
	^ self new
		body: aString;
		yourself
]

{ #category : 'testing' }
OPMComment class >> isDeprecated [
	^ true
]

{ #category : 'accessing' }
OPMComment >> body [
	^ body
]

{ #category : 'accessing' }
OPMComment >> body: aString [
	body := aString
]
