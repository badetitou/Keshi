Class {
	#name : #BaselineOfKeshi,
	#superclass : #BaselineOf,
	#category : #BaselineOfKeshi
}

{ #category : #baselines }
BaselineOfKeshi >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self defineDependencies: spec.
			self definePackages: spec.
			self defineGroups: spec ]
]

{ #category : #baselines }
BaselineOfKeshi >> defineDependencies: spec [
]

{ #category : #baselines }
BaselineOfKeshi >> defineGroups: spec [
]

{ #category : #baselines }
BaselineOfKeshi >> definePackages: spec [
	spec
		package: 'Keshi-Core';
		package: 'Keshi-Core-Tests' with: [ spec requires: #('Keshi-Core')]
]
