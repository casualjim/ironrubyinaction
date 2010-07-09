csc /out:hello-world.exe /target:exe hello-world.cs
csc /out:Listing1.1.exe /target:exe Listing1.1.cs
csc /out:Listing1.2.exe /target:exe Listing1.2.cs
csc /out:Listing1.6.exe /target:exe Listing1.6.cs
csc /out:CSharp.exe /target:exe /m:CSharp.Program /recurse:Listing1.1*.cs
