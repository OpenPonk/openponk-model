"
Unit tests for directed association view model dependencies, display string formatting, and accessors.
"
Class {
	#name : 'OPDirectedAssociationViewModelTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-Model-Tests-ViewModels',
	#package : 'OpenPonk-Model-Tests',
	#tag : 'ViewModels'
}

{ #category : 'running' }
OPDirectedAssociationViewModelTest >> setUp [
	super setUp.
	OPViewModelRegistry resetCache
]

{ #category : 'running' }
OPDirectedAssociationViewModelTest >> tearDown [
	OPViewModelRegistry resetCache.
	super tearDown
]

{ #category : 'tests' }
OPDirectedAssociationViewModelTest >> testDependenciesAndValidation [
	| project source target association incompleteAssociation registry viewModel incompleteViewModel |
	project := OPProject name: 'AssocDependenciesTest'.
	source := OPTestModelObject new name: 'A'.
	target := OPTestModelObject new name: 'B'.
	association := OPDirectedAssociation from: source to: target.
	incompleteAssociation := OPDirectedAssociation new.
	{ source . target . association . incompleteAssociation } do: [ :each |
		project addModel: each ].

	registry := (OPProjectController forProject: project) viewModelRegistry.
	viewModel := registry viewModelFor: association.
	incompleteViewModel := registry viewModelFor: incompleteAssociation.

	self assert: OPDirectedAssociationViewModel isAbstract description: 'OPDirectedAssociationViewModel must be abstract'.
	self deny: OPTestDirectedAssociationViewModel isAbstract description: 'Concrete subclass must not be abstract'.
	self assert: viewModel creationPriority equals: 20.
	self assert: viewModel modelSource identicalTo: source.
	self assert: viewModel modelTarget identicalTo: target.
	self assertCollection: viewModel dependingOnElements hasSameElements: { source . target }.

	self should: [ incompleteViewModel dependingOnElements ] raise: Error
]

{ #category : 'tests' }
OPDirectedAssociationViewModelTest >> testModelDisplayStringFormatting [
	| project registry source target association viewModel unnamedSource unnamedTarget |
	project := OPProject name: 'AssocFormattingTest'.
	source := OPTestModelObject new name: 'Order'.
	target := OPTestModelObject new name: 'Customer'.
	association := OPDirectedAssociation from: source to: target.
	{ source . target . association } do: [ :each | project addModel: each ].
	registry := (OPProjectController forProject: project) viewModelRegistry.
	viewModel := registry viewModelFor: association.

	self assert: (String streamContents: [ :s | viewModel modelDisplayStringOn: s ]) equals: 'Order -> Customer (Directed Association)'.

	association name: 'places'.
	self assert: (String streamContents: [ :s | viewModel modelDisplayStringOn: s ]) equals: 'places (Directed Association)'.

	unnamedSource := OPTestModelObject new.
	unnamedTarget := OPTestModelObject new.
	association := OPDirectedAssociation from: unnamedSource to: unnamedTarget.
	{ unnamedSource . unnamedTarget . association } do: [ :each | project addModel: each ].
	viewModel := registry viewModelFor: association.
	self assert: (String streamContents: [ :s | viewModel modelDisplayStringOn: s ]) equals: 'OPTestModelObject -> OPTestModelObject (Directed Association)'.

	association := OPDirectedAssociation new.
	project addModel: association.
	viewModel := registry viewModelFor: association.
	self assert: (String streamContents: [ :s | viewModel modelDisplayStringOn: s ]) equals: '? -> ? (Directed Association)'
]
