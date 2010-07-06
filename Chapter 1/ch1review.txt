* Listing 1.1 setting strings does not output.
* text following listing1.3 missing "as".
* Listing 1.3 for completeness, should have a line showing a.to_s.class.name when a holds a fixnum and set a to "hello" instead of "123".
* pg 7 Duck Typing - clarify which methods by adding "calling" and "called". Calling method could also just be "caller". Further down, "callee" is used instead of "caller". It might help those familiar with C# to note that duck typing is sort of an implicit interface declaration. In other words, having a print method is similar to telling the method it needs an IPrintable { void Print(); }.
* rework the last paragraphs of 1.2.2.
* pg 9 last para states we will look at eval and then diff ways to run IR. Remove the eval sentence.
* pg 12 last few paras have grammar mistakes. Also, change "may" to "will". This isn't choose your own adventure!
* pg 13 introduce iirb without comment and when ir would work just as well.
* 1.4.1 decoupled code "flows naturally" from testing? Maybe, but a more concrete statement is that the seams are more apparent and it's easier to write tests for loosely coupled code. One can still write monolithic tests and derive monolithic code, but it's more painful. Also, why do I care about loose coupling? Consider an aside or footnote to a explanation of coupling and cohesion. Jeremy Miller's MSDN article is a good one.
* Pg 14 why is runtime type checking less than ideal? Earlier you noted that runtime checking allowed additional possibilities. Am I now to think this is bad? In addition, why do I care about types at all? When thinking about unit testing, I shouldn't be overly concerned with types but rather behavior. Types are only important when the wrong type is being used for my constraints: fixnum when I need bignum or array when I want lazylist. Yes you can add type oriented unit tests, but most type errors can be found by testing behavior.
* listing 1.20 has the fail after the unless, which breaks outside of a block. Need to use the source code version, but fix source to throw NoMethodError instead of TypeError.
* 1.5 and 1.6 should be merged.
