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
