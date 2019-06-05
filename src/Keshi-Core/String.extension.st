Extension { #name : #String }

{ #category : #'*Keshi-Core' }
String >> asKSRegex [
	"just a hack for now"
	"Compile the receiver as a regex matcher. May raise RxParser>>syntaxErrorSignal
	or RxParser>>compilationErrorSignal.
	This is a part of the Regular Expression Matcher package, (c) 1996, 1999 Vassili Bykov.
	Refer to `documentation' protocol of RxParser class for details."

	^KSRxMatcher new parse: self
]
