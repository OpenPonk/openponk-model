baseline
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec package: 'OpenPonk-Model'.
			spec group: 'default' with: #('OpenPonk-Model') ]