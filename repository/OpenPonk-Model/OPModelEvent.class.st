"
I am a base class for model events.
"
Class {
	#name : 'OPModelEvent',
	#superclass : 'OPEvent',
	#instVars : [
		'model'
	],
	#category : 'OpenPonk-Model-Announcements',
	#package : 'OpenPonk-Model',
	#tag : 'Announcements'
}

{ #category : 'instance creation' }
OPModelEvent class >> model: aModel [
	^ self new
		model: aModel;
		yourself
]

{ #category : 'accessing' }
OPModelEvent >> model [
	^ model
]

{ #category : 'accessing' }
OPModelEvent >> model: aModel [
	model := aModel
]
