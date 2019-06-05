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
	self assert: ('^(?:\w+:)?\/\/([^\s\.]+\.\S{2}|localhost[\:?\d]*)\S*$' asKSRegex matches: 'https://www.thisisatest.com/bhal').
	self deny: ('^(?:\w+:)?\/\/([^\s\.]+\.\S{2}|localhost[\:?\d]*)\S*$' asKSRegex matches: 'www.thisisatest.com/bhal').
	


]

{ #category : #test }
KSRxMatcherTest >> testParse [
	(KSRxMatcher new parse: '^helloworld$').
	self assert: true.
]
