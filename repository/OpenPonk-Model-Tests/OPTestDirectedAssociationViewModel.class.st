"
Minimal concrete directed association view model used for unit testing.
"
Class {
	#name : 'OPTestDirectedAssociationViewModel',
	#superclass : 'OPDirectedAssociationViewModel',
	#category : 'OpenPonk-Model-Tests-ViewModels',
	#package : 'OpenPonk-Model-Tests',
	#tag : 'ViewModels'
}

{ #category : 'testing' }
OPTestDirectedAssociationViewModel class >> isAbstract [
	^ false
]

{ #category : 'accessing' }
OPTestDirectedAssociationViewModel class >> modelClass [
	^ OPDirectedAssociation
]

{ #category : 'construction' }
OPTestDirectedAssociationViewModel >> attachModelFrom: sourceViewModel to: targetViewModel [

	self model
		source: sourceViewModel model;
		target: targetViewModel model
]
