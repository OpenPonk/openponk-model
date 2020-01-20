accessing
elementNamed: aName
	^ self elements detect: [ :each | each name = aName ]