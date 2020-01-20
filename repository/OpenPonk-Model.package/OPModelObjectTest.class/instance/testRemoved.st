tests
testRemoved
	diagram add: element.
	self assert: element owner isNotNil.
	diagram remove: element.
	self assert: element owner isNil