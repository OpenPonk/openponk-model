"
View model for OPModelObject.
Serves as the structural bridge for basic metamodel elements, handling domain logic and exposing child models, dependencies, and hierarchy queries without holding direct GUI references.
"
Class {
	#name : 'OPModelObjectViewModel',
	#superclass : 'OPViewModel',
	#category : 'OpenPonk-Model-ViewModels',
	#package : 'OpenPonk-Model',
	#tag : 'ViewModels'
}

{ #category : 'testing' }
OPModelObjectViewModel class >> isAbstract [

	^ self = OPModelObjectViewModel
]

{ #category : 'removing' }
OPModelObjectViewModel >> basicRemoveModel [
	"Specific domain model removal logic - removal from owner, disconnecting from peers, etc."

	self model owner
		ifNotNil: [ :modelOwner | modelOwner remove: self model ]
		ifNil: [
			self projectViewModel ifNotNil: [ :theProjectViewModel |
				theProjectViewModel model ifNotNil: [ :theProject |
					theProject removeModel: self model ] ] ]
]

{ #category : 'accessing' }
OPModelObjectViewModel >> childrenModels [

	^ super childrenModels , self model ownedElements
]

{ #category : 'accessing' }
OPModelObjectViewModel >> creationPriority [
    "Lower number means earlier rendering. Nodes are drawn before edges."
    ^ 10
]

{ #category : 'accessing' }
OPModelObjectViewModel >> dependentElements [

	^ super dependentElements , self model relatedElements asArray
]

{ #category : 'accessing' }
OPModelObjectViewModel >> findParentViewModel [

	| modelOwner |
	modelOwner := self model owner.
	modelOwner ifNil: [ ^ self registry projectViewModel ].
	^ self registry viewModelFor: modelOwner
]

{ #category : 'accessing' }
OPModelObjectViewModel >> icon [ ^ OPCoreIcons openponkIcon
]

{ #category : 'initialization' }
OPModelObjectViewModel >> subscribeToModel [

	self model announcer
		when: Announcement
		do: [ :ann | self announcer announce: ann ]
		for: self
]

{ #category : 'private' }
OPModelObjectViewModel >> unsubscribeFromModel [

	self model announcer unsubscribe: self
]
