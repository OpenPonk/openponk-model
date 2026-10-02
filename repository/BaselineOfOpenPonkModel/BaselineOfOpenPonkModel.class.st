"
I am a baseline for https://github.com/OpenPonk/openponk-model
"
Class {
	#name : 'BaselineOfOpenPonkModel',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfOpenPonkModel',
	#package : 'BaselineOfOpenPonkModel'
}

{ #category : 'baselines' }
BaselineOfOpenPonkModel >> baseline: spec [

	<baseline>
	spec for: #common do: [
			spec
				baseline: 'OpenPonk'
				with: [ spec repository: 'github://OpenPonk/openponk' ].
			spec package: 'OpenPonk-Model'.
			spec
				group: 'plugin' with: #( 'OpenPonk-Model' );
				group: 'default' with: #( 'OpenPonk' 'plugin' ) ]
]
