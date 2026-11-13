"
Tests baseline view model behavior, property notification, and change propagation for core model objects.
"
Class {
	#name : 'OPModelObjectViewModelTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-Model-Tests-ViewModels',
	#package : 'OpenPonk-Model-Tests',
	#tag : 'ViewModels'
}

{ #category : 'running' }
OPModelObjectViewModelTest >> setUp [
	super setUp.
	OPViewModelRegistry resetCache
]

{ #category : 'running' }
OPModelObjectViewModelTest >> tearDown [
	OPViewModelRegistry resetCache.
	super tearDown
]

{ #category : 'tests' }
OPModelObjectViewModelTest >> testHierarchyPropagationAndOwnedModelRemoval [
	| project parentModel childModel relatedModel projectController registry parentViewModel childViewModel forwardedAnnouncements expectedIcon |
	project := OPProject name: 'ViewModelHierarchyTest'.
	parentModel := OPTestModelObject new name: 'Parent'.
	childModel := OPTestModelObject new name: 'Child'.
	relatedModel := OPTestModelObject new name: 'Related'.
	parentModel add: childModel.
	parentModel relatedElements: { relatedModel }.
	project addModel: parentModel.
	project addModel: relatedModel.

	projectController := OPProjectController forProject: project.
	registry := projectController viewModelRegistry.
	parentViewModel := registry viewModelFor: parentModel.
	childViewModel := registry viewModelFor: childModel.
	expectedIcon := OPCoreIcons openponkIcon.

	self assert: OPModelObjectViewModel isAbstract description: 'OPModelObjectViewModel must be abstract'.
	self deny: OPTestModelObjectViewModel isAbstract description: 'Concrete subclass must not be abstract'.
	self assert: parentViewModel creationPriority equals: 10.
	self assert: parentViewModel icon extent equals: expectedIcon extent.
	self assert: parentViewModel icon bits equals: expectedIcon bits.
	self assertCollection: parentViewModel childrenModels hasSameElements: { childModel }.
	self assertCollection: parentViewModel dependentElements hasSameElements: { childModel . relatedModel }.
	self assert: parentViewModel findParentViewModel identicalTo: registry projectViewModel.
	self assert: childViewModel findParentViewModel identicalTo: parentViewModel.

	forwardedAnnouncements := OrderedCollection new.
	childViewModel announcer when: OPModelChanged do: [ :ann | forwardedAnnouncements add: ann ] for: self.
	childModel name: 'RenamedChild'.
	self assert: forwardedAnnouncements size equals: 1.

	childViewModel basicRemoveModel.
	self assertEmpty: parentModel elements.
	self assert: childModel owner identicalTo: nil
]

{ #category : 'tests' }
OPModelObjectViewModelTest >> testRemoveRootModelWithoutOwnerRemovesFromProject [
	| project rootModel projectController viewModelRegistry viewModel |
	project := OPProject name: 'RootModelRemovalTest'.
	rootModel := OPTestModelObject new.
	rootModel name: 'RootElement'.
	project addModel: rootModel.
	projectController := OPProjectController forProject: project.
	viewModelRegistry := projectController viewModelRegistry.
	viewModel := viewModelRegistry viewModelFor: rootModel.

	self assertCollection: project models hasSameElements: { rootModel }.

	viewModel basicRemoveModel.

	self assertEmpty: project models.

	viewModel registerModelIn: project.
	self assertCollection: project models hasSameElements: { rootModel }
]

{ #category : 'tests' }
OPModelObjectViewModelTest >> testUnsubscribeStopsForwardingModelAnnouncements [
	| project rootModel projectController viewModel forwardedCount |
	project := OPProject name: 'UnsubscribeTest'.
	rootModel := OPTestModelObject new name: 'Root'.
	project addModel: rootModel.
	projectController := OPProjectController forProject: project.
	viewModel := projectController viewModelRegistry viewModelFor: rootModel.

	forwardedCount := 0.
	viewModel announcer when: OPModelChanged do: [ :ann | forwardedCount := forwardedCount + 1 ] for: self.
	rootModel name: 'FirstChange'.
	self assert: forwardedCount equals: 1.

	viewModel unsubscribeFromModel.
	rootModel name: 'SecondChange'.
	self assert: forwardedCount equals: 1
]
