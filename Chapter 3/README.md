* General note: once you introduce an acronym, there's no reason to continue using the full name.
* Section 3.1.3 paragraph 2 following Figure 3.2 states, "And Microsoft will be adding more parallel computing goodness in the version after the 3.5 version of the framework," but should state "Microsoft added more parallel computing goodness to .NET 4.0 in the form of the parallel extensions." If you want to add a footnote, you could use http://msdn.microsoft.com/en-us/concurrency/.
* Section 3.1.4 paragraph 1 You use BCL and the Framework Class Library as though the latter is a separate component. The FCL is a superset of the BCL that includes the Microsoft.* namespaces. Since you introduced the second part originally as the Framework Class Library, you should stick to that here and just note that it includes the BCL.
* Section 3.2 paragraph 1 You again use BCL instead of FCL when adding the DLR into the mix. For consistency, you should either replace FCL with BCL throughout or switch this to FCL. I prefer the latter.
* Figure 3.3 Would be nice to see the pink section labeled DLR for clarity. Also, the CLR is underneath, but there is no indication of what role it plays. Consider removing it or showing how the CLR adds to the diagram.
* Section 3.2.1 paragraph following Figure 3.3 you state, "In the first chapter I said that the DLR generates IL that isn’t completely true. The DLR is actually a little smarter about it than that, because generating IL wouldn’t be as efficient as the way it is done now," but through the remainder of the section you don't explain this thought. Consider completing the thought about why translation to an AST first is more efficient and also describe how the AST becomes IL.
* Section 3.2.2 paragraph 1 should add a parenthesis to have the reader look to Chapter 12 so that the idea of "extending IronRuby" isn't as incredulous as it may first appear.
* Section 3.2.2 paragraph 1 following Listing 3.1 states, "issue the command rbx ..." but should state, "issue the command ir ...."
* Section 3.2.2 paragraph 4 "just about every operation needs a lookup." What sorts of things constitute exceptions to this statement?
* Section 3.2.2 paragraph 4 Need to verify that this statement is still true: "When an operation is repeated a number of times the script engine will generate the IL for it directly and cache that." Also, what is "a number of times"? Is there a threshhold?
* Section 3.3 paragraph 2 Why is "Shared Dynamic Type System" capitalized but "shared dynamic host system" not?
* Section 3.3.1 paragraph 1 managed JavaScript is no longer available. You could switch that to IronJS.
* Section 3.3.2 paragraph 1 the url http://blogs.msdn.com/ironpython/archive/2008/03/16/dlr-resources.aspx is now http://blogs.msdn.com/b/ironpython/archive/2008/03/16/dlr-resources.aspx. The old url will redirect, but who knows for how long?
* Listing 3.2 to create the runtime, you must use Ruby.CreateRuntime(), not IronRuby.CreateRuntime().

