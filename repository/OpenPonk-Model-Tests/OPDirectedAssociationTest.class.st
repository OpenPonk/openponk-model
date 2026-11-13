"
Unit tests for directed binary relationship creation and source/target accessors.
"
Class {
	#name : 'OPDirectedAssociationTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-Model-Tests-ModelObjects',
	#package : 'OpenPonk-Model-Tests',
	#tag : 'ModelObjects'
}

{ #category : 'tests' }
OPDirectedAssociationTest >> testCreationWithSourceTargetAndName [
	| source target unnamed named |
	source := OPModelObject named: 'Source'.
	target := OPModelObject named: 'Target'.

	unnamed := OPDirectedAssociation from: source to: target.
	self assert: unnamed source identicalTo: source.
	self assert: unnamed target identicalTo: target.
	self assert: unnamed name equals: ''.

	named := OPDirectedAssociation from: source to: target named: 'uses'.
	self assert: named source identicalTo: source.
	self assert: named target identicalTo: target.
	self assert: named name equals: 'uses'
]
