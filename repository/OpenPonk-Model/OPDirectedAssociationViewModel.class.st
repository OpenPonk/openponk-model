"
View model for OPDirectedAssociation.
Handles domain logic specific to directed relationships, exposing the underlying source and target model elements to higher architectural layers.
"
Class {
	#name : 'OPDirectedAssociationViewModel',
	#superclass : 'OPModelObjectViewModel',
	#category : 'OpenPonk-Model-ViewModels',
	#package : 'OpenPonk-Model',
	#tag : 'ViewModels'
}

{ #category : 'testing' }
OPDirectedAssociationViewModel class >> isAbstract [

	^ self = OPDirectedAssociationViewModel
]

{ #category : 'accessing' }
OPDirectedAssociationViewModel >> creationPriority [
    "Edges are drawn after nodes."
    ^ 20
]

{ #category : 'accessing' }
OPDirectedAssociationViewModel >> dependingOnElements [
	^ super dependingOnElements , (Set
	   with: (self modelSource ifNil: [ self error: 'There is no source of ' , self model asString ])
	   with: (self modelTarget ifNil: [ self error: 'There is no target of ' , self model asString ]))
]

{ #category : 'printing' }
OPDirectedAssociationViewModel >> modelDisplayStringOn: aStream [

	self model name ifNotEmpty: [ :n |
		^ super modelDisplayStringOn: aStream ].

	aStream
		nextPutAll: (self model source
				 ifNotNil: [ :s | s name ifEmpty: [ s className ] ]
				 ifNil: [ '?' ]);
		nextPutAll: ' -> ';
		nextPutAll: (self model target
				 ifNotNil: [ :t | t name ifEmpty: [ t className ] ]
				 ifNil: [ '?' ]).

	aStream
		space;
		nextPut: $(;
		nextPutAll: self nameOfType;
		nextPut: $)
]

{ #category : 'accessing' }
OPDirectedAssociationViewModel >> modelSource [

	^ self model ifNotNil: [ :foundModel | foundModel source ]
]

{ #category : 'accessing' }
OPDirectedAssociationViewModel >> modelTarget [

	^ self model ifNotNil: [ :foundModel | foundModel target ]
]
