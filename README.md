# OpenPonk: Model

[![Nightly](https://github.com/OpenPonk/openponk-model/actions/workflows/nightly.yml/badge.svg)](https://github.com/OpenPonk/openponk-model/actions/workflows/nightly.yml) [![Coverage Status](https://coveralls.io/repos/github/OpenPonk/openponk-model/badge.svg?branch=master)](https://coveralls.io/github/OpenPonk/openponk-model?branch=master)

Optional foundational domain metamodel for the [OpenPonk](https://openponk.org) platform providing common base classes (`OPModelObject`, `#uuid`, announcements, associations, and base view models) used by notations such as BORM, BPMN, Petri Nets, FSM, Markov Chains, ERD, and DEMO.

## Installation

See [openponk.org/#direct-installation](https://openponk.org/#direct-installation) for the supported Pharo version.

```smalltalk
Metacello new
	baseline: 'OpenPonkModel';
	repository: 'github://OpenPonk/openponk-model';
	load.
```

## Documentation

Part of the [OpenPonk](https://openponk.org) platform. For architecture, the repository catalog, and contributing guidelines, see [`OpenPonk/.github`](https://github.com/OpenPonk/.github/blob/main/profile/README.md).
