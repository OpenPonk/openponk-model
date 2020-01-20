announcing
announceRemoved: anElement
	self announce: (OPElementRemoved element: anElement).
	anElement announce: (OPElementRemoved element: anElement).
	self changed