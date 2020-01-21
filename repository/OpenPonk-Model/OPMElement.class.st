"
I represent the base class of all model elements.
"
Class {
	#name : #OPMElement,
	#superclass : #OPModelObject,
	#category : 'OpenPonk-Model-ModelObjects'
}

{ #category : #testing }
OPMElement class >> isDeprecated [
	"There is no difference between types of elements. Use OPModelObject instead (or don't use any class of this package)"

	^ true
]

{ #category : #accessing }
OPMElement >> uuid [
	^ uuid ifNil: [ uuid := UUID new ]
]

{ #category : #accessing }
OPMElement >> uuid: anUUID [
	uuid := anUUID
]
