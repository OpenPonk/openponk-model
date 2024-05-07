"
A DCNamedElement represents all possible elements of diagram (such as classes, states, associations). s
"
Class {
	#name : 'OPModelElement',
	#superclass : 'OPModelObject',
	#category : 'OpenPonk-Model-ModelObjects',
	#package : 'OpenPonk-Model',
	#tag : 'ModelObjects'
}

{ #category : 'testing' }
OPModelElement class >> isDeprecated [
	"There is no difference between types of elements. Use OPModelObject instead (or don't use any class of this package)"

	^ true
]
