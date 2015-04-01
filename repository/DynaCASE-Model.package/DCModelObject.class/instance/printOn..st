as yet unclassified
printOn: aStream
	super printOn: aStream.
	aStream
		nextPutAll: '(''';
		nextPutAll: self name;
		nextPutAll: ''')'