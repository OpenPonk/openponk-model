tests
testAdd
	| added changed |
	added := nil.
	changed := nil.
	diagram when: DCElementAdded do: [ :event | added := event element ].
	diagram when: DCElementChanged do: [ :event | changed := event element ].
	diagram add: element.

	self assert: added equals: element.
	self assert: changed equals: diagram.
	self assertCollection: diagram ownedElements hasSameElements: {element}