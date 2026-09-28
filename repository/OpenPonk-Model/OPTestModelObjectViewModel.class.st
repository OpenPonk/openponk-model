"
A minimal view model subclass used exclusively for verifying view model registration and property mapping in unit tests.
"
Class {
	#name : 'OPTestModelObjectViewModel',
	#superclass : 'OPModelObjectViewModel',
	#category : 'OpenPonk-Model-Tests',
	#package : 'OpenPonk-Model',
	#tag : 'Tests'
}

{ #category : 'testing' }
OPTestModelObjectViewModel class >> isAbstract [
	^ false
]

{ #category : 'accessing' }
OPTestModelObjectViewModel class >> modelClass [
	^ OPTestModelObject
]
