.assembly helloworld {}

.method public hidebysig static void Main() cil managed
{
  	.entrypoint

  	ldstr	"Hello, World!!!"
  	call	void [mscorlib]System.Console::WriteLine(string)
  	ret
}
