"
Tests baseline view model behavior, property notification, and change propagation for core model objects.
"
Class {
	#name : 'OPModelObjectViewModelTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-Model-Tests',
	#package : 'OpenPonk-Model',
	#tag : 'Tests'
}

{ #category : 'tests' }
OPModelObjectViewModelTest >> testRemoveRootModelWithoutOwnerRemovesFromProject [
	| project rootModel projectController viewModelRegistry viewModel |
	project := OPProject named: 'RootModelRemovalTest'.
	rootModel := OPTestModelObject new.
	rootModel name: 'RootElement'.
	project addModel: rootModel.
	projectController := project controllerClass new.
	projectController project: project.
	viewModelRegistry := projectController viewModelRegistry.
	viewModel := viewModelRegistry viewModelFor: rootModel.

	self assertCollection: project models hasSameElements: { rootModel }.

	"Must fail in red phase with MessageNotUnderstood: UndefinedObject >> #remove:"
	viewModel basicRemoveModel.

	self assertCollection: project models hasSameElements: #( ).

	"Verify mirror restoration for Undo"
	viewModel registerModelIn: project.
	self assertCollection: project models hasSameElements: { rootModel }
]
