"
Deprecated legacy base class for named model elements.
Retained strictly for backward compatibility. Use OPModelObject instead.
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
