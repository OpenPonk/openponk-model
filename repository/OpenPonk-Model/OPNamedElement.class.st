Class {
	#name : #OPNamedElement,
	#superclass : #OPModelElement,
	#category : 'OpenPonk-Model-ModelObjects'
}

{ #category : #testing }
OPNamedElement class >> isDeprecated [
	"There is no difference between types of elements. Use OPModelObject instead (or don't use any class of this package)"

	^ true
]
