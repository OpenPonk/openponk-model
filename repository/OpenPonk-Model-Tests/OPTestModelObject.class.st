"
A minimal domain model element subclass used exclusively for unit testing of core model behaviors.
"
Class {
	#name : 'OPTestModelObject',
	#superclass : 'OPModelObject',
	#instVars : [
		'relatedElements'
	],
	#category : 'OpenPonk-Model-Tests-ModelObjects',
	#package : 'OpenPonk-Model-Tests',
	#tag : 'ModelObjects'
}

{ #category : 'accessing' }
OPTestModelObject >> relatedElements [
	^ relatedElements ifNil: [ #() ]
]

{ #category : 'accessing' }
OPTestModelObject >> relatedElements: aCollection [
	relatedElements := aCollection
]
