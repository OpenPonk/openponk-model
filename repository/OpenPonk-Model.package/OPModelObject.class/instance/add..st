adding
add: anElement
	(elements includes: anElement)
		ifTrue: [ ^ self ].
	anElement addedTo: self.
	elements add: anElement.
	anElement when: OPElementChanged do: [ self changed ].
	self announceAdded: anElement