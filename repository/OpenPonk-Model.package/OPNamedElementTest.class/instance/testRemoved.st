tests
testRemoved
	| diagram el |
	diagram := OPDiagram new.
	el := OPModelElement new.
	diagram add: el.

	diagram remove: el.
	self assert: el owner isNil