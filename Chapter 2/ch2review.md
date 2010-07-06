* General note: Listings should match the source filenames or note the source filename. Source files using the Listing2.x.rb should match the listing number in the book.
* Listing 2.1 does not include the attr_readers for the name, artist, and songs members though they are unnecessary for the text sample. They are necessary for the tests in the source code, though.
* Chapter 2 page 6 starts with the result of running fixnum_times.rb but shows numbers.rb as the sorce file name. The text just following, though possibly unrelated reads 5.times though the sample uses 6.times. Consider changing the 5 to 6 for consistency. Finally, listing2.5.rb is unrelated to fixnum_times.rb. It also is out of order in terms of listings in the book. The previous book listing is 2.2.
* Collections of objects, just after listing 2.5 notes that ruby arrays hold any type twice. May also note it's similar to object[], ArrayList, or List<object>
* Chapter 2 page 7 starts with the result of running arrays.rb but shows collections.rb as the sorce file name. Finally, listing2.6.rb is unrelated to arrays.rb.
* Listing 2.6 has "get the 4the" which should be "get the 4th". This is also in the source file.
* Listing 2.7 is unrelated to source file listing2.7.rb. Figure 2.5 shows the correct file: hash.rb.
* Listing 2.7 does not set the value of hello, though the value is set in the source file.
* Listing 2.8 is listing2.4.rb in the source files. The listing does not show which files to require.
* Listing 2.8 requires attr_reader :name,  :artist, :songs to be in listing2.1.rb. You've not discussed attr_* nor noted the need for this, though it is on the source files.
* In Listing 2.8, test_should_should_append_new_item only tests setup, not append. In addition, the assertion syntax is not consistent, nor do you mention why you break convention.
* test_should_remove_an_item_with_a_given_name doesn't test by name but by object. Either change the name of the test or make sure the object can be removed when remove is passed the album's name alone. Otherwise, your implementation is leaking out into your test.
* Figure 2.6 shows you running the test with a command `testrb` calling into a `test` folder. This doesn't match the actual source file structure or previous use of `ir Listing2.3.rb`. The source file structure should match use in the text.
* Listing 2.9 is Listing 2.4 in the source code repository.
* Listing 2.10 is strings.rb, as the output in Figure 2.7 shows.
* Listing 2.11 is regular_expressions.rb, as the output in Figure 2.8 shows.
* First paragraph of section 2.2 reads "executions paths" but should read "execution paths".
* Second paragraph of section 2.2 reads "controls structures" but should read "control structures".
* End of paragraph 2 of section 2.2 would be better leaving off at "other sources" with a footnote to other Manning publications.
* Figure 2.9 shows a filename of ifthenelse.rb, but the source file is Listing2.5.rb.
* Listing 2.12 is actually Listing2.5.rb in the source files. These should be aligned.
* The final line of Listing 2.12 should read "Thank you for using my services." in order to align with the source file.
* The paragraph following Listing 2.12 says you've just introduced `unless` though you've already used it several times. Further, this seems a great place for a sidebar or at least an explanation that the '?' following the method name is convention and allowed as part of method names (along with '!').
* Figure 2.10 shows a filename of casewhen.rb, but the source file is Listing2.6.rb.
* Listing 2.13 is actually Listing2.6.rb in the source files. These should be aligned.
* Listing 2.13 uses different forms of `when` syntax with no comments as to the differences. Consider adding comments or text to note the different forms of `when` statements.
* Figure 2.11 shows a filename of loops.rb, but the source file is Listing2.7.rb.
* Listing 2.14 is actually Listing2.7.rb in the source files. These should be aligned.
* Listing 2.14 introduces the ternary operator without noting it. Consider adding a comment or text introducing the operator.
* Listing 2.14 reads "May I can be of ..." and should probably read either "Maybe I can be of ..." or "May I be of ...".
* Section 2.3 paragraph 1 sentence 2 states, "We speak of functions as first class citizens when we can create functions at runtime." However, whenever I've seen this mentioned in other places (primarily functional programming texts), first-class functions means functions that do not need to be contained within another type and can be passed around like other objects. The next sentence seems to embody this sentiment correctly.
* Section 2.3 paragraph 1 sentence 4 derails the flow of the first sentences. Consider revising to state that first-class functions such as blocks enable advanced features such as iterators, which allow additional looping constructs.
* Figure 2.12 shows code_blocks.rb as the source file when it's really codeblocks.rb (minor, I know, but this should probably match the listing number).
* Listing 2.15 is really codeblocks.rb in the source files.
* Figure 2.13 shows code_blocks_parameters.rb as the source file when it's really Listing2.8.rb.
* Listing 2.16 introduces the %w() syntax, which has not yet been introduced. It also introduces the `rand` function, which has not yet been introduced but is fairly understandable from the comments.
* Figure 2.14 shows transactional_resource.rb as the source file when it is actually Listing2.11.rb (source files skip 2.9 and 2.10).
* Listing 2.17 is actually Listing2.11.rb. 
* Listing2.11.rb (Listing 2.17) contains an using block monkey patch for Object. Is that supposed to be in there?
* Listing 2.18 is iterators.rb, as per Figure 2.15.
* Figure 2.16 shows album_list_with_iterator.rb as the source file but it is really Listing2.12.rb. Also, the text's code listing does not list the proper require statement.
* Section 2.3.4 paragraph 2 seems to be flipped in terms of defining the effect of closures with Proc and lambda. When I read "declaring context", I think of the method defining the func, not the func itself. Likewise, "returns return from the context of the closure" indicates, to me, the internals of the func. Adding "Immediately ..." to the beginning of that last sentence would be better. Listing 2.20's comments do a good job of clearing the confusion, but the text should probably be made clearer, as well.
* Section 2.3.4 next to last paragraph is specific to the with_proc method, but that is not quite clear since the paragraph seems to be talking about how func.call makes defines a closure. I'm not sure I agree with this statement either. func.call makes it a function, not a closure. Technically, a closure needs to close over some internal state, and neither of the examples do that. These examples are more inline methods.
* Listing 2.21 is song_ops.rb in the source files. Also, you've not yet introduced default parameters. Consider including either a comment or an introduction in the text.
* Listing 2.22 is actually song.rb. This listing needs to be updated. The output shows the expected result as an *upcase*, not *capitalize*. The actual expected output should be 'Ruby tuesday'
* Listings in the text skip 2.23.
* Listing 2.24 is actually song_ops_mixin.rb.
* Listing 2.25 is actually song_mixin.rb. The required reference is incorrect. It should reference 'song_ops_mixin'.
* Section 2.5.1 paragraph 2 states, "it calls the method missing method ...". Elsewhere, this is denoted as `method_missing`. Further, you note in the first paragraph that IronRuby will throw a System.MissingMethodException that you can intercept, but here you state that it's merely IronRuby's default implementation. I believe this latter description is correct. You should change the first paragraph to reflect this or remove the statement about IronRuby from the first paragraph altogether.
* _why's quote is no longer available at the url provided since he took down his site.
* Listing 2.26 is actually Listing2.13.rb.
* Listing 2.26 introduces `<<`, `reject`, and `p`. Consider adding a comment or text noting their use.
* Listing 2.26 includes `search_by_artist` which is never used nor noted. I'm not sure if this is intended.
* Listing 2.26 notes that "The method nonexisting_Kravitz doesn't exist" was expected but without the quotes. The expected output should expect quotes around the text, just like the previous expectations.
* Listing 2.27 is actually displayer.rb.
* Section 2.5.2 seems incomplete without commenting on undef_method and remove_method as these go hand-in-hand with define_method.
* Listing 2.28 is actually Listing2.14.rb.
* The first paragraph following Listing 2.28 notes the use of "chomp" but does not explicitly relate the description of removing the newline character to that method. Consider relating the two for readers unfamiliar with Ruby.
* Listing 2.29 is actually Listing2.15.rb.
* Listing 2.29 requires the wrong file. It should require Listing2.14.
* The expected results for Lisitng 2.29 do not match the provided source files.
