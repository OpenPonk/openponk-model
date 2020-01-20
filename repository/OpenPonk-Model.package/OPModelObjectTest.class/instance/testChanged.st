tests
testChanged
	| changed |
	changed := nil.
	element
		when: OPElementChanged
		do: [ :event | changed := event element ].
	self assert: changed isNil.
	changed := nil.
	element name: 'a name'.
	self assert: changed equals: element.
	changed := nil.
	diagram add: element.
	self assert: changed equals: element.
	changed := nil.
	diagram remove: element.
	self assert: changed equals: element