"
Tests baseline view model behavior, property notification, and change propagation for core model objects.
"
Class {
	#name : 'OPModelObjectViewModelTest',
	#superclass : 'OPAbstractViewModelTest',
	#category : 'OpenPonk-Model-Tests-ViewModels',
	#package : 'OpenPonk-Model-Tests',
	#tag : 'ViewModels'
}

{ #category : 'constants' }
OPModelObjectViewModelTest >> modelClass [

	^ OPTestModelObject
]

{ #category : 'initialization' }
OPModelObjectViewModelTest >> newRootModel [

	^ OPTestModelObject new
		  name: 'Root';
		  yourself
]

{ #category : 'tests' }
OPModelObjectViewModelTest >> testDependentElementsDeduplicatesChildrenAndRelatedElements [

	| testProject containerModel childModel projectController parentViewModel dependents |
	testProject := OPProject named: 'DependentDeduplicationTest'.
	containerModel := OPTestModelObject new name: 'Parent'.
	childModel := OPTestModelObject new name: 'SharedChild'.
	containerModel add: childModel.
	containerModel relatedElements: { childModel }.
	testProject addModel: containerModel.
	projectController := OPProjectController forProject: testProject.
	parentViewModel := projectController viewModelRegistry viewModelFor: containerModel.

	dependents := parentViewModel dependentElements.

	self assert: dependents size equals: 1.
	self assertCollection: dependents hasSameElements: { childModel }
]

{ #category : 'tests' }
OPModelObjectViewModelTest >> testHierarchyPropagationAndOwnedModelRemoval [

	| testProject containerModel childModel relatedModel projectController testRegistry parentViewModel childViewModel forwardedAnnouncements expectedIcon |
	testProject := OPProject named: 'ViewModelHierarchyTest'.
	containerModel := OPTestModelObject new name: 'Parent'.
	childModel := OPTestModelObject new name: 'Child'.
	relatedModel := OPTestModelObject new name: 'Related'.
	containerModel add: childModel.
	containerModel relatedElements: { relatedModel }.
	testProject addModel: containerModel.
	testProject addModel: relatedModel.

	projectController := OPProjectController forProject: testProject.
	testRegistry := projectController viewModelRegistry.
	parentViewModel := testRegistry viewModelFor: containerModel.
	childViewModel := testRegistry viewModelFor: childModel.
	expectedIcon := OPCoreIcons openponkIcon.

	self assert: OPModelObjectViewModel isAbstract description: 'OPModelObjectViewModel must be abstract'.
	self deny: OPTestModelObjectViewModel isAbstract description: 'Concrete subclass must not be abstract'.
	self assert: parentViewModel creationPriority equals: 10.
	self assert: parentViewModel icon extent equals: expectedIcon extent.
	self assert: parentViewModel icon bits equals: expectedIcon bits.
	self assertCollection: parentViewModel childrenModels hasSameElements: { childModel }.
	self assertCollection: parentViewModel dependentElements hasSameElements: {
			childModel.
			relatedModel }.
	self assert: parentViewModel findParentViewModel identicalTo: testRegistry projectViewModel.
	self assert: childViewModel findParentViewModel identicalTo: parentViewModel.

	forwardedAnnouncements := OrderedCollection new.
	childViewModel announcer when: OPModelChanged do: [ :ann | forwardedAnnouncements add: ann ] for: self.
	childModel name: 'RenamedChild'.
	self assert: forwardedAnnouncements size equals: 1.

	childViewModel basicRemoveModel.
	self assertEmpty: containerModel elements.
	self assert: childModel owner identicalTo: nil
]

{ #category : 'tests' }
OPModelObjectViewModelTest >> testRemoveRootModelWithoutOwnerRemovesFromProject [

	| testProject standaloneRoot projectController viewModelRegistry rootViewModel |
	testProject := OPProject named: 'RootModelRemovalTest'.
	standaloneRoot := OPTestModelObject new.
	standaloneRoot name: 'RootElement'.
	testProject addModel: standaloneRoot.
	projectController := OPProjectController forProject: testProject.
	viewModelRegistry := projectController viewModelRegistry.
	rootViewModel := viewModelRegistry viewModelFor: standaloneRoot.

	self assertCollection: testProject models hasSameElements: { standaloneRoot }.

	rootViewModel basicRemoveModel.

	self assertEmpty: testProject models.

	rootViewModel registerModelIn: testProject.
	self assertCollection: testProject models hasSameElements: { standaloneRoot }
]

{ #category : 'tests' }
OPModelObjectViewModelTest >> testUnsubscribeStopsForwardingModelAnnouncements [

	| testProject standaloneRoot projectController rootViewModel forwardedCount |
	testProject := OPProject named: 'UnsubscribeTest'.
	standaloneRoot := OPTestModelObject new name: 'Root'.
	testProject addModel: standaloneRoot.
	projectController := OPProjectController forProject: testProject.
	rootViewModel := projectController viewModelRegistry viewModelFor: standaloneRoot.

	forwardedCount := 0.
	rootViewModel announcer when: OPModelChanged do: [ :ann | forwardedCount := forwardedCount + 1 ] for: self.
	standaloneRoot name: 'FirstChange'.
	self assert: forwardedCount equals: 1.

	rootViewModel unsubscribeFromModel.
	standaloneRoot name: 'SecondChange'.
	self assert: forwardedCount equals: 1
]

{ #category : 'constants' }
OPModelObjectViewModelTest >> viewModelClass [

	^ OPTestModelObjectViewModel
]
