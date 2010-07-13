csc /out:HelloWorld.exe /target:exe /nowarn:1685 /r:Microsoft.Dynamic.dll,Microsoft.Scripting.Core.dll,Microsoft.Scripting.dll,IronRuby.dll HelloWorld.cs
csc /out:HostScriptHost.exe /target:exe /nowarn:1685 /r:Microsoft.Dynamic.dll,Microsoft.Scripting.Core.dll,Microsoft.Scripting.dll,IronRuby.dll HostScriptHost.cs
csc /out:HandleStringAdded.exe /target:exe /nowarn:1685 /r:Microsoft.Dynamic.dll,Microsoft.Scripting.Core.dll,Microsoft.Scripting.dll,IronRuby.dll /recurse:StringAdder.cs HandleStringAdded.cs
csc /out:demo.exe /target:exe /nowarn:1685 /r:Microsoft.Dynamic.dll,Microsoft.Scripting.Core.dll,Microsoft.Scripting.dll,IronRuby.dll demo.cs
