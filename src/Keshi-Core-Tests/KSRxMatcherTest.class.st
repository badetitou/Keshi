"
A KSRxMatcherTest is a test class for testing the behavior of KSRxMatcher
"
Class {
	#name : #KSRxMatcherTest,
	#superclass : #TestCase,
	#category : #'Keshi-Core-Tests'
}

{ #category : #test }
KSRxMatcherTest >> testMatches [

	self assert: ('a.*?com' asKSRegex matches: 'a is a test com blah blah').
]

{ #category : #test }
KSRxMatcherTest >> testParse [
	(KSRxMatcher new parse: '^helloworld$').
	self assert: true.
]
