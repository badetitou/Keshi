Class {
	#name : #KSRxMatcher,
	#superclass : #Object,
	#instVars : [
		'regex',
		'stream',
		'markerPositions'
	],
	#category : #'Keshi-Core'
}

{ #category : #'as yet unclassified' }
KSRxMatcher >> matches: aString [
	"Match against a string. Return true if the complete String matches.
	If you want to search for occurences anywhere in the String see #search:"

	^self matchesStream: aString readStream
]

{ #category : #'as yet unclassified' }
KSRxMatcher >> matchesStream: theStream [
	"Match thyself against a positionable stream."

	^(self matchesStreamPrefix: theStream)
		"and: [stream atEnd]"
]

{ #category : #'as yet unclassified' }
KSRxMatcher >> matchesStreamPrefix: theStream [
	"Match thyself against a positionable stream."

	stream := theStream.
	markerPositions := nil.
	^self tryMatch
]

{ #category : #'as yet unclassified' }
KSRxMatcher >> parse: aString [ 
	"Should probably do checking, but not worth it?"
	regex := aString.
]

{ #category : #'as yet unclassified' }
KSRxMatcher >> tmpMatchesZone [
	^ FileLocator temp asFileReference / 'keshimatches.txt'
]

{ #category : #'as yet unclassified' }
KSRxMatcher >> tmpStreamZone [
	^ FileLocator temp asFileReference / 'keshistream.txt'
]

{ #category : #'as yet unclassified' }
KSRxMatcher >> tmpZone [
	^ FileLocator temp asFileReference / 'keshistream' 
]

{ #category : #'as yet unclassified' }
KSRxMatcher >> tryMatch [
	"Match thyself against the current stream using perl."

	| command result |
	"use an environment variable for the regex - simplifies quoting"
	OSEnvironment current setEnv: 'keshiregex' value: regex.
	"save the stream to search to a file to be used in perl"
	self tmpStreamZone
		ensureDelete;
		writeStreamDo: [ :fileStream | fileStream nextPutAll: stream contents ].
	"https://www.tutorialspoint.com/perl/perl_regular_expressions.htm"
	command := 'perl '
		,
			(OSPlatform current isWindows
				ifTrue: [ self windowsCmd ]
				ifFalse: [ ' -0777 -n -e ''while(m/$ENV{keshiregex}/mcg){print ""$&\n"";}'' ""' , self tmpStreamZone fullName , '"" > ""' , self tmpMatchesZone fullName , '""' ]).
	result := LibC runCommand: command.
	result = 0 ifFalse: [ 0 halt ].
	^ self tmpMatchesZone contents size ~= 0
]

{ #category : #'as yet unclassified' }
KSRxMatcher >> windowsCmd [
	^ '-n -e "while(m/%keshiregex%/mcg){print $&^\n;}" "', (self tmpStreamZone fullName),'" > "', ((self tmpMatchesZone fullName), '"')
]
