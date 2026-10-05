Class {
	#name : 'OPModelObjectSerializationTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-Model-Tests',
	#package : 'OpenPonk-Model',
	#tag : 'Tests'
}

{ #category : 'tests' }
OPModelObjectSerializationTest >> testMaterializeDiagramAfterCreatingElementWithoutPriorUuidAccess [
	| model element diagram shape serializedModelStream serializedDiagramStream loadedModel loadedDiagram |
	model := OPTestModelObject new name: 'TestModel'.
	element := OPTestModelObject new name: 'TestEntity'.
	model add: element.

	diagram := OPOpenPonkDiagram new.
	shape := OPTestDiagramElement new.
	shape modelElement: element.
	shape owningElement: diagram.
	diagram ownedElements add: shape.

	"1. Serialize model to STON without calling element uuid beforehand"
	serializedModelStream := WriteStream on: String new.
	OPStonModelSerializer new serializeModel: model to: serializedModelStream.

	"2. Serialize diagram to STON - triggers lazy UUID generation on in-memory element"
	serializedDiagramStream := WriteStream on: String new.
	OPStonDiagramSerializer new serializeDiagram: diagram to: serializedDiagramStream.

	"3. Materialize model from STON"
	loadedModel := OPStonModelSerializer new materializeModelFrom: serializedModelStream contents readStream.

	"4. Materialize diagram from STON using loaded model - non-interactively trap OPDiagramInvalid as failure"
	[
		loadedDiagram := OPStonDiagramSerializer new
			materializeDiagramOf: loadedModel
			from: serializedDiagramStream contents readStream.
	] on: OPDiagramInvalid do: [ :warning |
		self fail: 'Diagram materialization signaled OPDiagramInvalid: ' , warning messageText ].

	self assert: loadedDiagram ownedElements isNotEmpty.
	self assert: loadedDiagram ownedElements first modelElement equals: loadedModel elements first
]

{ #category : 'tests' }
OPModelObjectSerializationTest >> testUuidIsInitializedOnCreation [
    | modelObject slotValue |
    modelObject := OPModelObject new.
    slotValue := modelObject instVarNamed: #uuid.
    self assert: slotValue isNotNil description: 'Model object uuid slot must not be nil upon creation'.
    self assert: (slotValue isKindOf: UUID) description: 'Model object uuid must be a UUID instance'
]
