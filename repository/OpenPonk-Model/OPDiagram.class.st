"
A Diagram is class that holds and takes care of all possible elements of specific diagram.
"
Class {
	#name : #OPDiagram,
	#superclass : #OPModelObject,
	#category : 'OpenPonk-Model-ModelObjects'
}

{ #category : #testing }
OPDiagram class >> isDeprecated [
	"There is no difference between Diagram and any other object element. Use OPModelObject instead (or don't use any class of this package)"

	^ true
]
