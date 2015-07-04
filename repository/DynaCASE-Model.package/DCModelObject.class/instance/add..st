adding
add: anElement
	(elements includes: anElement)
		ifTrue: [ ^ self ].
	anElement addedTo: self.
	elements add: anElement.
	anElement when: DCElementChanged send: #changed to: self.
	self announceAdded: anElement