tests
testAdded
	| diagram el |
	diagram := OPDiagram new.
	el := OPModelElement new.

	diagram add: el.
	self assert: el owner = diagram