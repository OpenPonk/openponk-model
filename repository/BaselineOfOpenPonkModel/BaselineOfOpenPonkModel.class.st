"
I am a baseline for https://github.com/OpenPonk/openponk-model
"
Class {
	#name : 'BaselineOfOpenPonkModel',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfOpenPonkModel',
	#package : 'BaselineOfOpenPonkModel'
}

{ #category : 'baseline' }
BaselineOfOpenPonkModel >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec package: 'OpenPonk-Model'.
			spec group: 'default' with: #('OpenPonk-Model') ]
]
