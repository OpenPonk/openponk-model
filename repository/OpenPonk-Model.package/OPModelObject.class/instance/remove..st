removing
remove: anElement
	(elements includes: anElement)
		ifFalse: [ ^ self ].
	anElement announcer unsubscribe: self.
	anElement removeFrom: self.
	elements remove: anElement.
	self announceRemoved: anElement