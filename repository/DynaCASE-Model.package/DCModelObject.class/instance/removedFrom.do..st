removing
removedFrom: anOwner do: aBlock
	self deprecated: 'Use removeFrom: instead'.
	self assert: self owner = anOwner.
	aBlock value.
	owner := nil.
	self changed