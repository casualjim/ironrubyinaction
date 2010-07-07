using System;
using Microsoft.Scripting;
using Microsoft.Scripting.Hosting;
using IronRuby;

namespace DLRHost
{
    class Program
    {
        static void Main(string[] args)
        {
            ScriptRuntime runtime = Ruby.CreateRuntime();
            ScriptEngine engine = Ruby.GetEngine(runtime);
            ScriptScope scope = engine.CreateScope();
            scope.SetVariable("txt", "IronRuby is awesome!");
            engine.Execute("def self.upper; txt.to_upper; end;", scope);

            string result = scope.GetVariable<Func<string>>("upper")();
            Console.WriteLine("The result is: " + result);
            Console.WriteLine("");

            Console.WriteLine("Press any key to close...");
            Console.ReadKey();

            // Outputs the following:
            // The result is: IRONRUBY IS AWESOME
        }
    }
}
