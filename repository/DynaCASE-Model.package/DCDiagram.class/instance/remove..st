removing
remove: anElement
	anElement announcer unsubscribe: self.
	elements remove: anElement.
	anElement removedFrom: self.
	self changed.
	self announce: (DCElementRemoved element: anElement)