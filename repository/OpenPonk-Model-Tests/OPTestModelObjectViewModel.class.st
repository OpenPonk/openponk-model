"
A minimal view model subclass used exclusively for verifying view model registration and property mapping in unit tests.
"
Class {
	#name : 'OPTestModelObjectViewModel',
	#superclass : 'OPModelObjectViewModel',
	#category : 'OpenPonk-Model-Tests-ViewModels',
	#package : 'OpenPonk-Model-Tests',
	#tag : 'ViewModels'
}

{ #category : 'testing' }
OPTestModelObjectViewModel class >> isAbstract [
	^ false
]

{ #category : 'accessing' }
OPTestModelObjectViewModel class >> modelClass [
	^ OPTestModelObject
]
