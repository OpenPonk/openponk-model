"
Unit tests for directed association view model dependencies, display string formatting, and accessors.
"
Class {
	#name : 'OPDirectedAssociationViewModelTest',
	#superclass : 'OPAbstractDirectionalRelationshipViewModelTest',
	#category : 'OpenPonk-Model-Tests-ViewModels',
	#package : 'OpenPonk-Model-Tests',
	#tag : 'ViewModels'
}

{ #category : 'constants' }
OPDirectedAssociationViewModelTest >> modelClass [

	^ OPDirectedAssociation
]

{ #category : 'initialization' }
OPDirectedAssociationViewModelTest >> newRootModel [

	^ OPTestModelObject new
		  name: 'Root';
		  yourself
]

{ #category : 'constants' }
OPDirectedAssociationViewModelTest >> sourceModelClass [

	^ OPTestModelObject
]

{ #category : 'constants' }
OPDirectedAssociationViewModelTest >> targetModelClass [

	^ OPTestModelObject
]

{ #category : 'tests' }
OPDirectedAssociationViewModelTest >> testDependenciesAndValidation [

	| testProject source target association incompleteAssociation testRegistry associationViewModel incompleteViewModel |
	testProject := OPProject named: 'AssocDependenciesTest'.
	source := OPTestModelObject new name: 'A'.
	target := OPTestModelObject new name: 'B'.
	association := OPDirectedAssociation from: source to: target.
	incompleteAssociation := OPDirectedAssociation new.
	{
		source.
		target.
		association.
		incompleteAssociation } do: [ :each | testProject addModel: each ].

	testRegistry := (OPProjectController forProject: testProject) viewModelRegistry.
	associationViewModel := testRegistry viewModelFor: association.
	incompleteViewModel := testRegistry viewModelFor: incompleteAssociation.

	self assert: OPDirectedAssociationViewModel isAbstract description: 'OPDirectedAssociationViewModel must be abstract'.
	self deny: OPTestDirectedAssociationViewModel isAbstract description: 'Concrete subclass must not be abstract'.
	self assert: associationViewModel creationPriority equals: 20.
	self assert: associationViewModel modelSource identicalTo: source.
	self assert: associationViewModel modelTarget identicalTo: target.
	self assertCollection: associationViewModel dependingOnElements hasSameElements: {
			source.
			target }.

	self should: [ incompleteViewModel dependingOnElements ] raise: Error
]

{ #category : 'tests' }
OPDirectedAssociationViewModelTest >> testModelDisplayStringFormatting [

	| testProject testRegistry source target association associationViewModel unnamedSource unnamedTarget |
	testProject := OPProject named: 'AssocFormattingTest'.
	source := OPTestModelObject new name: 'Order'.
	target := OPTestModelObject new name: 'Customer'.
	association := OPDirectedAssociation from: source to: target.
	{
		source.
		target.
		association } do: [ :each | testProject addModel: each ].
	testRegistry := (OPProjectController forProject: testProject) viewModelRegistry.
	associationViewModel := testRegistry viewModelFor: association.

	self
		assert: (String streamContents: [ :s | associationViewModel modelDisplayStringOn: s ])
		equals: 'Order -> Customer (Directed Association)'.

	association name: 'places'.
	self
		assert: (String streamContents: [ :s | associationViewModel modelDisplayStringOn: s ])
		equals: 'places (Directed Association)'.

	unnamedSource := OPTestModelObject new.
	unnamedTarget := OPTestModelObject new.
	association := OPDirectedAssociation from: unnamedSource to: unnamedTarget.
	{
		unnamedSource.
		unnamedTarget.
		association } do: [ :each | testProject addModel: each ].
	associationViewModel := testRegistry viewModelFor: association.
	self
		assert: (String streamContents: [ :s | associationViewModel modelDisplayStringOn: s ])
		equals: 'OPTestModelObject -> OPTestModelObject (Directed Association)'.

	association := OPDirectedAssociation new.
	testProject addModel: association.
	associationViewModel := testRegistry viewModelFor: association.
	self
		assert: (String streamContents: [ :s | associationViewModel modelDisplayStringOn: s ])
		equals: '? -> ? (Directed Association)'
]

{ #category : 'constants' }
OPDirectedAssociationViewModelTest >> viewModelClass [

	^ OPTestDirectedAssociationViewModel
]
