"
Deprecated legacy base class for model elements.
Retained strictly for backward compatibility. Use OPModelObject instead.
"
Class {
	#name : 'OPMElement',
	#superclass : 'OPModelObject',
	#category : 'OpenPonk-Model-ModelObjects',
	#package : 'OpenPonk-Model',
	#tag : 'ModelObjects'
}

{ #category : 'testing' }
OPMElement class >> isDeprecated [
	"There is no difference between types of elements. Use OPModelObject instead (or don't use any class of this package)"

	^ true
]
